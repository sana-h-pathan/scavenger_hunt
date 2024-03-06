import 'package:flutter/material.dart';
import 'header.dart';
import 'background.dart';
import 'home.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:scavanger_hunt/numbers.dart' as Numbers; // Rename the import using 'as'


class PageOne extends StatefulWidget {
  @override
  _PageOneState createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  int count = 0;
  List<bool> buttonClicked = [false, false, false, false];
  FlutterTts flutterTts = FlutterTts();

  void resetCountAndButtons() {
    setState(() {
      count = 0;
      buttonClicked = [false, false, false, false];
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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.07), // 10% top padding
                  Expanded(
                    child: Image.asset(
                      'assets/one.jpg',
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.13), // 10% bottom padding
                ],
              ),       
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.02, // 5% from bottom
                left: MediaQuery.of(context).size.width * 0.25,
                child: IconButton(
                  icon: Icon(
                    Icons.refresh,
                    size: 60,
                  ),
                  color: Colors.yellow,
                  onPressed: resetCountAndButtons,
                ),
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.055, // 5% from bottom
                left: MediaQuery.of(context).size.width * 0.40,
                child: Image.asset(
                  'assets/one.png',
                  width: 60,
                  height: MediaQuery.of(context).size.height * 0.05, // 5% of screen height
                ),
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.01, // 5% from bottom
                left: MediaQuery.of(context).size.width * 0.40,
                child: Text(
                  '$count/4',
                  style: TextStyle(
                    color: Colors.yellow,
                    fontWeight: FontWeight.bold,
                    fontSize: 30, // 4% of screen height
                  ),
                ),
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.02, // 5% from bottom
                right: MediaQuery.of(context).size.width * 0.40,
                child: IconButton(
                  icon: Icon(
                    Icons.mic,
                    size: 60,
                  ),
                  color: Colors.yellow,
                  onPressed: () async {
                    // Handle microphone icon press here
                    // Add your logic for recording or any other action
                    await flutterTts.setLanguage("en-US");
                    await flutterTts.setPitch(1.0); // Adjust the pitch of the voice
                    await flutterTts
                        .speak("Please find all occurrences of number 1");
                    // Wait for the English speech to finish plus an additional pause
                    await Future.delayed(
                        Duration(seconds: 1)); // Adjust the delay as needed

                    // Speak in Spanish
                    await flutterTts.setLanguage("es-ES");
                    await flutterTts.speak(
                        "Por favor, encuentra todas las ocurrencias del número uno");
                  },
                ),
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.02, // 5% from bottom
                right: MediaQuery.of(context).size.width * 0.25,
                child: IconButton(
                  icon: Icon(
                    Icons.lightbulb_outline,
                    size: 60,
                  ),
                  color: Colors.yellow,
                  onPressed: () {},
                ),
              ),
              // Buttons positioned based on the device's orientation
              Positioned(
                top: MediaQuery.of(context).size.height * 0.10, // 5% from bottom
                left: MediaQuery.of(context).size.width * 0.07,
                child: buildButton(0),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.31, // 5% from bottom
                right: MediaQuery.of(context).size.width * 0.40,
                child: buildButton(1),
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.35, // 5% from bottom
                right: MediaQuery.of(context).size.width * 0.13,
                child: buildButton(2),
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.17, // 5% from bottom
                right: MediaQuery.of(context).size.width * 0.40,
                child: buildButton(3),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.02, // 5% from bottom
                left: MediaQuery.of(context).size.width * 0.40,
                child: Text(
                  'Level 1',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
              ),
              HomeWidget(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Numbers.NumbersPage()),
                  );
                },
              ),
              MenuWidget(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildButton(int index) {
    return Material(
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
            if (!buttonClicked[index]) {
              setState(() {
                count++;
                buttonClicked[index] = true;
              });
            }
          },
        ),
      ),
    );
  }
}
