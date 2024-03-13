import 'package:flutter/material.dart';
import 'header.dart'; // Import the header.dart file
import 'background.dart'; // Import the background.dart file
import 'home.dart'; // Import the HomeScreen widget
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: const Color(0xFF3349BE)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundGradient(), // Use the Background widget from background.dart
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 30), // Add space from the top
              const SizedBox(height: 40), // Add space between title and letters
              ScavengerHuntText(), // Use the ScavengerHuntText widget from header.dart
              const SizedBox(height: 20), // Add space between text and counter
              const Text(
                '',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                  height: 20), // Add space between counter and images
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                      'assets/image1.png'), // Replace 'assets/image1.png' with your image path
                  SizedBox(height: 70), // Add space between images
                  Image.asset('assets/image2.png'),
                ],
              ),
            ],
          ),
          DiagonalWidget1(), // Diagonal widgets from header.dart
          DiagonalWidget2(),
          DiagonalWidget3(),
          DiagonalWidget4(),
          Positioned(
            bottom: 150, // Adjust bottom position as needed
            left: 100,
            child: Transform.rotate(
              angle: -math.pi / 4, // Rotate the square diagonally
              child: Container(
                width: 50,
                height: 50,
                color: Colors.green, // Set color to green
                child: Center(
                  child: Text(
                    '3',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 150, // Adjust bottom position as needed
            right: 100,
            child: Transform.rotate(
              angle: math.pi / 4, // Rotate the square diagonally
              child: Container(
                width: 50,
                height: 50,
                color: Colors.red, // Set color to red
                child: Center(
                  child: Text(
                    '9',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 40, // Adjust bottom position as needed
            left: 100,
            child: Transform.rotate(
              angle: -math.pi / 4, // Rotate the square diagonally
              child: Container(
                width: 50,
                height: 50,
                color: Colors.brown, // Set color to blue
                child: Center(
                  child: Text(
                    '1',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 40, // Adjust bottom position as needed
            right: 100,
            child: Transform.rotate(
              angle: math.pi / 4, // Rotate the square diagonally
              child: Container(
                width: 50,
                height: 50,
                color: Colors.yellow, // Set color to yellow
                child: Center(
                  child: Text(
                    '4',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(height: 20), // Add space between squares and buttons
                  // Home button
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Color.fromRGBO(252, 170, 214, 1),
                      minimumSize: const Size(
                          200, 50), // Set minimum width and height for button
                    ),
                    icon: Icon(Icons.home, size: 30), // Add icon to the button
                    label: Text(
                      'Home    ',
                      style: TextStyle(
                        fontFamily: 'Calibri',
                        fontSize: 24,
                        fontWeight: FontWeight.bold, // Make the font bold
                      ),
                    ),
                  ),
                  SizedBox(height: 60),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
