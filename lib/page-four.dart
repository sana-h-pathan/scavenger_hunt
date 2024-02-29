// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'header.dart';
import 'background.dart';
import 'home.dart';

class PageFour extends StatefulWidget {
  @override
  _PageFourState createState() => _PageFourState();
}

class _PageFourState extends State<PageFour> {
  int count = 0;
  List<bool> buttonClicked = [false, false, false,false];

  void resetCountAndButtons() {
    setState(() {
      count = 0;
      buttonClicked = [false, false, false,false];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundGradient(), // Use background from background.dart
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 50), // Add space between title and letters
              //ScavengerHuntText(), // Reusable Scavenger Hunt text
              // Add Image widget to display one.jpg
              Image.asset(
                'assets/four.jpg', // Path to the image asset
                fit: BoxFit.fill, // Adjust the fit as needed
                width: double.infinity, // Make the image take the full width
                height: 960, // Set the height of the image
              ),
              const SizedBox(height: 20), // Add space between images
              // Add Image widget to display one.png
              Image.asset(
                'assets/one.png', // Path to the image asset
                fit: BoxFit.cover, // Adjust the fit as needed
                width: 70, // Make the image take the full width
                height: 80, // Set the height of the image
              ),
              const SizedBox(height: 10), // Add space between image and text
              Text(
                '$count/4',
                style: TextStyle(
                  color: Colors.yellow,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ],
          ),
          // Positioned widget for the microphone icon
          Positioned(
            top: 1040, // Adjust the top position of the microphone icon
            left: 480, // Adjust the left position of the microphone icon
            child: IconButton(
              icon: Icon(
                Icons.mic, // Use the microphone icon
                size: 60, // Set the size of the icon
              ),
              color:Colors.yellow,
              onPressed: () {
                // Handle microphone icon press here
                // Add your logic for recording or any other action
              },
            ),
          ),
          // Positioned widget for the hint button
          Positioned(
            top: 1040, // Adjust the top position of the hint button
            left: 550, // Adjust the left position of the hint button
            child: IconButton(
              icon: Icon(
                Icons.lightbulb_outline, // Use the hint icon
                size: 60, // Set the size of the icon
              ),
              color: Colors.yellow, // Set the color of the icon to yellow
              onPressed: () {
                // Handle hint button press here
              },
            ),
          ),
          // Positioned widget for the refresh button
          Positioned(
            top: 1040, // Adjust the top position of the refresh button
            left: 250, // Adjust the left position of the refresh button
            child: IconButton(
              icon: Icon(
                Icons.refresh, // Use the refresh icon
                size: 60, // Set the size of the icon
              ),
              color:Colors.yellow,
              onPressed: () {
                // Handle refresh button press here
                resetCountAndButtons();
              },
            ),
          ),
          // Positioned widgets for buttons
          Positioned(
            top: 690, // Adjust the top position of the button
            left: 10, // Adjust the left position of the button
            child: Material(
              color: Colors.transparent,
              child: Ink(
                decoration: ShapeDecoration(
                  color: Colors.transparent,
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  icon: Icon(Icons.circle),
                  color: Colors.black,
                  onPressed: () {
                    // Handle button press here
                    if (!buttonClicked[0]) {
                      setState(() {
                        count++;
                        buttonClicked[0] = true;
                      });
                    }
                  },
                ),
              ),
            ),
          ),
          Positioned(
            top: 380, // Adjust the top position of the button
            left: 30, // Adjust the left position of the button
            child: Material(
              color: Colors.transparent,
              child: Ink(
                decoration: ShapeDecoration(
                  color: Colors.transparent,
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  icon: Icon(Icons.circle),
                  color: Colors.black,
                  onPressed: () {
                    // Handle button press here
                    if (!buttonClicked[1]) {
                      setState(() {
                        count++;
                        buttonClicked[1] = true;
                      });
                    }
                  },
                ),
              ),
            ),
          ),
          Positioned(
            top: 690, // Adjust the top position of the button
            left: 500, // Adjust the left position of the button
            child: Material(
              color: Colors.transparent,
              child: Ink(
                decoration: ShapeDecoration(
                  color: Colors.transparent,
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  icon: Icon(Icons.circle),
                  color: Colors.black,
                  onPressed: () {
                    // Handle button press here
                    if (!buttonClicked[2]) {
                      setState(() {
                        count++;
                        buttonClicked[2] = true;
                      });
                    }
                  },
                ),
              ),
            ),
          ),
          Positioned(
            top: 755, // Adjust the top position of the button
            left: 200, // Adjust the left position of the button
            child: Material(
              color: Colors.transparent,
              child: Ink(
                decoration: ShapeDecoration(
                  color: Colors.transparent,
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  icon: Icon(Icons.circle),
                  color: Colors.black,
                  onPressed: () {
                    // Handle button press here
                    if (!buttonClicked[3]) {
                      setState(() {
                        count++;
                        buttonClicked[3] = true;
                      });
                    }
                  },
                ),
              ),
            ),
          ),
          //DiagonalWidget1(), // Add diagonal widgets from header.dart
          //DiagonalWidget2(), // Add diagonal widgets from header.dart
          //DiagonalWidget3(), // Add diagonal widgets from header.dart
          //DiagonalWidget4(), // Add diagonal widgets from header.dart
          HomeWidget(
            onPressed: () {
                  Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
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
        ],
      ),
    );
  }
}