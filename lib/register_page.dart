import 'package:flutter/material.dart';
import 'dart:math' as math;

class NumbersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.3, 1.0],
            colors: [
              Color(0xFF3349BE),
              Color(0xFFFFFFFF),
            ],
          ),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 20),
                const SizedBox(height: 40),
                Text('Scavenger Hunt'), // Updated text
                const SizedBox(height: 20),
              ],
            ),
            Positioned(
              top: 160,
              left: 30,
              child: Transform.rotate(
                angle: -math.pi / 4,
                child: Container(
                  width: 50,
                  height: 50,
                  color: Colors.green,
                  child: Center(
                    child: Text(
                      '3',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 160,
              right: 30,
              child: Transform.rotate(
                angle: math.pi / 4,
                child: Container(
                  width: 50,
                  height: 50,
                  color: Colors.red,
                  child: Center(
                    child: Text(
                      '9',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 40,
              left: 30,
              child: Transform.rotate(
                angle: -math.pi / 4,
                child: Container(
                  width: 50,
                  height: 50,
                  color: Colors.orange,
                  child: Center(
                    child: Text(
                      '1',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 40,
              right: 30,
              child: Transform.rotate(
                angle: math.pi / 4,
                child: Container(
                  width: 50,
                  height: 50,
                  color: Colors.purple,
                  child: Center(
                    child: Text(
                      '4',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Number buttons and connecting lines
            ..._buildNumberButtons(context),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildNumberButtons(BuildContext context) {
    double buttonSize = 80.0;
    double padding = 20.0;
    List<Offset> buttonPositions = [];
    List<Widget> buttons = [];

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    for (int i = 1; i <= 10; i++) {
      double xPos = screenWidth / 2 - buttonSize / 2; // Center horizontally
      double yPos = screenHeight - (i * (buttonSize + padding));

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

  LinePainter(this.startX, this.startY, this.endX, this.endY);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(Offset(startX, startY), Offset(endX, endY), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

void main() {
  runApp(MaterialApp(
    home: NumbersPage(),
  ));
}
