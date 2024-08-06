import 'dart:math';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'background.dart';
import 'header.dart';
import 'home.dart';

class CountAndFillPage extends StatefulWidget {
  @override
  _CountAndFillPageState createState() => _CountAndFillPageState();
}

class _CountAndFillPageState extends State<CountAndFillPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Stack(
            children: [
              BackgroundGradient(),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).size.height * 0.20),
                  Expanded(
                    child: CountAndFillPageScreen(),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.11),
                ],
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.10,
                left: MediaQuery.of(context).size.width * 0.15,
                child: const Text(
                  'Learn to Count',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                  ),
                ),
              ),
              HomeWidget(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
              ),
              MenuWidget(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
              ),
              ScoreWidget(),
              LanguageWidget(),
            ],
          );
        },
      ),
    );
  }
}

class CountAndFillPageScreen extends StatefulWidget {
  @override
  _CountAndFillPageScreenState createState() => _CountAndFillPageScreenState();
}

class _CountAndFillPageScreenState extends State<CountAndFillPageScreen> {
  int _targetNumber = 1;
  int _currentCount = 0;
  Random _random = Random();

  final player = AudioCache();
  final FlutterTts flutterTts = FlutterTts();

  List<Widget> _droppedBalls = [];

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void restartGame() {
    setState(() {
      timeLeft = 30; // Reset the timer
      isBlinking = false; // Stop blinking
      generateNewTarget();
    });
  }

  void generateNewTarget() {
    setState(() {
      _targetNumber = _random.nextInt(10) + 1;
      _currentCount = 0;
      _droppedBalls = [];
    });
  }
  Timer? timer;
  int timeLeft = 30;
  bool isBlinking = false;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        timeLeft--;
        if (timeLeft == 0) {
            // Handle when time runs out
          timer?.cancel(); // Stop the timer
          generateNewTarget(); // Reset the game
          timeLeft = 30; // Reset the timer to 60 seconds
          startTimer();
        } else if (timeLeft <= 5) {
          // Start blinking when time is less than or equal to 5 seconds
          isBlinking = !isBlinking;
        }
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundGradient(),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.1,
            left: MediaQuery.of(context).size.width * 0.4,
            child: Text(
              '$_targetNumber',
              style: TextStyle(
                fontSize: 100,
                color: Colors.yellow,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.2,
            left: MediaQuery.of(context).size.width * 0.1,
            child: Row(
              children: List.generate(1, (index) {
                return Draggable<int>(
                  data: 1,
                  child: _appleWidget(),
                  feedback: _appleWidget(),
                  childWhenDragging: _appleWidget(opacity: 0.5),
                );
              }),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.07,
            right: MediaQuery.of(context).size.width * 0.1,
            child: DragTarget<int>(
              builder: (context, candidateData, rejectedData) {
                return Container(
                  height: 400,
                  width: 400,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.yellow, width: 5),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.transparent,
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Text(
                          '$_currentCount / $_targetNumber',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ..._droppedBalls,
                    ],
                  ),
                );
              },
              onAccept: (data) {
                setState(() {
                  _currentCount += data;
                  _addDroppedBall();
                });
                if (_currentCount == _targetNumber) {
                  _showCongratulationDialog();
                }
              },
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.02,
            right: MediaQuery.of(context).size.width * 0.1,
            child: Text(
              '$timeLeft',
              style: TextStyle(
                fontSize: 50,
                color: isBlinking ? Colors.red : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _appleWidget({double opacity = 1.0}) {
    return Opacity(
      opacity: opacity,
      child: Image.asset(
        'assets/colorball.png',
        height: 50,
        width: 50,
      ),
    );
  }

  void _addDroppedBall() {
    bool _isOverlapping(Rect newRect) {
      for (var widget in _droppedBalls) {
        var positionedWidget = widget as Positioned;
        var existingRect = Rect.fromLTWH(
          positionedWidget.left!,
          positionedWidget.top!,
          50,
          50,
        );
        if (newRect.overlaps(existingRect)) {
          return true;
        }
      }
      return false;
    }

    double left, top;
    Rect newRect;
    do {
      left = _random.nextDouble() * (400 - 50);
      top = _random.nextDouble() * (400 - 50);
      newRect = Rect.fromLTWH(left, top, 50, 50);
    } while (_isOverlapping(newRect));

    _droppedBalls.add(Positioned(
      left: left,
      top: top,
      child: _appleWidget(),
    ));
  }

  void _showErrorDialog() {
    flutterTts.speak('Oh, you selected the wrong number. Please try again.');

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text(
          'Oh, you selected the wrong number!',
          style: TextStyle(
            color: Colors.red,
            fontSize: 30.0,
          ),
        ),
        content: const Text(
          'Please try again.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                timeLeft = 30; // Reset the timer
                isBlinking = false; // Stop blinking
              });
              restartGame(); // Shuffle numbers
              Navigator.pop(context);
            },
            child: const Text(
              'OK',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCongratulationDialog() {
    player.play('clapping_sound.mp3');
    flutterTts.speak('Congratulations!! You are awesome!!');

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text(
          'Congratulations!',
          style: TextStyle(
            color: Colors.green,
            fontSize: 30.0,
          ),
        ),
        content: const Text(
          'You are awesome!!',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                generateNewTarget();
                startTimer();
              });
              Navigator.pop(context);
            },
            child: const Text(
              'Next',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
