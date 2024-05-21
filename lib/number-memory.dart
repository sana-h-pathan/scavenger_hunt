import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_tts/flutter_tts.dart'; // Import flutter_tts
import 'background.dart';
import 'header.dart';
import 'home.dart';

class NumberMemoryGame extends StatelessWidget {
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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.20),
                  Expanded(
                    child: NumberMemoryGameScreen(),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.11),
                ],
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.05,
                left: MediaQuery.of(context).size.width * 0.25,
                child: const Text(
                  'Find the Match',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                  ),
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
            ],
          );
        },
      ),
    );
  }
}

class NumberMemoryGameScreen extends StatefulWidget {
  @override
  _NumberMemoryGameScreenState createState() => _NumberMemoryGameScreenState();
}

class _NumberMemoryGameScreenState extends State<NumberMemoryGameScreen> {
  late List<int> numbers;
  late List<bool> cardVisible;
  List<int> flippedIndices = [];
  bool isProcessing = false;
  Timer? timer;
  int timeLeft = 60;
  bool isBlinking = false;
  
  final player = AudioCache();

  @override
  void initState() {
    super.initState();
    initializeGame();
    startTimer();
  }

  void initializeGame() {
    setState(() {
      var random = Random();
      Set<int> uniqueNumbers = Set();

      while (uniqueNumbers.length < 6) {
        int randomNumber = random.nextInt(10) + 1;
        uniqueNumbers.add(randomNumber);
      }

      numbers = [];
      uniqueNumbers.forEach((number) {
        numbers.add(number);
        numbers.add(number);
      });

      numbers.shuffle();
      cardVisible = List.filled(numbers.length, false);
      flippedIndices.clear();
      isProcessing = false;
    });
  }

  final FlutterTts flutterTts = FlutterTts();


  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        timeLeft--;
        if (timeLeft == 0) {
            // Handle when time runs out
          timer?.cancel(); // Stop the timer
          initializeGame(); // Reset the game
          timeLeft = 60; // Reset the timer to 60 seconds
          startTimer();
        } else if (timeLeft <= 5) {
          // Start blinking when time is less than or equal to 5 seconds
          isBlinking = !isBlinking;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Calculate the width and height for each box
    double boxWidth = (screenWidth - 50) / 4; // Adjust 50 according to your padding requirements
    double boxHeight = (screenHeight * 0.6) / 3; // Assuming you want 3 rows and 60% of screen height for cards

    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: boxWidth / boxHeight, // Set aspect ratio based on calculated width and height
            ),
            itemCount: numbers.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  if (!isProcessing && !flippedIndices.contains(index) && !cardVisible[index]) {
                    setState(() {
                      cardVisible[index] = true;
                      flippedIndices.add(index);
                    });
                    if (flippedIndices.length == 2) {
                      checkMatch();
                    }
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0), // Add padding to each box
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: cardVisible[index]
                            ? [const Color.fromARGB(255, 159, 18, 18).withOpacity(0.8), const Color.fromARGB(255, 186, 204, 29).withOpacity(0.6)]
                            : [Colors.pink.withOpacity(0.8), Colors.blue.withOpacity(0.6)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    width: boxWidth,
                    height: boxHeight,
                    child: Center(
                      child: Text(
                        cardVisible[index] ? '${_getDisplayContent(index)}' : '',
                        style: const TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10.0),
          width: 120,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Center(
            child: Text(
              '$timeLeft sec',
              style: TextStyle(
                fontSize: 24,
                color: timeLeft <= 5 && isBlinking ? Colors.red : Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _getDisplayContent(int index) {
    // Return digit for even indices and spelling for odd indices
    int number = numbers[index];
    if (index.isEven) {
      return '$number';
    } else {
      return _getSpelledNumber(number);
    }
  }

  String _getSpelledNumber(int number) {
    List<String> numberTexts = ['Zero','One', 'Two', 'Three', 'Four', 'Five', 'Six', 'Seven', 'Eight', 'Nine', 'Ten'];
    return '${numberTexts[number]}';
  }

  void checkMatch() {
    isProcessing = true;
    if (numbers[flippedIndices[0]] != numbers[flippedIndices[1]]) {
      Timer(const Duration(milliseconds: 500), () {
        setState(() {
          cardVisible[flippedIndices[0]] = false;
          cardVisible[flippedIndices[1]] = false;
          flippedIndices.clear();
          isProcessing = false;
        });
      });
    } else {
      setState(() {
        flippedIndices.clear();
        isProcessing = false;

        if (cardVisible.every((visible) => visible)) {
          // All cards are matched, show congratulatory dialog
          _showCongratulationDialog();
        }
      });
    }
  }

  void _showCongratulationDialog() {
    // Stop the timer
    timer?.cancel();

    // Play clapping sound
    player.play('clapping_sound.mp3');
    
    // Speak congratulatory message
    flutterTts.speak('Congratulations! You Matched all numbers!');

    // Show congratulatory dialog
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.grey[900], // Change background color
        title: const Text(
          'Congratulations!',
          style: TextStyle(
            color: Colors.green, // Change text color
            fontSize: 30.0, // Increase font size
          ),
        ),
        content: const Text(
          'Congratulations! You Matched all numbers!',
          style: TextStyle(
            color: Colors.white, // Change text color
            fontSize: 24.0, // Increase font size
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
            },
            child: const Text('OK',
              style: TextStyle(
                color: Colors.white, // Change text color
                fontSize: 18.0, // Increase font size
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              initializeGame(); // Reset the game
              timeLeft = 60; // Reset the timer to 60 seconds
              startTimer(); // Start the timer again
            },
            child: const Text('Replay',
              style: TextStyle(
                color: Colors.white, // Change text color
                fontSize: 18.0, // Increase font size
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context); // Go back to the home screen
            },
            child: const Text(
              'Home',
              style: TextStyle(
                color: Colors.white, // Change text color
                fontSize: 18.0, // Increase font size
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}

void main() {
  runApp(MaterialApp(
    home: NumberMemoryGame(),
  ));
}