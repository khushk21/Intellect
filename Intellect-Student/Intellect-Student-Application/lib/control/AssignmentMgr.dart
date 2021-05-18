import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_auth/control/UserAccountMgr.dart';
import 'package:flutter_auth/entity/Assignment.dart';

class AssignmentMgr {
  static final _firestore = FirebaseFirestore.instance;

  static pendingAssignments() async {
    List<String> newList = [];
    DateTime currentTime = new DateTime.now();
    UserAccountMgr.studentDetails.assignmentCode.forEach((i) {
      DateTime d = DateTime.parse(i);
      if (currentTime.isBefore(d)) {
        newList.add(i);
      }
    });
    print(newList);
    UserAccountMgr.studentDetails.assignmentCode = newList;
    await _firestore
        .collection("Students")
        .doc(UserAccountMgr.studentDetails.username)
        .update(
            {"assignment_code": UserAccountMgr.studentDetails.assignmentCode});
  }

  static Future<List<Assignment>> readAssignment() async {
    List<Assignment> assignmentList = [];
    pendingAssignments();
    for (var i in UserAccountMgr.studentDetails.assignmentCode) {
      await for (var snapshot in _firestore
          .collection("Assignments")
          .where("dueDate", isEqualTo: i)
          .snapshots()) {
        var documents = snapshot.docs;
        if (documents.isNotEmpty) {
          for (var document in documents) {
            Assignment assignment = Assignment();
            String index = document["class_index"];
            List<dynamic> cleared = document["cleared_students"];
            List<String> studentsAttempted =
                List<String>.from(document["attempted_students"]);
            String world = document["world"];
            String title = document["title"];
            String dueDate = document["dueDate"];
            String code = document["assignment_code"];
            assignment = Assignment(
                assignmentCode: code,
                cleared: cleared,
                index: index,
                studentsAttempted: studentsAttempted,
                dueDate: dueDate,
                title: title,
                world: world);
            assignmentList.add(assignment);
          }
        }
        break;
      }
    }
    return assignmentList;
  }

  static addClearedStudent(int score, String code) async {
    List<Assignment> assignmentList = await readAssignment();
    for (var assignment in assignmentList) {
      if (code == assignment.dueDate) {
        if (score > 40) {
          assignment.studentsAttempted
              .add(UserAccountMgr.studentDetails.username);
          assignment.cleared.add({
            "score": score,
            "student": UserAccountMgr.studentDetails.username
          });
          await _firestore.collection("Assignments").doc(code).update({
            "attempted_students": assignment.studentsAttempted,
            "cleared_students": assignment.cleared
          });
        } else {
          assignment.studentsAttempted
              .add(UserAccountMgr.studentDetails.username);
          await _firestore
              .collection("Assignments")
              .doc(code)
              .update({"attempted_students": assignment.studentsAttempted});
        }
        UserAccountMgr.studentDetails.assignmentCode.remove(code);
        UserAccountMgr.updateStudentDetails(
            UserAccountMgr.studentDetails.username,
            "assignment_code",
            UserAccountMgr.studentDetails.assignmentCode);
        break;
      }
    }
  }

  static Future<List<Assignment>> retrievePastAssignments() async {
    List<Assignment> pastAssignment = [];

    await for (var snapshot
        in _firestore.collection("Assignments").snapshots()) {
      var documents = snapshot.docs;
      print(documents.length);
      if (documents.isNotEmpty) {
        for (var document in documents) {
          var data = document.data();
          print(document.id);
          if (data["attempted_students"]
              .contains(UserAccountMgr.studentDetails.username)) {
            print("contains");
            List<dynamic> cleared = [];
            Assignment assignment = Assignment();
            for (var i in document["cleared_students"]) {
              if (i['student'] == UserAccountMgr.studentDetails.username) {
                cleared.add(i);
              }
            }
            String index = document["class_index"];
            List<String> studentsAttempted =
                List<String>.from(document["attempted_students"]);
            String world = document["world"];
            String title = document["title"];
            String dueDate = document["dueDate"];
            String aCode = document["assignment_code"];
            assignment = Assignment(
                cleared: cleared,
                index: index,
                studentsAttempted: studentsAttempted,
                dueDate: dueDate,
                title: title,
                world: world,
                assignmentCode: aCode);
            pastAssignment.add(assignment);
          }
        }
      }
      break;
    }
    print(pastAssignment);
    return pastAssignment;
  }
}
