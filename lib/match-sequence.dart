import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_tts/flutter_tts.dart'; // Import flutter_tts
import 'background.dart';
import 'header.dart';
import 'home.dart';
import 'dart:async';

class NumberSequenceQuiz extends StatefulWidget {
  @override
  _NumberSequenceQuizState createState() => _NumberSequenceQuizState();
}

class _NumberSequenceQuizState extends State<NumberSequenceQuiz> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Stack(
            children: [
              BackgroundGradient(), // Use your background widget here
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).size.height * 0.20),
                  Expanded(
                    child: NumberSequenceQuizScreen(),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.11),
                ],
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.10,
                left: MediaQuery.of(context).size.width * 0.15,
                child: const Text(
                  'Number Sequence Quiz',
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

class NumberSequenceQuizScreen extends StatefulWidget {
  @override
  _NumberSequenceQuizScreenState createState() =>
      _NumberSequenceQuizScreenState();
}

class _NumberSequenceQuizScreenState extends State<NumberSequenceQuizScreen> {
  List<int> numbers = List.generate(10, (index) => index + 1)..shuffle();
  int currentIndex = 0;
  bool completed = false; // Track if the sequence is completed

  // Initialize AudioCache
  final player = AudioCache();

  // Initialize FlutterTts
  final FlutterTts flutterTts = FlutterTts();

  Timer? timer;
  int timeLeft = 30;
  bool isBlinking = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        timeLeft--;
        if (timeLeft == 0) {
          // Restart the game if time runs out
          restartGame();
        } else if (timeLeft <= 5) {
          // Start blinking when time is less than or equal to 5 seconds
          isBlinking = !isBlinking;
        }
      });
    });
  }

  void restartGame() {
    setState(() {
      currentIndex = 0;
      completed = false;
      timeLeft = 30; // Reset the timer
      isBlinking = false; // Stop blinking
      numbers = List.generate(10, (index) => index + 1)..shuffle(); // Shuffle numbers
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Define a list of text representations of numbers
    List<String> numberTexts = ['One', 'Two', 'Three', 'Four', 'Five', 'Six', 'Seven', 'Eight', 'Nine', 'Ten'];

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Tap the numbers in sequence',
            style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 60.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  for (int i = 0; i < 4; i++) _buildNumberContainer(i, numberTexts),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  for (int i = 4; i < 8; i++) _buildNumberContainer(i, numberTexts),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 8; i < numbers.length; i++) _buildNumberContainer(i, numberTexts),
                ],
              ),
            ],
          ),
          const SizedBox(height: 40),
          Container(
            padding: const EdgeInsets.all(10.0),
            width: 120.0, // Adjust width here
            height: 120.0, // Adjust height here
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0), // Adjust border radius if needed
            ),
            child: Center(
              child: Text(
                '$timeLeft sec',
                style: TextStyle(
                  fontSize: 24,
                  color: timeLeft <= 5 && isBlinking ? Colors.red : Colors.black, // Blinking color
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNumberContainer(int index, List<String> numberTexts) {
    bool showText = index.isEven; // Alternate between showing text and digit

    return GestureDetector(
      onTap: () {
        if (!completed) {
          if (numbers[index] == currentIndex + 1) {
            setState(() {
              currentIndex++;
              if (currentIndex == numbers.length) {
                completed = true;
                _showCongratulationDialog();
              }
            });
          } else {
            _showErrorDialog();
          }
        }
      },
      child: Container(
        width: 150.0,
        height: 150.0,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: numbers[index] <= currentIndex ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (showText)
              Text(
                '${numberTexts[numbers[index] - 1]}', // Show text representation
                style: const TextStyle(fontSize: 30.0, color: Colors.black),
              )
            else
              Text(
                '${numbers[index]}', // Show digit representation
                style: const TextStyle(fontSize: 40.0, color: Colors.black),
              ),
          ],
        ),
      ),
    );
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
                currentIndex = 0;
                completed = false;
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
              restartGame(); // Shuffle numbers
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
}
