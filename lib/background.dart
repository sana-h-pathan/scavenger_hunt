import 'package:flutter/material.dart';

class BackgroundGradient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.4, 1.0],
          colors: [
            Color.fromRGBO(252, 170, 214, 1), // Light pink color
            Color.fromRGBO(114, 229, 91, 1), // Light blue color
          ],
        ),
      ),
    );
  }
}
