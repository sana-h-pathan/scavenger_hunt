import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'dart:io';
import 'dart:convert';

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
    _saveScoresToFile();
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

    _saveScoresToFile();
    notifyListeners(); // Notify listeners about changes
  }

  Future<String> _getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return path.join(directory.path, 'scores.json');
  }

  Future<void> _saveScoresToFile() async {
    final filePath = await _getFilePath();
    final file = File(filePath);

    var scoresData = {};
    scoresData["currentScore"] = _currentScore;
    Map<String, int> stringKeyStageScores =
        StageScores.map((key, value) => MapEntry(key.toString(), value));
    scoresData["StageScores"] = stringKeyStageScores;

    // Convert the data structure to JSON
    String jsonString = jsonEncode(scoresData);
    print(jsonString);

    //   'currentScore': _currentScore,
    //   'StageScores': StageScores,
    // };

    if (!await file.exists()) {
      await file.create(recursive: true);
      print('File created at path: $filePath'); // Log the full path
    }

    await file.writeAsString(jsonString);
    print('Scores saved to $filePath');
  }

  Future<void> loadInitialScores() async {
    try {
      final initialScores = await _loadInitialScores();
      print("initialScores");
      print(initialScores);
      _currentScore = initialScores['currentScore'];
      StageScores = Map<int, int>.from(initialScores['StageScores']);
      notifyListeners();
    } catch (e) {
      print('Error loading initial scores: $e');
    }
  }

  Future<Map<String, dynamic>> _loadInitialScores() async {
    final data = await rootBundle.loadString('assets/initial_scores.json');
    return json.decode(data);
  }
}
