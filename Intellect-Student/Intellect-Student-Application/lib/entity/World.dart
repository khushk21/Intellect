import 'package:flutter/material.dart';
import 'package:flutter_auth/entity/Stage.dart';

class World {
  String _name;
  List<Stage> _stage = List<Stage>();
  World({String name}) : _name = name;
  String get name => _name;
  List<Stage> get stage => _stage;
  set name(String name) {
    _name = name;
  }

  set stage(List<Stage> stage) {
    _stage = stage;
  }

  void printDetails() {
    print("Name" + _name);
    for (Stage s in _stage) {
      s.printDetails();
    }
  }
}
