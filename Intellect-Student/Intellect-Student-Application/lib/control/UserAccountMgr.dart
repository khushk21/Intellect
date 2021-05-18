import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_auth/entity/Student.dart';
import 'package:flutter_auth/entity/Level.dart';
import 'package:flutter_auth/entity/World.dart';
import 'package:flutter_auth/entity/Stage.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class UserAccountMgr {
  static final List<String> worlds = ["World 1", "World 2", "World 3"];
  static final _firestore = FirebaseFirestore.instance;
  static Student studentDetails = Student();
  static AudioCache audio = AudioCache();
  static AudioPlayer player = AudioPlayer();
  static playBackgroundMusic() async {
    player = await audio.loop("audios/background_music.mp3", volume: 50.0,);
  }

  static bool bgmBool = true;
  static stopBackgroundMusic() {
    player.stop();
  }

  static readStudentDetails(String username) async {
    await for (var snapshot in _firestore.collection('Students').snapshots()) {
      var documents = snapshot.docs;
      if (documents.isNotEmpty) {
        for (var document in documents) {
          if (document.id == username) {
            studentDetails.username = username;
            studentDetails.email = document['email'];
            studentDetails.classIndex = document['class_index'];
            studentDetails.character = document['character'];
            studentDetails.experience = document['experience'];
            studentDetails.fullName = document['fullname'];
            studentDetails.challengeReceived = document["challenge_received"];
            studentDetails.assignmentCode =
                List<String>.from(document["assignment_code"]);
            for (int index = 0; index < 3; index++) {
              print("i am in for, index == $index");
              World newWorld = World();
              await for (var snapshot in _firestore
                  .collection("Students")
                  .doc(document.id)
                  .collection(worlds[index])
                  .snapshots()) {
                var d = snapshot.docs;
                if (d.isNotEmpty) {
                  print("world $index");
                  newWorld.name = worlds[index];
                  for (var doc in d) {
                    Stage newStage = Stage();
                    newStage.stageNum = doc.id;
                    newStage.totalScore = doc['total_score'];
                    print(doc['Levels']);
                    for (var p in doc["Levels"].keys) {
                      Level newLevel = Level();
                      newLevel.levelNum = p;
                      newLevel.correctQuestions =
                          doc["Levels"][p]["correct_questions"];
                      newLevel.score = doc["Levels"][p]["score"];
                      newLevel.timeTaken = doc["Levels"][p]["time_taken"];
                      newLevel.attempts = doc["Levels"][p]["attempts"];
                      newStage.level.add(newLevel);
                    }
                    newWorld.stage.add(newStage);
                  }
                  studentDetails.world.add(newWorld);
                  //print("Added ${newWorld.name}");
                }
                //print("reached1");
                break;

              }
              // studentDetails.world.add(newWorld);
              // print("Added ${newWorld.name}");
              //print("reached2");
            }
            //print("hlvfdvfd00");
          }
        }
      }
      break;
    }
  }

  static updateUserPassword(String email, String newPassword) async {
    String username;
    await for (var snapshot in _firestore
        .collection('Students')
        .where('email', isEqualTo: email)
        .snapshots()) {
      var docs = snapshot.docs;
      if (docs.isNotEmpty) {
        for (var Doc in docs) {
          if (Doc['email'] == email) {
            username = Doc.id;
            print("Here");
            print(username);
            print(newPassword);
            await _firestore
                .collection('Students')
                .doc(username)
                .update({'password': newPassword});
          }
        }
      } else {
        print(
            "No user has this email id registered!"); // figure out how to fix this,
      }
      break;
    }

    print("change success");
    //await readUserDetails(username);
  }

  static updateFirstPassword(String username, String newPassword) async {
    await for (var snapshot in _firestore
        .collection('Students')
        .where('user_name', isEqualTo: username)
        .snapshots()) {
      var docs = snapshot.docs;
      if (docs.isNotEmpty) {
        for (var Doc in docs) {
          if (Doc['user_name'] == username) {
            username = Doc.id;
            print("Here");
            print(username);
            print(newPassword);
            await _firestore
                .collection('Students')
                .doc(username)
                .update({'password': newPassword});
            print("change success");
          }
        }
      } else {
        print("No user is registered!");
        break; // figure out how to fix this,
      }
    }

    //await readUserDetails(username);
  }

  static updateStudentDetails(username, parameter, newValue) async {
    await _firestore
        .collection("Students")
        .doc(username)
        .update({parameter: newValue});
    await readStudentDetails(username);
    return;
  }
}
