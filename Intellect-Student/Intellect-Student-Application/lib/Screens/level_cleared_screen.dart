import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/battle_screen.dart';
import 'package:flutter_auth/Screens/home_screen.dart';
import 'package:flutter_auth/Screens/select_level.dart';
import 'package:flutter_auth/components/short_rectangle_button.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/control/BattleMgr.dart';
import 'package:flutter_auth/control/UserAccountMgr.dart';
import 'package:share/share.dart';

class LevelCleared extends StatefulWidget {
  static String id = "level_cleared_screen";
  @override
  _LevelClearedState createState() => _LevelClearedState();
}

class _LevelClearedState extends State<LevelCleared> {
  String currentWorld;
  String currentStage;
  String currentLevel;
  int health;
  int score;
  int correctQuestions;
  int totalQuestions;
  int time;
  bool status;
  String selectedCharacter;
  @override
  Widget build(BuildContext context) {
    selectedCharacter = UserAccountMgr.studentDetails.character;
    Map temp = ModalRoute.of(context).settings.arguments;
    currentWorld = temp['world'];
    currentStage = temp['stage'];
    currentLevel = temp['level'];
    health = temp['health'];
    score = temp['score'];
    correctQuestions = temp['numCorrectQuestions'];
    totalQuestions = temp['totalQuestions'];
    time = temp['time'];
    status = temp['status'];
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        backgroundColor: kPrimaryColor,
        title: Center(
          child: Text(
            'RESULTS',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                letterSpacing: 2.0,
                fontSize: 23.0),
          ),
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              "assets/images/main_top.png",
              width: size.width * 0.3,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              "assets/images/main_bottom.png",
              width: size.width * 0.2,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  status ? "LEVEL CLEARED" : "LEVEL FAILED",
                  style: TextStyle(
                      fontSize: 24,
                      color: status ? Colors.green : Colors.red,
                      fontWeight: FontWeight.w700),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Score: $score",
                            style: TextStyle(
                                fontSize: 21, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Number of correct questions: $correctQuestions / $totalQuestions",
                            style: TextStyle(
                                fontSize: 21, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Time taken: $time seconds",
                            style: TextStyle(
                                fontSize: 21, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Remaining health: $health / 100",
                            style: TextStyle(
                                fontSize: 21, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      height: MediaQuery.of(context).size.height * 0.6,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(
                              'assets/images/characters/$selectedCharacter.png'),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RectangleButton("Share", () {
                        Share.share('Hey! I just scored $score in $currentWorld $currentStage $currentLevel.');
                      }),
                      RectangleButton("Retry", () {
                        Navigator.popUntil(
                            context, ModalRoute.withName(SelectLevel.id));
                        Navigator.pushNamed(context, BattleScreen.id,
                            arguments: {
                              "world": currentWorld,
                              "stage": currentStage,
                              "level": currentLevel,
                              "mode": "Solo Campaign",
                              "extra": {}
                            });
                      }),
                      status
                          ? RectangleButton("Next", () {
                              List<String> next = BattleMgr.checkNextLevel(
                                  currentWorld, currentStage, currentLevel);
                              Navigator.popUntil(
                                  context, ModalRoute.withName(SelectLevel.id));
                              Navigator.pushNamed(context, BattleScreen.id,
                                  arguments: {
                                    "world": next[0],
                                    "stage": next[1],
                                    "level": next[2],
                                    "mode": "Solo Campaign",
                                    "extra": {}
                                  });
                            })
                          : SizedBox(),
                      RectangleButton("Exit", () {
                        Navigator.popUntil(
                            context, ModalRoute.withName(HomeScreen.id));
                      })
                    ])
              ],
            ),
          ),
        ],
      ),
    );
  }
}
