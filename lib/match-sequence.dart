import 'package:flutter/material.dart';
import 'background.dart';
import 'header.dart';
import 'home.dart';
import 'dart:async';

class NumberSequenceQuiz extends StatelessWidget {
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
                    MaterialPageRoute(builder: (context) => HomeScreen()),
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

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Tap the numbers in sequence',
            style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 60.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < 4; i++) _buildNumberContainer(i),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 4; i < 8; i++) _buildNumberContainer(i),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 8; i < numbers.length; i++)
                    _buildNumberContainer(i),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNumberContainer(int index) {
    return GestureDetector(
      onTap: () {
        if (!completed) {
          // Check if sequence is completed
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
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: numbers[index] <= currentIndex ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Text(
          '${numbers[index]}',
          style: TextStyle(fontSize: 40.0, color: Colors.black),
        ),
      ),
    );
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.grey[900], // Change background color
        title: Text(
          'Incorrect Sequence!',
          style: TextStyle(
            color: Colors.red, // Change text color
            fontSize: 30.0, // Increase font size
          ),
        ),
        content: Text(
          'You tapped the numbers in the wrong order.',
          style: TextStyle(
            color: Colors.white, // Change text color
            fontSize: 24.0, // Increase font size
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                currentIndex = 0;
                completed = false; // Reset sequence completion
                numbers.shuffle(); // Shuffle numbers again
              });
              Navigator.pop(context);
            },
            child: Text(
              'OK',
              style: TextStyle(
                color: Colors.white, // Change text color
                fontSize: 18.0, // Increase font size
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCongratulationDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.grey[900], // Change background color
        title: Text(
          'Congratulations!',
          style: TextStyle(
            color: Colors.green, // Change text color
            fontSize: 30.0, // Increase font size
          ),
        ),
        content: Text(
          'You tapped all numbers in the correct sequence!',
          style: TextStyle(
            color: Colors.white, // Change text color
            fontSize: 24.0, // Increase font size
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context); // Go back to the home screen
            },
            child: Text(
              'Home',
              style: TextStyle(
                color: Colors.white, // Change text color
                fontSize: 18.0, // Increase font size
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                currentIndex = 0;
                completed = false; // Reset sequence completion
                numbers.shuffle(); // Shuffle numbers again
              });
              Navigator.pop(context);
            },
            child: Text(
              'Replay',
              style: TextStyle(
                color: Colors.white, // Change text color
                fontSize: 18.0, // Increase font size
              ),
            ),
          ),
        ],
      ),
    );
  }
}
