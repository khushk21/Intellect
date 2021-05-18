import 'package:cloud_firestore/cloud_firestore.dart';
import 'UserAccountMgr.dart';
import 'package:flutter_auth/entity/Challenge.dart';

class ChallengeMgr {
  static final _firestore = FirebaseFirestore.instance;

  static Future<List<String>> readStudents(String classIndex) async {
    List<String> studentList = [];
    await for (var snapshot in _firestore
        .collection("Students")
        .where("class_index", isEqualTo: classIndex)
        .snapshots()) {
      var documents = snapshot.docs;
      if (documents.isNotEmpty) {
        for (var document in documents) {
          if (document['user_name'] == UserAccountMgr.studentDetails.username) {
            continue;
          } else {
            studentList.add(document['user_name']);
          }
        }
        return studentList;
      }
    }
  }

  static pendingChallenges() async {
    List<String> newList = [];
    DateTime currentTime = new DateTime.now();
    UserAccountMgr.studentDetails.challengeReceived.forEach((i) {
      DateTime temp = DateTime.parse(i);
      int timeGone = currentTime.difference(temp).inHours;
      if (timeGone < 24) {
        newList.add(i);
      }
    });

    UserAccountMgr.studentDetails.challengeReceived = newList;
    await _firestore
        .collection("Students")
        .doc(UserAccountMgr.studentDetails.username)
        .update({
      "challenge_received": UserAccountMgr.studentDetails.challengeReceived
    });
  }

  static createChallenge(String world, String stage, String level, int myScore,
      String receiver) async {
    DateTime id = new DateTime.now();
    await _firestore.collection("Challenges").doc(id.toString()).set({
      "id": id.toString(),
      "sender": UserAccountMgr.studentDetails.username,
      "Question": {"world": world, "stage": stage, "level": level},
      "my_score": myScore,
      "receiver": receiver,
      "opponent_score": 0
    });
    var document = await _firestore.collection("Students").doc(receiver).get();
    var data = document.data();
    data['challenge_received'].add(id.toString());

    await _firestore
        .collection("Students")
        .doc(receiver)
        .update({"challenge_received": data['challenge_received']});
  }

  static Future<List<Challenge>> retrievePastSentChallenges() async {
    List<Challenge> sentChallenges = [];
    await for (var snapshot in _firestore
        .collection("Challenges")
        .where("sender", isEqualTo: UserAccountMgr.studentDetails.username)
        .snapshots()) {
      var documents = snapshot.docs;
      if (documents.isNotEmpty) {
        for (var document in documents) {
          Challenge challenge = Challenge();
          challenge.sender = document["sender"];
          challenge.receiver = document["receiver"];
          challenge.challengeId = document["id"];
          challenge.myScore = document["my_score"];
          challenge.receiverScore = document["opponent_score"];
          challenge.question = document["Question"];
          sentChallenges.add(challenge);
        }
      }
      break;
    }
    // print(sentChallenges);
    return sentChallenges;
  }

  static Future<List<Challenge>> retrievePastReceivedChallenges() async {
    List<Challenge> receivedChallenges = [];
    await for (var snapshot in _firestore
        .collection("Challenges")
        .where("receiver", isEqualTo: UserAccountMgr.studentDetails.username)
        .snapshots()) {
      var documents = snapshot.docs;
      if (documents.isNotEmpty) {
        for (var document in documents) {
          //print(document.data());
          Challenge challenge = Challenge();
          challenge.sender = document["sender"];
          challenge.receiver = document["receiver"];
          print(challenge.receiver);
          challenge.challengeId = document["id"];
          challenge.myScore = document["my_score"];
          challenge.receiverScore = document["opponent_score"];
          challenge.question = document["Question"];
          receivedChallenges.add(challenge);
        }
      }
      break;
    }
    // print(receivedChallenges);
    return receivedChallenges;
  }

  static Future<List<Challenge>> retrieveCurrentChallenges() async {
    List<Challenge> pendingChallengesList = [];

    pendingChallenges();

    for (var i in UserAccountMgr.studentDetails.challengeReceived) {
      await for (var snapshot in _firestore
          .collection("Challenges")
          .where("id", isEqualTo: i)
          .snapshots()) {
        var documents = snapshot.docs;
        if (documents.isNotEmpty) {
          for (var document in documents) {
            Challenge challenge = Challenge();
            challenge.question = document["Question"];
            challenge.myScore = document["my_score"];
            challenge.challengeId = document["id"];
            challenge.receiverScore = document["opponent_score"];
            challenge.receiver = document["receiver"];
            challenge.sender = document["sender"];
            pendingChallengesList.add(challenge);
          }
        }
        break;
      }
    }
    print(pendingChallengesList);
    return pendingChallengesList;
  }
}
