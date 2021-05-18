import 'package:flutter/material.dart';

class Questions {
  String _question;
  String _answer;
  List<String> _options = [];
  Questions({String question, String answer, List<String> options})
      : _question = question,
        _answer = answer,
        _options = options;
  String get question => _question;
  String get answer => _answer;
  List<String> get options => _options;
  set question(String question) {
    _question = question;
  }

  set answer(String answer) {
    _answer = answer;
  }

  set options(List<String> options) {
    _options = options;
  }

  void printDetails() {
    print("Question" + _question);
    print("Answer" + _answer);
  }
}
