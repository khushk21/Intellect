import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sortedmap/sortedmap.dart';

class LeaderboardMgr {
  static final _firestore = FirebaseFirestore.instance;

  static Future<Map> getLeaderBoard(
      String world, String stage, String level) async {
    Map leaderboard = {};
    if (stage == "All") {
      leaderboard = await LeaderboardMgr.worldLeaderboard(world);
    } else if (level == "All") {
      leaderboard = await LeaderboardMgr.stageLeaderboard(world, stage);
    } else {
      leaderboard = await LeaderboardMgr.levelLeaderboard(world, stage, level);
    }
    return leaderboard;
  }

  static Future<Map> levelLeaderboard(
      String world, String stage, String level) async {
    Map<dynamic, dynamic> final_scores = Map<dynamic, dynamic>();
    await for (var snapshot in _firestore.collection("Students").snapshots()) {
      var documents = snapshot.docs;
      for (var document in documents) {
        await for (var snapshot in _firestore
            .collection('Students')
            .doc(document.id)
            .collection(world)
            .snapshots()) {
          var l = snapshot.docs;
          if (l.isNotEmpty) {
            for (var doc in l) {
              if (doc.id == stage) {
                if (doc['Levels'].containsKey(level)) {
                  final_scores[document.id] = doc["Levels"][level]["score"];
                }
              }
            }
          } else {
            final_scores[document.id] = 0;
          }
          break;
        }
      }
      break;
    }
    return sortScores(final_scores);
  }

  static Future<Map> stageLeaderboard(String world, String stage) async {
    Map<dynamic, dynamic> final_scores = Map<dynamic, dynamic>();
    await for (var snapshot in _firestore.collection("Students").snapshots()) {
      var documents = snapshot.docs;
      for (var document in documents) {
        await for (var snapshot in _firestore
            .collection('Students')
            .doc(document.id)
            .collection(world)
            .snapshots()) {
          var l = snapshot.docs;
          if (l.isNotEmpty) {
            for (var doc in l) {
              if (doc.id == stage) {
                final_scores[document.id] = doc["total_score"];
              }
            }
          } else {
            final_scores[document.id] = 0;
          }
          break;
        }
      }
      break;
    }
    return sortScores(final_scores);
  }

  static Future<Map> worldLeaderboard(String world) async {
    Map<dynamic, dynamic> final_scores = Map<dynamic, dynamic>();
    await for (var snapshot in _firestore.collection("Students").snapshots()) {
      var documents = snapshot.docs;
      for (var document in documents) {
        int total = 0;
        await for (var snapshot in _firestore
            .collection('Students')
            .doc(document.id)
            .collection(world)
            .snapshots()) {
          var l = snapshot.docs;

          if (l.isNotEmpty) {
            for (var doc in l) {
              total = total + doc["total_score"];
              print(total);
            }
            final_scores[document.id] = total;
          } else {
            final_scores[document.id] = 0;
          }
          break;
        }
      }
      break;
    }
    return sortScores(final_scores);
  }

  static sortScores(Map<dynamic, dynamic> k) {
    var scores = SortedMap(Ordering.byValue());
    for (String username in k.keys) {
      scores.addAll({username: k[username]});
    }
    print(scores);
    return scores;
  }
}
