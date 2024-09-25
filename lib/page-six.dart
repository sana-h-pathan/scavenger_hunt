import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:scavanger_hunt/app_score.dart';
import 'package:scavanger_hunt/page-seven.dart';
import 'header.dart';
import 'background.dart';
import 'home.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:scavanger_hunt/numbers.dart' as Numbers;
import 'package:flutter/services.dart' show rootBundle;
import 'package:scavanger_hunt/app_language.dart';
import 'dart:async';

class PageSix extends StatefulWidget {
  @override
  _PageSixState createState() => _PageSixState();
}

class _PageSixState extends State<PageSix> with SingleTickerProviderStateMixin{
  Timer? _timer;
  int _start = 60;

  int count = 0;
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  bool _isAnimationVisible = true;
  FlutterTts flutterTts = FlutterTts();
  
  Future<void> stage_finished() async {
    speakMessage("You have found all occurrences of number 5");
    print("AppScore");
    print(AppScore().currentScore);
  }
  
  Future<void> speakMessage(String messageKey) async {
    String languageCode = AppLanguage().currentLanguage;
    String data =
        await rootBundle.loadString('assets/texts/$languageCode.json');
    Map<String, dynamic> texts = json.decode(data);
    //String message = texts[messageKey];
   
    await flutterTts.setLanguage(languageCode);
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(messageKey);
  }

  Future<void> speakHint(String message) async {
      await flutterTts.setLanguage("en-US");
      await flutterTts.setPitch(1.0);
      await flutterTts.speak(message);
    }

  Map<int, String> buttonToHint = {
    0: "I'm on the hammer",
    1: "Find me on the head",
    2: "I'm here on the hand",
    3: "Find me above the hulk hair",
    4: "Fine me near green hulk",
    5: "Find me on the chest"
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
      resetTimer();
      AppScore().setStageScore(6, 0);
      AppScore().resetStageScore();
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
             count = 0; // Reset the counter
            buttonClicked = {0: false, 1: false, 2: false, 3: false/*, 4: false, 5: false*/}; // Reset the buttons
            
            //print("Timer Completed"); // Debug when timer reaches 0
            
          });
          timer.cancel();
           resetTimer();
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
    // startTimer();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        AppScore().setStageScore(6, 0);
      });
    });
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Start the animation and play the sound
    _controller.forward().then((_) {
      speakMessage("page_six_message");
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int minutes = _start ~/ 60;
    int seconds = _start % 60;
    String formattedTime =
        '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
         int scoreToDisplay = AppScore().currentScore;
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
                          0.07), 
                  Expanded(
                    child: Image.asset(
                      'assets/six.jpg',
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height *
                          0.11), 
                ],
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.028,
                left: MediaQuery.of(context).size.width * 0.005,
                child: Text(
                  'Score : $scoreToDisplay',
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.yellow,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.02,
                left: MediaQuery.of(context).size.width * 0.25,
                child: Tooltip(
                  message: 'Reset',
                child: IconButton(
                  icon: const Icon(
                    Icons.refresh,
                    size: 60,
                  ),
                  color: Colors.yellow,
                  onPressed: resetCountAndButtons,
                ),
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
                    speakMessage("page_six_message");
                    /*await flutterTts.setLanguage("en-US");
                    await flutterTts.setPitch(1.0);
                    await flutterTts
                        .speak("Please find all occurrences of number 6");
                    await Future.delayed(const Duration(seconds: 5));
                    await flutterTts.setLanguage("es-ES");
                    await flutterTts.speak(
                        "Por favor, encuentra todas las ocurrencias del número uno");*/
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
                      /*speakMessage(
                          "You have found all occurrences of number 6");*/
                          stage_finished();
                    }
                    // Speak the hint if the button hasn't been clicked
                    for (int i = 0; i < buttonToHint.length; i++) {
                      if (!buttonClicked[i]!) {
                        await speakHint(buttonToHint[i]!);
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
              ScoreWidget(),
              const LanguageWidget(),
             // Animation Overlay
              if (_isAnimationVisible)
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: MediaQuery.of(context).size.width * 0.5,
                            child: SlideTransition(
                              position: _offsetAnimation,
                              child: Image.asset(
                                'assets/six.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _isAnimationVisible = false;
                            });
                            startTimer(); // Start the timer when OK is pressed
                          },
                          child:  Text("OK"),
                        ),
                      ],
                    ),
                  ),
                ),
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
          //iconSize: 50,
          onPressed: () {
            if (!buttonClicked[index]!) {
              setState(() {
                count++;
                buttonClicked[index] = true;
                AppScore().setStageScore(6, AppScore().getStageScore(6)! + 100);
                if (count == 6) {
                  _showStarsDialog();
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

  void _showStarsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.blueGrey, // Change background color
          title: Column(
            children: [
              const Text(
            'Congratulations!',
            style: TextStyle(
                color: Colors.yellow,
                fontSize: 30), // Change text color and size
          ),
          Text(
                'Your Score: ${AppScore().currentScore}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ],
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
                  // Navigate to Pageseven
                  context,
                  MaterialPageRoute(builder: (context) => PageSeven()),
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
