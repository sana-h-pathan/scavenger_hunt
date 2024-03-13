import 'package:flutter/material.dart';

class NumberSequenceQuiz extends StatefulWidget {
  @override
  _NumberSequenceQuizState createState() => _NumberSequenceQuizState();
}

class _NumberSequenceQuizState extends State<NumberSequenceQuiz> {
  List<int> numbers = List.generate(10, (index) => index + 1)..shuffle();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number Sequence Quiz'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Tap the numbers in sequence:',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < numbers.length; i++)
                  GestureDetector(
                    onTap: () {
                      if (numbers[i] == currentIndex + 1) {
                        setState(() {
                          currentIndex++;
                        });
                      } else {
                        _showErrorDialog();
                      }
                    },
                    child: Container(
                      width: 50.0,
                      height: 50.0,
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: numbers[i] <= currentIndex ? Colors.green : Colors.red, // Check if number is tapped
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text(
                        '${numbers[i]}',
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Incorrect Sequence!'),
        content: Text('You tapped the numbers in the wrong order.'),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                currentIndex = 0;
                numbers.shuffle(); // Shuffle numbers again
              });
              Navigator.pop(context);
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: NumberSequenceQuiz(),
  ));
}
