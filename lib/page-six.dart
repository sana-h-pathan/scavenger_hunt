import 'package:flutter/material.dart';
import 'header.dart';
import 'background.dart';
import 'home.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:scavanger_hunt/numbers.dart' as Numbers;

class PageSix extends StatefulWidget {
  @override
  _PageSixState createState() => _PageSixState();
}

class _PageSixState extends State<PageSix> {
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
    5: "six"
  };
  Map<int, bool> buttonClicked = {
    0: false,
    1: false,
    2: false,
    3: false,
    4: false,
    5: false
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
        5: false
      };
    });
  }

  @override
  Widget build(BuildContext context) {
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
                      'assets/six.jpg',
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
                  'assets/six.png',
                  width: 60,
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.01,
                left: MediaQuery.of(context).size.width * 0.40,
                child: Text(
                  '$count/6',
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
                        .speak("Please find all occurrences of number 6");
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
                          "You have found all occurrences of number 6");
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
                top:
                    MediaQuery.of(context).size.height * 0.66, // 5% from bottom
                left: MediaQuery.of(context).size.width * 0.43,
                child: buildButton(0),
              ),
              Positioned(
                top:
                    MediaQuery.of(context).size.height * 0.78, // 5% from bottom
                left: MediaQuery.of(context).size.width * 0.85,
                child: buildButton(1),
              ),
              Positioned(
                bottom:
                    MediaQuery.of(context).size.height * 0.67, // 5% from bottom
                right: MediaQuery.of(context).size.width * 0.31,
                child: buildButton(2),
              ),
              Positioned(
                bottom:
                    MediaQuery.of(context).size.height * 0.65, // 5% from bottom
                right: MediaQuery.of(context).size.width * 0.21,
                child: buildButton(3),
              ),
              Positioned(
                bottom:
                    MediaQuery.of(context).size.height * 0.45, // 5% from bottom
                right: MediaQuery.of(context).size.width * 0.75,
                child: buildButton(4),
              ),
              Positioned(
                bottom:
                    MediaQuery.of(context).size.height * 0.80, // 5% from bottom
                right: MediaQuery.of(context).size.width * 0.92,
                child: buildButton(5),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.02,
                left: MediaQuery.of(context).size.width * 0.40,
                child: const Text(
                  'Find 6',
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
                if (count == 6) {
                  speakMessage(
                      "Congratulations!!!You have found all occurrences of number 6");
                }
              });
            }
          },
        ),
      ),
    );
  }
}
