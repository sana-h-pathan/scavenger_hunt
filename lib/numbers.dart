import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'header.dart';
import 'background.dart';
import 'page-one.dart';
import 'page-two.dart';
import 'page-three.dart';
import 'page-four.dart';
import 'home.dart';

class NumbersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundGradient(), // Use background from background.dart
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 40), // Add space from the top
              const SizedBox(height: 40), // Add space between title and letters
              ScavengerHuntText(), // Reusable Scavenger Hunt text
              const SizedBox(height: 20), // Add space between text and counter
            ],
          ),
          DiagonalWidget1(), // Add diagonal widgets from header.dart
          DiagonalWidget2(), // Add diagonal widgets from header.dart
          DiagonalWidget3(), // Add diagonal widgets from header.dart
          DiagonalWidget4(), // Add diagonal widgets from header.dart
          HomeWidget(
            onPressed: () {
                  Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );// Handle home button press here
            },
          ),
          MenuWidget(
            onPressed: () {
                  Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );// Handle home button press here
            },
          ),
          // Number buttons and connecting lines
          ..._buildNumberButtons(context),
        ],
      ),
    );
  }

  List<Widget> _buildNumberButtons(BuildContext context) {
  List<Widget> buttons = [];
  List<Offset> buttonPositions = [];
  double buttonSize = 110.0; 
  double padding = 20.0;

  // Coordinates for the zigzag pattern resembling 'S'
  List<Offset> zigzagPoints = [
    Offset(100, 1100), //1
    Offset(350, 1050), //2
    Offset(500, 970), //3
    Offset(650, 880), //4
    Offset(300, 750), //5
    Offset(600, 600), //6
    Offset(300, 550), //7
    Offset(150, 450), //8
    Offset(500, 350), //9
    Offset(750, 300), //10
  ];

  for (int i = 0; i < zigzagPoints.length; i++) {
    double xPos = zigzagPoints[i].dx - buttonSize / 2;
    double yPos = zigzagPoints[i].dy - buttonSize / 2;

    buttonPositions.add(Offset(xPos + buttonSize / 2, yPos + buttonSize / 2));

    Widget button = Positioned(
    left: xPos,
    top: yPos,
    child: GestureDetector(
      onTap: () {
        if (i == 0) {
          // Button 1 pressed
          // Add your action here for button 1
          print('Button 1 pressed');
          // Button 1 pressed
          // Navigate to PageOne
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PageOne()),
          );
        } else if (i == 1) {
          // Button 2 pressed
          // Add your action here for button 2
          print('Button 2 pressed');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PageTwo()),
          );
        } else if (i == 2) {
          // Button 2 pressed
          // Add your action here for button 2
          print('Button 3 pressed');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PageThree()),
          );
        } 
        else if (i == 3) {
          // Button 2 pressed
          // Add your action here for button 2
          print('Button 4 pressed');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PageFour()),
          );
        } 
        // Add conditions for other button clicks similarly
      },
      child: Container(
        width: buttonSize,
        height: buttonSize,
        decoration: BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            (i + 1).toString(),
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ),
  );
  buttons.add(button);
  }

  for (int i = 0; i < buttonPositions.length - 1; i++) {
    Widget line = CustomPaint(
      painter: LinePainter(
        buttonPositions[i].dx,
        buttonPositions[i].dy,
        buttonPositions[i + 1].dx,
        buttonPositions[i + 1].dy,
        buttonSize
      ),
    );
    buttons.add(line);
  }
  return buttons;
}

}



class LinePainter extends CustomPainter {
  final double startX;
  final double startY;
  final double endX;
  final double endY;
  final double buttonSize;

  LinePainter(this.startX, this.startY, this.endX, this.endY, this.buttonSize);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    // Calculate the direction vector from start to end
    double dx = endX - startX;
    double dy = endY - startY;

    // Calculate the length of the direction vector
    double length = math.sqrt(dx * dx + dy * dy);

    // Normalize the direction vector
    double normalizedDx = dx / length;
    double normalizedDy = dy / length;

    // Calculate the start point adjusted to the circumference of the circle button
    double adjustedStartX = startX + normalizedDx * (buttonSize / 2);
    double adjustedStartY = startY + normalizedDy * (buttonSize / 2);

    // Calculate the end point adjusted to the circumference of the circle button
    double adjustedEndX = endX - normalizedDx * (buttonSize / 2);
    double adjustedEndY = endY - normalizedDy * (buttonSize / 2);

    canvas.drawLine(Offset(adjustedStartX, adjustedStartY), Offset(adjustedEndX, adjustedEndY), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}


