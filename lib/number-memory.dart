import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_tts/flutter_tts.dart'; // Import flutter_tts
import 'background.dart';
import 'header.dart';
import 'home.dart';
import 'package:scavanger_hunt/app_language.dart';




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
             LanguageWidget()
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
 int timeLeft = 90;
 bool isBlinking = false;
 int score = 0;
 int matchCount = 0; // Count of matched pairs
 final player = AudioCache();


 final FlutterTts flutterTts = FlutterTts();


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


 void startTimer() {
   timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
     setState(() {
       timeLeft--;
       if (timeLeft == 0) {
         timer?.cancel();
         initializeGame();
         timeLeft = 90;
         startTimer();
       } else if (timeLeft <= 5) {
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
   double boxWidth = (screenWidth - 50) / 4; // Adjust according to your padding requirements
   double boxHeight = (screenHeight * 0.6) / 3; // Assuming 3 rows and 60% of screen height for cards


   return Column(
     children: [
       Expanded(
         child: GridView.builder(
           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
             crossAxisCount: 4,
             crossAxisSpacing: 10.0,
             mainAxisSpacing: 10.0,
             childAspectRatio: 1.0, // Ensures each card is square
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
                 padding: const EdgeInsets.all(8.0),
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
                   height: boxWidth, // Ensure equal height and width for square cards
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
       Row(
         mainAxisAlignment: MainAxisAlignment.spaceAround,
         children: [
           Text(
             'Score: $score',
             style: const TextStyle(
               fontSize: 35,
               color: Colors.yellow,
               fontWeight: FontWeight.bold,
             ),
           ),
           IconButton(
             icon: const Icon(Icons.refresh, color: Colors.yellow),
             iconSize: 60,
             onPressed: () {
               setState(() {
                 initializeGame();
                 timeLeft = 90;
                 score = 0;
                 matchCount = 0; // Reset match count
                 timer?.cancel();
                 startTimer();
               });
             },
           ),
           Positioned(
             bottom: MediaQuery.of(context).size.height * 0.01,
             left: MediaQuery.of(context).size.width * 0.40,
             child: Text(
               '$matchCount/6',
               style: const TextStyle(
                 color: Colors.yellow,
                 fontWeight: FontWeight.bold,
                 fontSize: 30,
               ),
             ),
           ),
           IconButton(
             icon: const Icon(Icons.mic, color: Colors.yellow),
             iconSize: 60,
             onPressed: () {
               flutterTts.speak('Match the numbers. Current Score is $score. Time left is ${_formatTime(timeLeft)}.');
             },
           ),
           IconButton(
             icon: const Icon(Icons.lightbulb, color: Colors.yellow),
             iconSize: 60,
             onPressed: () {
               provideHint(); // Call the hint function
             },
           ),
           Text(
             '${_formatTime(timeLeft)}',
             style: const TextStyle(
               fontSize: 30,
               color: Colors.yellow,
               fontWeight: FontWeight.bold,
             ),
           ),
         ],
       ),
     ],
   );
 }


 String _getDisplayContent(int index) {
   int number = numbers[index];
   return index.isEven ? '$number' : _getSpelledNumber(number);
 }


 String _getSpelledNumber(int number) {
   List<String> numberTexts = ['Zero', 'One', 'Two', 'Three', 'Four', 'Five', 'Six', 'Seven', 'Eight', 'Nine', 'Ten'];
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
       score += 100;
       matchCount += 1; // Increment matched count
       flippedIndices.clear();
       isProcessing = false;


       if (matchCount == 10) {
         _showCongratulationDialog();
       }
     });
   }
 }


 void provideHint() {
   if (matchCount < 10) {
     // Find one pair to reveal
     for (int i = 0; i < numbers.length; i++) {
       if (!cardVisible[i]) {
         int number = numbers[i];
         // Find the second index of the same number
         for (int j = 0; j < numbers.length; j++) {
           if (numbers[j] == number && !cardVisible[j] && i != j) {
                           // Show the pair for a short duration
             setState(() {
               cardVisible[i] = true;
               cardVisible[j] = true;
             });


             // Hide the cards after 2 seconds
             Timer(const Duration(seconds: 2), () {
               setState(() {
                 cardVisible[i] = false;
                 cardVisible[j] = false;
               });
             });


             return; // Exit after revealing one hint pair
           }
         }
       }
     }
   }
 }


 String _formatTime(int seconds) {
   final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
   final secs = (seconds % 60).toString().padLeft(2, '0');
   return '$minutes:$secs';
 }


 void _showCongratulationDialog() {
   timer?.cancel();
   player.play('clapping_sound.mp3');
   flutterTts.speak('Congratulations! You matched all numbers!');


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
         'Congratulations! You matched all numbers!',
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
           child: const Text(
             'OK',
             style: TextStyle(
               color: Colors.white, // Change text color
               fontSize: 18.0, // Increase font size
             ),
           ),
         ),
         TextButton(
           onPressed: () {
             Navigator.pop(context); // Close dialog
             setState(() {
               initializeGame(); // Reset the game
               timeLeft = 90; // Reset the timer to 60 seconds
               score = 0; // Reset score
               matchCount = 0; // Reset match count
               startTimer(); // Start the timer again
             });
           },
           child: const Text(
             'Replay',
             style: TextStyle(
               color: Colors.white, // Change text color
               fontSize: 18.0, // Increase font size
             ),
           ),
         ),
         TextButton(
           onPressed: () {
             Navigator.pop(context); // Close dialog
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



