import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:scavanger_hunt/app_score.dart';
import 'package:scavanger_hunt/page-four.dart';
import 'header.dart';
import 'background.dart';
import 'home.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:scavanger_hunt/numbers.dart' as Numbers;
import 'package:flutter/services.dart' show rootBundle;
import 'package:scavanger_hunt/app_language.dart';
import 'dart:async';

class PageThree extends StatefulWidget {
  @override
  _PageThreeState createState() => _PageThreeState();
}

class _PageThreeState extends State<PageThree>
    with SingleTickerProviderStateMixin {
  Timer? _timer;
  int _start = 60;

  int count = 0;
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  bool _isAnimationVisible = true;

  Future<void> stage_finished() async {
    speakMessage("You have found all occurrences of number 3");
    print("AppScore");
    print(AppScore().currentScore);
  }

  FlutterTts flutterTts = FlutterTts();
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
    0: "Reach me through ladder",
    1: "I am hanging in water",
    2: "I am on arms",
    3: "Below the stone"
  };
  Map<int, bool> buttonClicked = {0: false, 1: false, 2: false, 3: false};

  void resetCountAndButtons() {
    setState(() {
      count = 0;
      buttonClicked = {0: false, 1: false, 2: false, 3: false};
      resetTimer();
      AppScore().setStageScore(3, 0);
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
            buttonClicked = {
              0: false,
              1: false,
              2: false,
              3: false
            }; // Reset the buttons
            timer.cancel();
            resetTimer(); // Restart the timer
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        AppScore().setStageScore(3, 0);
      });
    });
    // Initialize the animation controller and animation
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
      speakMessage("page_three_message");
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
                          0.07), // 10% top padding
                  Expanded(
                    child: Image.asset(
                      'assets/three.jpg',
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
                  message: 'Reset', // Tooltip message
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
                  'assets/three.png',
                  width: 60,
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.01,
                left: MediaQuery.of(context).size.width * 0.40,
                child: Text(
                  '$count/4',
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
                    speakMessage("page_three_message");
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
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 36,
                    color: Colors.yellow,
                  ),
                ),
              ),
              Positioned(
                top:
                    MediaQuery.of(context).size.height * 0.15, // 5% from bottom
                right: MediaQuery.of(context).size.width * 0.05,
                child: buildButton(0),
              ),
              Positioned(
                top:
                    MediaQuery.of(context).size.height * 0.31, // 5% from bottom
                left: MediaQuery.of(context).size.width * 0.40,
                child: buildButton(1),
              ),
              Positioned(
                bottom:
                    MediaQuery.of(context).size.height * 0.40, // 5% from bottom
                left: MediaQuery.of(context).size.width * 0.07,
                child: buildButton(2),
              ),
              Positioned(
                bottom:
                    MediaQuery.of(context).size.height * 0.26, // 5% from bottom
                left: MediaQuery.of(context).size.width * 0.03,
                child: buildButton(3),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.02,
                left: MediaQuery.of(context).size.width * 0.40,
                child: const Text(
                  'Find 3',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
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
              const ScoreWidget(),
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
                                'assets/three.png',
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
                          child: const Text("OK"),
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
          onPressed: () {
            if (!buttonClicked[index]!) {
              setState(() {
                count++;
                buttonClicked[index] = true;
                AppScore().setStageScore(3, AppScore().getStageScore(3)! + 100);
                if (count == 4) {
                  _showStarsDialog();
                  flutterTts.speak(
                      "Congratulations!! You have found all occurrences of number three");
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
                  fontSize: 30,
                ),
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
                  // Navigate to PageFour
                  context,
                  MaterialPageRoute(builder: (context) => PageFour()),
                );
              },
              child: const Text(
                'Next Level',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
