import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_auth/control/UserAccountMgr.dart';
import 'package:flutter_auth/entity/Level.dart';
import 'package:audioplayers/audio_cache.dart';

class BattleMgr {
  static final _firestore = FirebaseFirestore.instance;
  static AudioCache audio = AudioCache();
  static AudioPlayer player = AudioPlayer();
  static playMusic() async {
    player = await audio.loop("audios/battle_music.mp3", volume: 50.0);
  }

  static stopMusic() {
    player.stop();
  }

  static List<String> checkNextLevel(
      String currentWorld, String currentStage, String currentLevel) {
    List<String> campaign = [];
    String nextLevel = "";
    String nextStage = "";
    String nextWorld = "";
    if (currentLevel == "Easy") {
      nextLevel = "Medium";
      nextStage = currentStage;
      nextWorld = currentWorld;
    } else if (currentLevel == "Medium") {
      nextLevel = "Hard";
      nextStage = currentStage;
      nextWorld = currentWorld;
    } else {
      nextLevel = "Easy";
      if (currentStage == "Stage 1") {
        nextStage = "Stage 2";
        nextWorld = currentWorld;
      } else if (currentStage == "Stage 2") {
        nextStage = "Stage 3";
        nextWorld = currentWorld;
      } else {
        nextStage = "Stage 1";
        if (currentWorld == UserAccountMgr.worlds[0]) {
          nextWorld = UserAccountMgr.worlds[1];
        } else if (currentWorld == UserAccountMgr.worlds[1]) {
          nextWorld = UserAccountMgr.worlds[2];
        } else {
          nextWorld = null;
          nextStage = null;
          nextLevel = null;
        }
      }
    }
    campaign.add(nextWorld);
    campaign.add(nextStage);
    campaign.add(nextLevel);
    return campaign;
  }

  static compileResultSoloCampaign(String currentWorld, String currentStage,
      String currentLevel, int time, int score, int correctQuestions) async {
    Level currentLevelDetails = Level(
        levelNum: currentLevel,
        score: score,
        timeTaken: time,
        correctQuestions: correctQuestions);
    List<String> campaign =
        checkNextLevel(currentWorld, currentStage, currentLevel);
    String nextWorld = campaign[0];
    String nextStage = campaign[1];
    String nextLevel = campaign[2];
    if (nextWorld != null &&
        nextStage != null &&
        nextLevel != null &&
        correctQuestions >= 5) {
      print("here");
        UserAccountMgr.studentDetails.experience += 1;
      UserAccountMgr.updateStudentDetails(
          UserAccountMgr.studentDetails.username,
          "experience",
          UserAccountMgr.studentDetails.experience);
      var nextData = await _firestore
          .collection("Students")
          .doc(UserAccountMgr.studentDetails.username)
          .collection(nextWorld)
          .doc(nextStage)
          .get();
      if (nextData.exists) {

        Map<dynamic, dynamic> temp = nextData.data();
        if (!temp['Levels'].containsKey(nextLevel)) {
          temp['Levels'][nextLevel] = {
            "score": 0,
            "time_taken": 0,
            "correct_questions": 0,
            "attempts": 0
          };
          await _firestore
              .collection("Students")
              .doc(UserAccountMgr.studentDetails.username)
              .collection(nextWorld)
              .doc(nextStage)
              .update({
            "Levels": temp["Levels"],
            "total_score": temp["total_score"]
          });
        }
      } else {
        await _firestore
            .collection("Students")
            .doc(UserAccountMgr.studentDetails.username)
            .collection(nextWorld)
            .doc(nextStage)
            .set({
          "Levels": {
            nextLevel: {
              "score": 0,
              "attempts": 0,
              "time_taken": 0,
              "correct_questions": 0
            },
          },
          "total_score": 0
        });
      }
    }
    updateScore(currentWorld, currentStage, currentLevel, currentLevelDetails);
  }

  static updateScore(String currentWorld, String currentStage,
      String currentLevel, Level level) async {
    var document = await _firestore
        .collection("Students")
        .doc(UserAccountMgr.studentDetails.username)
        .collection(currentWorld)
        .doc(currentStage)
        .get();
    if (document.exists) {
      Map<dynamic, dynamic> oldData = document.data();
      if (oldData["Levels"][currentLevel]["attempts"] == 0) {
        oldData["Levels"][currentLevel]["attempts"] = 1;
        oldData["Levels"][currentLevel]["score"] = level.score;
        oldData["Levels"][currentLevel]["correct_questions"] =
            level.correctQuestions;
        oldData["Levels"][currentLevel]["time_taken"] = level.timeTaken;
        oldData["total_score"] = oldData["total_score"] + level.score;
      } else {
        if (oldData["Levels"][currentLevel]["correct_questions"] <
            level.correctQuestions) {
          oldData['Levels'][currentLevel]["correct_questions"] =
              level.correctQuestions;
          oldData["Levels"][currentLevel]["attempts"] =
              oldData["Levels"][currentLevel]["attempts"] + 1;
          oldData['Levels'][currentLevel]["time_taken"] = level.timeTaken;
          oldData["total_score"] = oldData["total_score"] +
              level.score -
              oldData["Levels"][currentLevel]["score"];
          oldData["Levels"][currentLevel]["score"] = level.score;
        } else {
          oldData["Levels"][currentLevel]["attempts"] =
              oldData["Levels"][currentLevel]["attempts"] + 1;
        }
      }
      await _firestore
          .collection("Students")
          .doc(UserAccountMgr.studentDetails.username)
          .collection(currentWorld)
          .doc(currentStage)
          .update({
        "Levels": oldData["Levels"],
        "total_score": oldData["total_score"]
      });
    }
    await UserAccountMgr.readStudentDetails(
        UserAccountMgr.studentDetails.username);
  }

  static updateChallengeScore(String challengeId, int score) async {
    String username = UserAccountMgr.studentDetails.username;
    var doc = await _firestore.collection("Challenges").doc(challengeId).get();
    if (doc.exists) {
      Map temp = doc.data();
      if (temp["receiver"] == username) {
        temp["opponent_score"] = score;
      }
      await _firestore.collection("Challenges").doc(challengeId).update({
        "Question": temp["Question"],
        "id": temp["id"],
        "my_score": temp["my_score"],
        "opponent_score": temp["opponent_score"],
        "receiver": temp["receiver"],
        "sender": temp["sender"]
      });

      UserAccountMgr.studentDetails.challengeReceived.remove(challengeId);
      UserAccountMgr.updateStudentDetails(
          UserAccountMgr.studentDetails.username,
          "challenge_received",
          UserAccountMgr.studentDetails.challengeReceived);
    }
  }
}
