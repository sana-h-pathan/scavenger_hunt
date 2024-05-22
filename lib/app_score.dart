import 'package:flutter/material.dart';

class AppScore with ChangeNotifier {
  static final AppScore _singleton = AppScore._internal();
  factory AppScore() => _singleton;

  AppScore._internal();

  int _currentScore = 0;
  Map<int, int> StageScores = {
    1: 0,
    2: 0,
    3: 0,
    4: 0,
    5: 0,
    6: 0,
    7: 0,
    8: 0,
    9: 0,
    10: 0
  };

  int get currentScore => _currentScore;

  int? getStageScore(int stage) {
    return StageScores[stage];
  }

  void resetStageScore() {
    StageScores.forEach((key, value) {
      StageScores[key] = 0;
    });
    _currentScore = 0;
  }

  void setStageScore(int stage, int score) {
    StageScores[stage] = score;

    int totalScore = 0;

    for (int score in StageScores.values) {
      totalScore += score;
    }
    _currentScore = totalScore;
    print('Total score: $totalScore');

    StageScores.forEach((key, value) {
      print('Stage $key: Score $value');
    });

    notifyListeners(); // Notify listeners about changes
  }
}
