import 'package:flutter/material.dart';

class BackgroundGradient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft, // Change the begin alignment
          end: Alignment.bottomRight, // Change the end alignment
          stops: [0.3, 1.0],
          colors: [
            Color.fromRGBO(252, 170, 214, 1), // Light pink color
            Colors.lightBlue, // Light blue color
          ],
        ),
      ),
    );
  }
}
