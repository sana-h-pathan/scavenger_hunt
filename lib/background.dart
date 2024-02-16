import 'package:flutter/material.dart';

class BackgroundGradient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
