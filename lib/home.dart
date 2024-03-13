// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:scavanger_hunt/match-sequence.dart';
import 'package:scavanger_hunt/number-memory.dart';
import 'header.dart';
import 'numbers.dart'; // Import the NumbersPage
import 'background.dart';
import 'page-one.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundGradient(), // Background from background.dart
          // ignore: prefer_const_constructors
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 40), // Add space from the top
              const SizedBox(height: 40), // Add space between title and letters
              const ScavengerHuntText(), // Reusable Scavenger Hunt text
              const SizedBox(height: 20), // Add space between text and counter
            ],
          ),
          const DiagonalWidget1(), // Diagonal widgets from header.dart
          const DiagonalWidget2(),
          const DiagonalWidget3(),
          const DiagonalWidget4(),
          HomeWidget(
            onPressed: () {
                  Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );// Handle home button press here
            },
          ),
          MenuWidget(
            onPressed: () {
                  Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );// Handle home button press here
            },
          ),
          Positioned(
            top: 300, // Adjust top position as needed
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NumbersPage()),
                      );
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/numbers.png',
                          height: 300, // Set the height to adjust the size
                          width: 300, // Set the width to adjust the size
                        ),
                        const SizedBox(height: 1),
                        const Text(
                          'NUMBERS',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NumberMemoryGame()),
                      );
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/flipcard.png',
                          height: 300, // Set the height to adjust the size
                          width: 300, // Set the width to adjust the size
                        ),
                        const SizedBox(height: 1),
                        const Text(
                          'Flip the Card',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30), // Add space between rows
          Positioned(
            bottom: 150, // Adjust top position as needed
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NumberSequenceQuiz()),
                        );
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/sequence.png',
                            height: 300, // Set the height to adjust the size
                            width: 300, // Set the width to adjust the size
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Number Sequence',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
