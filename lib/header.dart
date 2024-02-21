import 'package:flutter/material.dart';
import 'dart:math' as math;

class ScavengerHuntText extends StatelessWidget {
  const ScavengerHuntText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'S',
            style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,fontFamily: 'Calibri', color: const Color.fromRGBO(52, 218, 59, 1), fontSize: 65),
          ),
          Text(
            'C',
            style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,fontFamily: 'Calibri', color: Color.fromRGBO(157, 43, 177, 1), fontSize: 65),
          ),
          Text(
            'A',
            style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,fontFamily: 'Calibri', color: Color.fromRGBO(241, 56, 67, 1), fontSize: 65),
          ),
          Text(
            'V',
            style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,fontFamily: 'Calibri', color: Colors.orange, fontSize: 65),
          ),
          Text(
            'E',
            style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,fontFamily: 'Calibri', color: Colors.red, fontSize: 65),
          ),
          Text(
            'N',
            style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,fontFamily: 'Calibri', color: Color.fromRGBO(238,251,82,100), fontSize: 65),
          ),
          Text(
            'G',
            style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,fontFamily: 'Calibri', color: Colors.purple, fontSize: 65),
          ),
          Text(
            'E',
            style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,fontFamily: 'Calibri', color: Colors.pink, fontSize: 65),
          ),
          Text(
            'R',
            style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,fontFamily: 'Calibri', color: Colors.green, fontSize: 65),
          ),
          const Text(
            '  ',
            style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Calibri', color: Colors.black, fontSize: 65),
          ),
          Text(
            'H',
            style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,fontFamily: 'Calibri', color: Colors.orange, fontSize: 65),
          ),
          Text(
            'U',
            style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,fontFamily: 'Calibri', color: Color.fromRGBO(157, 43, 177, 1), fontSize: 65),
          ),
          Text(
            'N',
            style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,fontFamily: 'Calibri', color: Colors.red, fontSize: 65),
          ),
          Text(
            'T',
            style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,fontFamily: 'Calibri', color: Colors.green, fontSize: 65),
          ),
        ],
      ),
    );
  }
}

class DiagonalWidget1 extends StatelessWidget {
  const DiagonalWidget1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 160, // Adjust top position as needed
      left: 30,
      child: Transform.rotate(
        angle: -math.pi / 4, // Rotate the square diagonally
        child: Container(
          width: 50,
          height: 50,
          color:  Color.fromRGBO(233, 30, 90, 1), // Set color to green
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
    );
  }
}

class DiagonalWidget2 extends StatelessWidget {
  const DiagonalWidget2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 160, // Adjust top position as needed
      right: 30,
      child: Transform.rotate(
        angle: math.pi / 4, // Rotate the square diagonally
        child: Container(
          width: 50,
          height: 50,
          color: Color.fromRGBO(52, 218, 59, 1), // Set color to red
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
    );
  }
}

class DiagonalWidget3 extends StatelessWidget {
  const DiagonalWidget3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40, // Adjust top position as needed
      left: 30,
      child: Transform.rotate(
        angle: -math.pi / 4, // Rotate the square diagonally
        child: Container(
          width: 50,
          height: 50,
          color: Colors.orange, // Set color to blue
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
    );
  }
}

class DiagonalWidget4 extends StatelessWidget {
  const DiagonalWidget4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40, // Adjust top position as needed
      right: 30,
      child: Transform.rotate(
        angle: math.pi / 4, // Rotate the square diagonally
        child: Container(
          width: 50,
          height: 50,
          color: Colors.purple, // Set color to yellow
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
    );
  }
}
