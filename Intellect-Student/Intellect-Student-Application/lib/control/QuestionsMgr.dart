import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_auth/entity/Questions.dart';

class QuestionsMgr {
  static final _firestore = FirebaseFirestore.instance;

  static Future<List<Questions>> readQuestions(
      String world, String stage, String level) async {
    List<Questions> q = [];
    await for (var snapshot in _firestore.collection(world).snapshots()) {
      var documents = snapshot.docs;
      if (documents.isNotEmpty) {
        for (var document in documents) {
          int count = 0;
          if (document.id == stage) {
            print("here");
            for (var i in document[level]) {
              i["Options"].shuffle();
              Questions q$count = Questions(
                  answer: i['Answer'],
                  question: i['Question'],
                  options: List<String>.from(i["Options"]));
              q.add(q$count);
              count = count + 1;
            }
            return q.sublist(0, 10);
          }
        }
      }
    }
  }

  static Future<List<Questions>> readAssignmentQuestions(String world) async {
    List<Questions> questions = [];
    await for (var snapshot in _firestore.collection(world).snapshots()) {
      var documents = snapshot.docs;
      int count = 0;
      for (var document in documents) {
        var data = document.data();
        for (var i in data["Easy"]) {
          Questions q$count = Questions(
              answer: i['Answer'],
              question: i['Question'],
              options: List<String>.from(i["Options"]));
          questions.add(q$count);
          count = count + 1;
        }
        for (var i in data["Medium"]) {
          Questions q$count = Questions(
              answer: i['Answer'],
              question: i['Question'],
              options: List<String>.from(i["Options"]));
          questions.add(q$count);
          count = count + 1;
        }
        for (var i in data["Hard"]) {
          Questions q$count = Questions(
              answer: i['Answer'],
              question: i['Question'],
              options: List<String>.from(i["Options"]));
          questions.add(q$count);
          count = count + 1;
        }
      }
      break;
    }
    questions.shuffle();
    return questions.sublist(0, 8);
  }
}
