import 'package:flutter/material.dart';

class AppScore with ChangeNotifier {
  static final AppScore _singleton = AppScore._internal();
  factory AppScore() => _singleton;

  AppScore._internal();

  int _currentScore = 0;

  int get currentScore => _currentScore;

  set currentScore(int score) {
    _currentScore = score;
    notifyListeners(); // Notify listeners about changes
  }
}
