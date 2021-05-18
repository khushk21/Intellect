import 'package:flutter/material.dart';
import 'package:flutter_auth/entity/Level.dart';

class Stage {
  String _stageNum;
  int _totalScore;
  List<Level> _level = List<Level>();
  Stage({String stageNum}) : _stageNum = stageNum;
  String get stageNum => _stageNum;
  List<Level> get level => _level;
  int get totalScore => _totalScore;
  set stageNum(String stageNum) {
    _stageNum = stageNum;
  }

  set level(List<Level> level) {
    _level = level;
  }

  set totalScore(int totalScore) {
    _totalScore = totalScore;
  }

  void printDetails() {
    print("Stage Number" + _stageNum);
    print("Total Score" + _totalScore.toString());
    for (Level l in _level) {
      l.printDetails();
    }
  }
}
