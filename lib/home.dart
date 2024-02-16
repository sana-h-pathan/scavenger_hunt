import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'header.dart';
import 'numbers.dart'; // Import the NumbersPage
import 'background.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundGradient(), // Background from background.dart
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 20), // Add space from the top
              const SizedBox(height: 40), // Add space between title and letters
              ScavengerHuntText(), // Reusable Scavenger Hunt text
              const SizedBox(height: 20), // Add space between text and counter
            ],
          ),
          DiagonalWidget1(), // Diagonal widgets from header.dart
          DiagonalWidget2(),
          DiagonalWidget3(),
          DiagonalWidget4(),
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
                        SizedBox(height: 1),
                        Text(
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
                      // Navigate to shapes page
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/shapes.png',
                          height: 300, // Set the height to adjust the size
                          width: 300, // Set the width to adjust the size
                        ),
                        SizedBox(height: 1),
                        Text(
                          'SHAPES',
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
          SizedBox(height: 30), // Add space between rows
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
                        // Navigate to symbols page
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/symbols.png',
                            height: 300, // Set the height to adjust the size
                            width: 300, // Set the width to adjust the size
                          ),
                          SizedBox(height: 10),
                          Text(
                            'SYMBOLS',
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
