import 'package:flutter/material.dart';
import 'header.dart';
import 'background.dart';

class PageOne extends StatefulWidget {
  @override
  _PageOneState createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundGradient(), // Use background from background.dart
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 20), // Add space from the top
              const SizedBox(height: 60), // Add space between title and letters
              ScavengerHuntText(), // Reusable Scavenger Hunt text
              const SizedBox(height: 40), // Add space between text and images
              // Add Image widget to display one.jpg
              Image.asset(
                'assets/one.jpg', // Path to the image asset
                fit: BoxFit.fill, // Adjust the fit as needed
                width: double.infinity, // Make the image take the full width
                height: 780, // Set the height of the image
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
                '$count/3',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ],
          ),
          // Positioned widget for the microphone icon
          Positioned(
            top: 1040, // Adjust the top position of the microphone icon
            left: 460, // Adjust the left position of the microphone icon
            child: IconButton(
              icon: Icon(
                Icons.mic, // Use the microphone icon
                size: 60, // Set the size of the icon
              ),
              onPressed: () {
                // Handle microphone icon press here
                // Add your logic for recording or any other action
              },
            ),
          ),
          // Positioned widgets for buttons
          Positioned(
            top: 300, // Adjust the top position of the button
            left: 50, // Adjust the left position of the button
            child: Material(
              color: Colors.transparent,
              child: Ink(
                decoration: ShapeDecoration(
                  color: Colors.transparent,
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  icon: Icon(Icons.circle),
                  color: Colors.transparent,
                  onPressed: () {
                    // Handle button press here
                    setState(() {
                      count++;
                      if (count > 3) count = 3; // Limit count to 3
                    });
                  },
                ),
              ),
            ),
          ),
          Positioned(
            top: 480, // Adjust the top position of the button
            left: 445, // Adjust the left position of the button
            child: Material(
              color: Colors.transparent,
              child: Ink(
                decoration: ShapeDecoration(
                  color: Colors.transparent,
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  icon: Icon(Icons.circle),
                  color: Colors.transparent,
                  onPressed: () {
                    // Handle button press here
                    setState(() {
                      count++;
                      if (count > 3) count = 3; // Limit count to 3
                    });
                  },
                ),
              ),
            ),
          ),
          Positioned(
            top: 755, // Adjust the top position of the button
            left: 675, // Adjust the left position of the button
            child: Material(
              color: Colors.transparent,
              child: Ink(
                decoration: ShapeDecoration(
                  color: Colors.transparent,
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  icon: Icon(Icons.circle),
                  color: Colors.transparent,
                  onPressed: () {
                    // Handle button press here
                    setState(() {
                      count++;
                      if (count > 3) count = 3; // Limit count to 3
                    });
                  },
                ),
              ),
            ),
          ),
          DiagonalWidget1(), // Add diagonal widgets from header.dart
          DiagonalWidget2(), // Add diagonal widgets from header.dart
          DiagonalWidget3(), // Add diagonal widgets from header.dart
          DiagonalWidget4(), // Add diagonal widgets from header.dart
        ],
      ),
    );
  }
}
