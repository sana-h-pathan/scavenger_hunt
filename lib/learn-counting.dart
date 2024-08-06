import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_tts/flutter_tts.dart'; // Import flutter_tts
import 'background.dart';
import 'header.dart';
import 'home.dart';

class CountAndFillPage extends StatefulWidget {
  @override
  _CountAndFillPageState createState() => _CountAndFillPageState();
}

class _CountAndFillPageState extends State<CountAndFillPage> {
  int _targetNumber = 1;
  int _currentCount = 0;
  Random _random = Random();
  List<Widget> _droppedBalls = [];
  final player = AudioCache();
  final FlutterTts flutterTts = FlutterTts();
  bool completed = false;

  @override
  void initState() {
    super.initState();
    generateNewTarget();
  }

  void generateNewTarget() {
    setState(() {
      _targetNumber = _random.nextInt(10) + 1;
      _currentCount = 0;
      _droppedBalls = [];
    });
  }

  void _submitCount() {
    if (_currentCount == _targetNumber) {
      _showCongratulationDialog();
    } else {
      _showErrorDialog();
    }
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
                completed = false;
                generateNewTarget(); // Shuffle numbers
              });
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
          'You are awesome!',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text(
              'Home',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              generateNewTarget(); // Shuffle numbers
              Navigator.pop(context);
            },
            child: const Text(
              'Replay',
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

  void _resetCountAndButtons() {
    setState(() {
      _currentCount = 0;
      _droppedBalls = [];
      generateNewTarget();
    });
  }

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
                    child: CountAndFillPageScreen(
                      targetNumber: _targetNumber,
                      currentCount: _currentCount,
                      droppedBalls: _droppedBalls,
                      onAccept: (data) {
                        setState(() {
                          _currentCount += data;
                          _addDroppedBall();
                        });
                      },
                      onSubmit: _submitCount,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.11),
                ],
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.10,
                left: MediaQuery.of(context).size.width * 0.30,
                child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Learn to Count',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                    ),
                  ),
                  SizedBox(height: 10), // Space between title and instructions
                  Text(
                    'Drag the balls to the box and count them.\nPress Submit when done.',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
              
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.02,
                left: MediaQuery.of(context).size.width * 0.15,
                child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [ Color.fromRGBO(252, 170, 214, 1),Color.fromRGBO(230, 195, 214, 1),],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ElevatedButton(
                  onPressed: _resetCountAndButtons,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    backgroundColor: Colors.transparent, // Make button background transparent to show gradient
                    elevation: 0, // Remove default shadow
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Reset',
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
              
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.02,
              right: MediaQuery.of(context).size.width * 0.45,
              child: IconButton(
                icon: const Icon(
                  Icons.mic,
                  size: 60,
                ),
                color: Colors.white,
                onPressed: () async {
                  flutterTts.speak('Drag the balls to the box and count them.\nPress Submit when done.!!');
                  // Add functionality here if needed
                },
              ),
            ),
             Positioned(
              bottom: MediaQuery.of(context).size.height * 0.02,
              right: MediaQuery.of(context).size.width * 0.15,
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [ Color.fromRGBO(252, 170, 214, 1),Color.fromRGBO(230, 195, 214, 1),],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ElevatedButton(
                  onPressed: _submitCount,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    backgroundColor: Colors.transparent, // Make button background transparent to show gradient
                    elevation: 0, // Remove default shadow
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.black,
                    ),
                  ),
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
            const ScoreWidget(),
            const LanguageWidget(),
            ],
          );
        },
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

    setState(() {
      _droppedBalls.add(Positioned(
        left: left,
        top: top,
        child: _appleWidget(),
      ));
    });
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
}

class CountAndFillPageScreen extends StatelessWidget {
  final int targetNumber;
  final int currentCount;
  final List<Widget> droppedBalls;
  final void Function(int) onAccept;
  final VoidCallback onSubmit;

  CountAndFillPageScreen({
    required this.targetNumber,
    required this.currentCount,
    required this.droppedBalls,
    required this.onAccept,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundGradient(),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.1,
            left: MediaQuery.of(context).size.width * 0.49,
            child: Text(
              '$targetNumber',
              style: const TextStyle(
                fontSize: 100,
                color: Colors.black,
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
                  feedback: _appleWidget(),
                  childWhenDragging: _appleWidget(opacity: 0.5),
                  child: _appleWidget(),
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
                    border: Border.all(color: Colors.black, width: 5),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.transparent,
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Text(
                          '$currentCount / $targetNumber',
                          style: const TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ...droppedBalls,
                    ],
                  ),
                );
              },
              onAccept: onAccept,
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
        height: 100,
        width: 100,
      ),
    );
  }
}
