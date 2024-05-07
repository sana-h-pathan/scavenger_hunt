import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:scavanger_hunt/app_score.dart';
import 'package:scavanger_hunt/page-eight.dart';
import 'header.dart';
import 'background.dart';
import 'home.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:scavanger_hunt/numbers.dart' as Numbers;
import 'package:flutter/services.dart' show rootBundle;
import 'package:scavanger_hunt/app_language.dart';
import 'dart:async';

class PageSeven extends StatefulWidget {
  @override
  _PageSevenState createState() => _PageSevenState();
}

class _PageSevenState extends State<PageSeven> {
  Timer? _timer;
  int _start = 60;
  int count = 0;
  FlutterTts flutterTts = FlutterTts();
  Future<void> speakMessage(String message) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(message);
  }

  Map<int, String> buttonToHint = {
    0: "one",
    1: "two",
    2: "three",
    3: "four",
    4: "five",
    5: "six",
    6: "seven"
  };
  Map<int, bool> buttonClicked = {
    0: false,
    1: false,
    2: false,
    3: false,
    4: false,
    5: false,
    6: false
  };

  void resetCountAndButtons() {
    setState(() {
      count = 0;
      buttonClicked = {
        0: false,
        1: false,
        2: false,
        3: false,
        4: false,
        5: false,
        6: false
      };
      resetTimer();
      AppScore().setStageScore(7, 0);
    });
  }

  void resetTimer() {
    _timer?.cancel();
    _start = 60;
    startTimer();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            print("Timer Completed"); // Debug when timer reaches 0
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        AppScore().setStageScore(7, 0);
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int minutes = _start ~/ 60;
    int seconds = _start % 60;
    String formattedTime =
        '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Stack(
            children: [
              BackgroundGradient(),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                      height: MediaQuery.of(context).size.height *
                          0.07), // 10% top padding
                  Expanded(
                    child: Image.asset(
                      'assets/seven.jpg',
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height *
                          0.11), // 10% bottom padding
                ],
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.02,
                left: MediaQuery.of(context).size.width * 0.25,
                child: IconButton(
                  icon: const Icon(
                    Icons.refresh,
                    size: 60,
                  ),
                  color: Colors.yellow,
                  onPressed: resetCountAndButtons,
                ),
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.055,
                left: MediaQuery.of(context).size.width * 0.40,
                child: Image.asset(
                  'assets/seven.png',
                  width: 60,
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.01,
                left: MediaQuery.of(context).size.width * 0.40,
                child: Text(
                  '$count/7',
                  style: const TextStyle(
                    color: Colors.yellow,
                    fontWeight: FontWeight.bold,
                    fontSize: 30, // 4% of screen height
                  ),
                ),
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.02,
                right: MediaQuery.of(context).size.width * 0.40,
                child: IconButton(
                  icon: const Icon(
                    Icons.mic,
                    size: 60,
                  ),
                  color: Colors.yellow,
                  onPressed: () async {
                    await flutterTts.setLanguage("en-US");
                    await flutterTts.setPitch(1.0);
                    await flutterTts
                        .speak("Please find all occurrences of number 7");
                    await Future.delayed(const Duration(seconds: 5));
                    await flutterTts.setLanguage("es-ES");
                    await flutterTts.speak(
                        "Por favor, encuentra todas las ocurrencias del número uno");
                  },
                ),
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.02,
                right: MediaQuery.of(context).size.width * 0.25,
                child: IconButton(
                  icon: const Icon(
                    Icons.lightbulb_outline,
                    size: 60,
                  ),
                  color: Colors.yellow,
                  onPressed: () async {
                    if (allButtonsClicked()) {
                      speakMessage(
                          "You have found all occurrences of number 7");
                    }
                    // Speak the hint if the button hasn't been clicked
                    for (int i = 0; i < buttonToHint.length; i++) {
                      if (!buttonClicked[i]!) {
                        await speakMessage(buttonToHint[i]!);
                        break;
                      }
                    }
                  },
                ),
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.03,
                right: MediaQuery.of(context).size.width * 0.08,
                child: Text(
                  '$formattedTime',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 36,
                    color: Colors.yellow,
                  ),
                ),
              ),
              Positioned(
                top:
                    MediaQuery.of(context).size.height * 0.64, // 5% from bottom
                left: MediaQuery.of(context).size.width * 0.85,
                child: buildButton(0),
              ),
              Positioned(
                top:
                    MediaQuery.of(context).size.height * 0.45, // 5% from bottom
                left: MediaQuery.of(context).size.width * 0.91,
                child: buildButton(1),
              ),
              Positioned(
                bottom:
                    MediaQuery.of(context).size.height * 0.55, // 5% from bottom
                right: MediaQuery.of(context).size.width * 0.25,
                child: buildButton(2),
              ),
              Positioned(
                bottom:
                    MediaQuery.of(context).size.height * 0.17, // 5% from bottom
                right: MediaQuery.of(context).size.width * 0.33,
                child: buildButton(3),
              ),
              Positioned(
                bottom:
                    MediaQuery.of(context).size.height * 0.62, // 5% from bottom
                right: MediaQuery.of(context).size.width * 0.88,
                child: buildButton(4),
              ),
              Positioned(
                bottom:
                    MediaQuery.of(context).size.height * 0.78, // 5% from bottom
                right: MediaQuery.of(context).size.width * 0.82,
                child: buildButton(5),
              ),
              Positioned(
                bottom:
                    MediaQuery.of(context).size.height * 0.88, // 5% from bottom
                right: MediaQuery.of(context).size.width * 0.39,
                child: buildButton(6),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.02,
                left: MediaQuery.of(context).size.width * 0.40,
                child: const Text(
                  'Find 7',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
              ),
              HomeWidget(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Numbers.NumbersPage()),
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
              LanguageWidget()
            ],
          );
        },
      ),
    );
  }

  bool allButtonsClicked() {
    for (var entry in buttonClicked.entries) {
      if (!entry.value) {
        return false;
      }
    }
    return true;
  }

  Widget buildButton(int index) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: const ShapeDecoration(
          color: Colors.transparent,
          shape: CircleBorder(),
        ),
        child: IconButton(
          icon: const Icon(Icons.circle),
          color: Colors.transparent,
          iconSize: 50,
          onPressed: () {
            if (!buttonClicked[index]!) {
              setState(() {
                count++;
                buttonClicked[index] = true;
                AppScore().setStageScore(7, AppScore().getStageScore(7)! + 100);
                if (count == 7) {
                  _showStarsDialog();
                  speakMessage(
                      "Congratulations!!!You have found all occurrences of number 7");
                }
              });
            }
          },
        ),
      ),
    );
  }

  void _showStarsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.blueGrey, // Change background color
          title: const Text(
            'Congratulations!',
            style: TextStyle(
                color: Colors.yellow,
                fontSize: 30), // Change text color and size
          ),
          content: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.star, color: Colors.yellow, size: 48),
              SizedBox(width: 10), // Add space between stars
              Icon(Icons.star, color: Colors.yellow, size: 48),
              SizedBox(width: 10), // Add space between stars
              Icon(Icons.star, color: Colors.yellow, size: 48),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.push(
                  // Navigate to PageTwo
                  context,
                  MaterialPageRoute(builder: (context) => PageEight()),
                );
              },
              child: const Text(
                'Next Level',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18), // Change button text color and size
              ),
            ),
          ],
        );
      },
    );
  }
}
