import 'package:flutter/material.dart';
import 'package:flutter_auth/entity/World.dart';
import 'package:flutter_auth/entity/Stage.dart';
import 'package:flutter_auth/entity/Level.dart';

class Student {
  String _username;
  String _email;
  String _classIndex;
  String _fullName;
  String _password;
  String _character;
  List<World> _world = List<World>();
  int _experience;
  List<dynamic> _challengeReceived;
  List<String> _assignmentCode;
  Student(
      {String username,
      String email,
      String password,
      String fullName,
      String classIndex,
      int experience,
      List<dynamic> challengeReceived,
      List<String> assignmentCode})
      : _username = username,
        _email = email,
        _password = password,
        _fullName = fullName,
        _classIndex = classIndex,
        _experience = experience,
        _challengeReceived = challengeReceived,
        _assignmentCode = assignmentCode;
  String get username => _username;
  String get email => _email;
  String get classIndex => _classIndex;
  String get character => _character;
  String get fullName => _fullName;
  List<World> get world => _world;
  List<dynamic> get challengeReceived => _challengeReceived;
  int get experience => _experience;
  List<String> get assignmentCode => _assignmentCode;
  set experience(int experience) {
    _experience = experience;
  }

  set username(String username) {
    _username = username;
  }

  set email(String email) {
    _email = email;
  }

  set fullName(String fullName) {
    _fullName = fullName;
  }

  set character(String character) {
    _character = character;
  }

  set classIndex(String classIndex) {
    _classIndex = classIndex;
  }

  set world(List<World> world) {
    _world = world;
  }

  set challengeReceived(List<dynamic> challengeReceived) {
    _challengeReceived = challengeReceived;
  }

  set assignmentCode(List<String> assignmentCode) {
    _assignmentCode = assignmentCode;
  }

  void printDetails() {
    print("Username" + _username);
    print("Class Index" + _classIndex);
    print("Name" + _fullName);
    print("Email" + _email);
    print("Character" + _character);
    print(_challengeReceived);
    for (World w in _world) {
      w.printDetails();
    }
  }
}
