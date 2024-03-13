import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class NumberSequenceQuiz extends StatefulWidget {
  @override
  _NumberSequenceQuizState createState() => _NumberSequenceQuizState();
}

class _NumberSequenceQuizState extends State<NumberSequenceQuiz> {
  List<int> numbers = List.generate(10, (index) => index + 1)..shuffle();
  List<int> userSequence = [];

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
              'Put the numbers in the correct sequence:',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 20.0),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 10.0,
              runSpacing: 10.0,
              children: [
                for (int number in numbers)
                  Draggable<int>(
                    data: number,
                    child: Container(
                      width: 50.0,
                      height: 50.0,
                      color: Colors.blue,
                      child: Center(
                        child: Text(
                          '$number',
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                      ),
                    ),
                    feedback: Material(
                      color: Colors.blue.withOpacity(0.5),
                      child: Container(
                        width: 50.0,
                        height: 50.0,
                        color: Colors.blue.withOpacity(0.5),
                        child: Center(
                          child: Text(
                            '$number',
                            style: TextStyle(fontSize: 20.0, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    childWhenDragging: Container(
                      width: 50.0,
                      height: 50.0,
                      color: Colors.blue.withOpacity(0.5),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _checkSequence();
              },
              child: Text('Check Sequence'),
            ),
          ],
        ),
      ),
    );
  }

  void _checkSequence() {
    if (ListEquality().equals(userSequence, List.generate(10, (index) => index + 1))) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Congratulations!'),
          content: Text('You arranged the numbers correctly.'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  userSequence.clear();
                  numbers.shuffle();
                });
                Navigator.pop(context);
              },
              child: Text('Play Again'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Try Again!'),
          content: Text('The numbers are not arranged correctly.'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  userSequence.clear();
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
}
