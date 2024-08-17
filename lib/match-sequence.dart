import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'background.dart';
import 'header.dart';
import 'home.dart';
import 'package:scavanger_hunt/app_language.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;


class NumberSequenceQuiz extends StatefulWidget {
  @override
  _NumberSequenceQuizState createState() => _NumberSequenceQuizState();
}

class _NumberSequenceQuizState extends State<NumberSequenceQuiz> {
  final FlutterTts flutterTts = FlutterTts();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Stack(
            children: [
              BackgroundGradient(), // Use your background widget here
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).size.height * 0.20),
                  Expanded(
                    child: NumberSequenceQuizScreen(),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.11),
                ],
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.10,
                left: MediaQuery.of(context).size.width * 0.15,
                child: const Text(
                  'Number Sequence Quiz',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                  ),
                ),
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.02,
                right: MediaQuery.of(context).size.width * 0.45,
                child: IconButton(
                  icon: const Icon(
                    Icons.mic,
                    size: 60,
                  ),
                  color: Colors.white,
                  onPressed: () async {
                    flutterTts.speak('Select the number in sequence');
                    // Add functionality here if needed
                  },
                ),
              ),
              HomeWidget(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
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
              LanguageWidget(),
            ],
          );
        },
      ),
    );
  }
}

class NumberSequenceQuizScreen extends StatefulWidget {
  @override
  _NumberSequenceQuizScreenState createState() =>
      _NumberSequenceQuizScreenState();
}

class _NumberSequenceQuizScreenState extends State<NumberSequenceQuizScreen> {
  List<int> numbers = List.generate(10, (index) => index + 1)..shuffle();
  int currentIndex = 0;
  bool completed = false;

  final player = AudioCache();
  final FlutterTts flutterTts = FlutterTts();

  Timer? timer;
  int timeLeft = 30;
  int score = 0;
  bool isBlinking = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        timeLeft--;
        if (timeLeft == 0) {
          restartGame();
        } else if (timeLeft <= 5) {
          isBlinking = !isBlinking;
        }
      });
    });
  }

  void restartGame() {
    setState(() {
      currentIndex = 0;
      completed = false;
      timeLeft = 30;
      isBlinking = false;
      score = 0;
      numbers = List.generate(10, (index) => index + 1)..shuffle();
    });
  }

   Future<void> speakMessage(String messageKey) async {
    String languageCode = AppLanguage().currentLanguage;
    String data =
        await rootBundle.loadString('assets/texts/$languageCode.json');
    Map<String, dynamic> texts = json.decode(data);
    await flutterTts.setLanguage(languageCode);
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(messageKey);
  }


  @override
  void dispose() {
    timer?.cancel();
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> numberTexts = ['One', 'Two', 'Three', 'Four', 'Five', 'Six', 'Seven', 'Eight', 'Nine', 'Ten'];

    return Stack(
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Tap the numbers in sequence',
                style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 60.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0; i < 4; i++) _buildNumberContainer(i, numberTexts),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 4; i < 8; i++) _buildNumberContainer(i, numberTexts),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 8; i < numbers.length; i++) _buildNumberContainer(i, numberTexts),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical:0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Score: $score',
                  style: const TextStyle(
                    color: Colors.yellow,
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.refresh),
                  color: Colors.yellow,
                  iconSize: 60.0,
                  onPressed: () {
                    restartGame();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.mic),
                  color: Colors.yellow,
                  iconSize: 60.0,
                  onPressed: () {
                    speakMessage('Please tap the numbers in sequence.');
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.lightbulb_outline),
                  color: Colors.yellow,
                  iconSize: 60.0,
                  onPressed: () {
                    _showHint();
                  },
                ),
                Text(
                  '$timeLeft sec',
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: timeLeft <= 5 && isBlinking ? Colors.red : Colors.yellow,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showHint() {
    speakMessage('Tap the smallest number available.');
  }

  Widget _buildNumberContainer(int index, List<String> numberTexts) {
    bool showText = index.isEven;

    return GestureDetector(
      onTap: () {
        if (!completed) {
          if (numbers[index] == currentIndex + 1) {
            setState(() {
              currentIndex++;
              score += 10;
              speakMessage(numberTexts[numbers[index] - 1]);
              if (currentIndex == numbers.length) {
                completed = true;
                _showCongratulationDialog();
              }
            });
          } else {
            _showErrorDialog();
          }
        }
      },
      child: Container(
        width: 160.0,
        height: 160.0,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        decoration: BoxDecoration(
          color: numbers[index] <= currentIndex ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (showText)
              Text(
                '${numberTexts[numbers[index] - 1]}',
                style: const TextStyle(
                  fontSize: 36.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              )
            else
              Text(
                '${numbers[index]}',
                style: const TextStyle(
                  fontSize: 50.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showErrorDialog() {
    speakMessage('Oh, you selected the wrong number. Please try again.');

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text(
          'Oh, you selected the wrong number!',
          style: TextStyle(
            color: Colors.red,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          'Please try again.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                currentIndex = 0;
                completed = false;
                timeLeft = 30;
                isBlinking = false;
              });
              restartGame();
              Navigator.pop(context);
            },
            child: const Text(
              'OK',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCongratulationDialog() {
    player.play('clapping_sound.mp3');
    speakMessage('Congratulations!! You are awesome!!');

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text(
          'Congratulations!',
          style: TextStyle(
            color: Colors.green,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          'You are awesome!',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text(
              'Home',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              restartGame();
              Navigator.pop(context);
            },
            child: const Text(
              'Replay',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}