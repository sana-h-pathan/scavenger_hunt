import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'header.dart';
import 'background.dart';

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
              const SizedBox(height: 20), // Add space from the top
              const SizedBox(height: 40), // Add space between title and letters
              ScavengerHuntText(), // Reusable Scavenger Hunt text
              const SizedBox(height: 20), // Add space between text and counter
            ],
          ),
          DiagonalWidget1(), // Add diagonal widgets from header.dart
          DiagonalWidget2(), // Add diagonal widgets from header.dart
          DiagonalWidget3(), // Add diagonal widgets from header.dart
          DiagonalWidget4(), // Add diagonal widgets from header.dart
          // Number buttons and connecting lines
          ..._buildNumberButtons(context),
        ],
      ),
    );
  }

  List<Widget> _buildNumberButtons(BuildContext context) {
    List<Widget> buttons = [];
    List<Offset> buttonPositions = [];
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double buttonSize = 80.0; 
    double padding = 20.0;

    for (int i = 1; i <= 10; i++) {
      double xPos = math.Random().nextDouble() * (screenWidth - buttonSize);
      double yPos = screenHeight  - (i * (buttonSize + padding));
      if(i==10)
        yPos=yPos+30;

      buttonPositions.add(Offset(xPos + buttonSize / 2, yPos + buttonSize / 2));

      Widget button = Positioned(
        left: xPos,
        top: yPos,
        child: Container(
          width: buttonSize,
          height: buttonSize,
          decoration: BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              i.toString(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 24, 
                fontWeight: FontWeight.bold,
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


