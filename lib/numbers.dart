import 'package:flutter/material.dart';
import 'package:scavanger_hunt/number-memory.dart';
import 'package:scavanger_hunt/page-eight.dart';
import 'package:scavanger_hunt/page-five.dart';
import 'package:scavanger_hunt/page-nine.dart';
import 'package:scavanger_hunt/page-seven.dart';
import 'package:scavanger_hunt/page-six.dart';
import 'package:scavanger_hunt/page-ten.dart';
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
          _buildScavengerHuntSection(),
          Positioned.fill(
            child: _buildImageSection(context),
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
              ); // Handle home button press here
            },
          ),
          MenuWidget(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              ); // Handle home button press here
            },
          ),
          // Number buttons and connecting lines
          ..._buildNumberButtons(context),
        ],
      ),
    );
  }

  Widget _buildScavengerHuntSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 80), // Add space between title and letters
        ScavengerHuntText(), // Reusable Scavenger Hunt text
      ],
    );
  }

  Widget _buildImageSection(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: MediaQuery.of(context).size.height * 0.19), // 10% top padding
        Expanded(
          child: Image.asset(
            'assets/numberlevel.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02), // 10% bottom padding
      ],
    );
  }

  List<Widget> _buildNumberButtons(BuildContext context) {
    List<Widget> buttons = [];
    List<Offset> buttonPositions = [];
    double buttonSize = 60.0;
    double padding = 20.0;

    // Coordinates for the zigzag pattern resembling 'S'
    List<Offset> zigzagPoints = [
      Offset(600, 1120), //1
      Offset(240, 1080), //2
      Offset(600, 1000), //3
      Offset(300, 920), //4
      Offset(550, 850), //5
      Offset(320, 780), //6
      Offset(490, 720), //7
      Offset(360, 660), //8
      Offset(450, 600), //9
      Offset(410, 500), //10
    ];

    for (int i = 0; i < zigzagPoints.length; i++) {
      double xPos = zigzagPoints[i].dx - buttonSize / 2;
      double yPos = zigzagPoints[i].dy - buttonSize / 2;

      buttonPositions.add(Offset(xPos + buttonSize / 2, yPos + buttonSize / 2));

      Widget button = Positioned(
        left: xPos,
        top: yPos,
        child: _buildNumberButton(context, i),
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
            buttonSize),
      );
      buttons.add(line);
    }
    return buttons;
  }

  Widget _buildNumberButton(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        switch (index) {
          case 0:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PageOne()),
            );
            break;
          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PageTwo()),
            );
            break;
          case 2:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PageThree()),
            );
            break;
          case 3:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PageFour()),
            );
            break;
          case 4:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PageFive()),
            );
            break;
          case 5:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PageSix()),
            );
            break;
          case 6:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PageSeven()),
            );
            break;
            case 7:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PageEight()),
            );
            break;
          case 8:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PageNine()),
            );
            break;
          case 9:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PageTen()),
            );
            break;
          // Add cases for other button clicks similarly
        }
      },
      child: Container(
        width: 60.0,
        height: 60.0,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 176, 39, 151),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            (index + 1).toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
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
      ..color = Colors.white
      ..strokeWidth = 3
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

    canvas.drawLine(
        Offset(adjustedStartX, adjustedStartY), Offset(adjustedEndX, adjustedEndY), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
