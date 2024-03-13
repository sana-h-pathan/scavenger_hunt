import 'dart:math';

import 'package:flutter/material.dart';
import 'background.dart';
import 'header.dart';
import 'home.dart';
import 'dart:async';


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
                top: MediaQuery.of(context).size.height * 0.10,
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
                    MaterialPageRoute(builder: (context) => HomeScreen()),
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

  @override
  void initState() {
    super.initState();
    initializeGame();
  }

  void initializeGame() {
    numbers = [];
    var random = Random();
    Set<int> uniqueNumbers = Set();

    while (uniqueNumbers.length < 6) {
      int randomNumber = random.nextInt(10) + 1;
      uniqueNumbers.add(randomNumber);
    }

    uniqueNumbers.forEach((number) {
      numbers.add(number);
      numbers.add(number);
    });

    numbers.shuffle();
    cardVisible = List.filled(numbers.length, false);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Calculate the width and height for each box
    double boxWidth = (screenWidth - 50) / 4; // Adjust 50 according to your padding requirements
    double boxHeight = (screenHeight * 0.6) / 3; // Assuming you want 3 rows and 60% of screen height for cards

    return GridView.builder(
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
            padding: EdgeInsets.all(8.0), // Add padding to each box
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: cardVisible[index]
                      ? [Color.fromARGB(255, 159, 18, 18).withOpacity(0.8), Color.fromARGB(255, 186, 204, 29).withOpacity(0.6)]
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
                  cardVisible[index] ? '${numbers[index]}' : '',
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
    );
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
      });
    }
  }
}


