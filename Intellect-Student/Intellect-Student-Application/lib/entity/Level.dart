import 'package:flutter/material.dart';

class Level {
  String _levelNum;
  int _attempts;
  int _correctQuestions;
  int _score;
  int _timeTaken;
  Level({String levelNum, int correctQuestions, int score, int timeTaken})
      : _levelNum = levelNum,
        _timeTaken = timeTaken,
        _score = score,
        _correctQuestions = correctQuestions;
  String get levelNum => _levelNum;
  int get attempts => _attempts;
  int get correctQuestions => _correctQuestions;
  int get score => _score;
  int get timeTaken => _timeTaken;
  set levelNum(String levelNum) {
    _levelNum = levelNum;
  }

  set attempts(int attempts) {
    _attempts = attempts;
  }

  set correctQuestions(int correctQuestions) {
    _correctQuestions = correctQuestions;
  }

  set score(int score) {
    _score = score;
  }

  set timeTaken(int timeTaken) {
    _timeTaken = timeTaken;
  }

  void printDetails() {
    print("Level Number" + _levelNum);
    print("Score" + _score.toString());
    print("Attempts" + _attempts.toString());
    print("Correct Questions" + _correctQuestions.toString());
    print("TimeTaken" + _timeTaken.toString());
  }
}
