import 'package:flutter/material.dart';
import 'package:scavanger_hunt/app_score.dart';
import 'package:scavanger_hunt/home.dart';
import 'dart:math' as math;
import 'package:scavanger_hunt/numbers.dart'
    as Numbers; // Rename the import using 'as'

import 'package:flutter/material.dart';
import 'package:scavanger_hunt/app_language.dart';

class ScavengerHuntText extends StatelessWidget {
  const ScavengerHuntText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildTextRow(),
          const SizedBox(width: 20), // Add spacing between home icon and text
        ],
      ),
    );
  }

  Widget _buildTextRow() {
    return Row(
      children: [
        _buildText('S', const Color.fromRGBO(52, 218, 59, 1)),
        _buildText('C', Color.fromRGBO(157, 43, 177, 1)),
        _buildText('A', Color.fromRGBO(241, 56, 67, 1)),
        _buildText('V', Colors.orange),
        _buildText('E', Colors.red),
        _buildText('N', const Color.fromRGBO(238, 251, 82, 1)),
        _buildText('G', Colors.purple),
        _buildText('E', Colors.pink),
        _buildText('R', Colors.green),
        const Text(
          '  ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Calibri',
            color: Colors.black,
            fontSize: 65,
          ),
        ),
        _buildText('H', Colors.orange),
        _buildText('U', Color.fromRGBO(157, 43, 177, 1)),
        _buildText('N', Colors.red),
        _buildText('T', Colors.green),
      ],
    );
  }

  Widget _buildText(String text, Color color) {
    return Text(
      text,
      style: TextStyle(
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.bold,
        fontFamily: 'Calibri',
        color: color,
        fontSize: 65,
      ),
    );
  }
}

class DiagonalWidget1 extends StatelessWidget {
  const DiagonalWidget1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 160, // Adjust top position as needed
      left: 30,
      child: Transform.rotate(
        angle: -math.pi / 4, // Rotate the square diagonally
        child: Container(
          width: 50,
          height: 50,
          color: Color.fromRGBO(233, 30, 90, 1), // Set color to green
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
    );
  }
}

class DiagonalWidget2 extends StatelessWidget {
  const DiagonalWidget2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 160, // Adjust top position as needed
      right: 30,
      child: Transform.rotate(
        angle: math.pi / 4, // Rotate the square diagonally
        child: Container(
          width: 50,
          height: 50,
          color: Color.fromRGBO(52, 218, 59, 1), // Set color to red
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
    );
  }
}

class DiagonalWidget3 extends StatelessWidget {
  const DiagonalWidget3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 70, // Adjust top position as needed
      left: 30,
      child: Transform.rotate(
        angle: -math.pi / 4, // Rotate the square diagonally
        child: Container(
          width: 50,
          height: 50,
          color: Colors.orange, // Set color to blue
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
    );
  }
}

class DiagonalWidget4 extends StatelessWidget {
  const DiagonalWidget4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 70, // Adjust top position as needed
      right: 30,
      child: Transform.rotate(
        angle: math.pi / 4, // Rotate the square diagonally
        child: Container(
          width: 50,
          height: 50,
          color: Colors.purple, // Set color to yellow
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
    );
  }
}

class HomeWidget extends StatelessWidget {
  const HomeWidget({Key? key, required this.onPressed}) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.02, // 5% from bottom
      left: MediaQuery.of(context).size.width * 0.07,
      child: IconButton(
        icon: Icon(
          Icons.home,
          color: Colors.black,
        ),
        iconSize: 36,
        onPressed: () {

                  Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );// Handle home button press here
            },
      ),
    );
  }
}

class MenuWidget extends StatelessWidget {
  const MenuWidget({Key? key, required this.onPressed}) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.02, // 5% from bottom
      right: MediaQuery.of(context).size.width * 0.07,
      child: IconButton(
        icon: Icon(
          Icons.menu,
          color: Colors.black,
        ),
        iconSize: 36,
        onPressed: onPressed,
      ),
    );
  }
}

class LanguageWidget extends StatefulWidget {
  const LanguageWidget({Key? key}) : super(key: key);

  @override
  _LanguageWidgetState createState() => _LanguageWidgetState();
}

class _LanguageWidgetState extends State<LanguageWidget> {
  // Initial language set to English
  String currentLanguage = "en-US";
  // Language options
  final List<Map<String, String>> languageOptions = [
    {"code": "en-US", "name": "English"},
    {"code": "es-ES", "name": "Español"},
  ];

  void _changeLanguage(String? newLanguageCode) {
    if (newLanguageCode != null) {
      setState(() {
        currentLanguage = newLanguageCode;
        AppLanguage().currentLanguage =
            newLanguageCode; // Update global language state
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.02,
      right: MediaQuery.of(context).size.width *
          0.15, // Adjust based on your layout
      child: DropdownButton<String>(
        underline: Container(), // Removes the underline of the dropdown button
        icon: const Icon(Icons.mic, color: Colors.black),
        value: currentLanguage,
        items: languageOptions.map((language) {
          return DropdownMenuItem<String>(
            value: language["code"],
            child: Text(language["name"]!),
          );
        }).toList(),
        onChanged: _changeLanguage,
      ),
    );
  }
}

class ScoreWidget extends StatefulWidget {
  const ScoreWidget({Key? key}) : super(key: key);

  @override
  _ScoreWidgetState createState() => _ScoreWidgetState();
}

class _ScoreWidgetState extends State<ScoreWidget> {
  // Initial score set to 0
  int currentScore = AppScore().currentScore;

  @override
  void initState() {
    super.initState();
    AppScore().addListener(updateLocalScore); // Add listener
  }

  @override
  void dispose() {
    AppScore().removeListener(updateLocalScore); // Remove listener
    super.dispose();
    AppScore().resetStageScore();
  }

  void updateLocalScore() {
    // Force a rebuild whenever the score changes
    setState(() {
      currentScore = AppScore().currentScore;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.031,
      right: MediaQuery.of(context).size.width * 0.28,
      child: Row(
        children: [
          Text(
            'Score: $currentScore',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
