import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/battle_screen.dart';
import 'package:flutter_auth/components/short_rectangle_button.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/control/QuestionsMgr.dart';
import 'package:flutter_auth/control/UserAccountMgr.dart';
import 'package:flutter_auth/entity/Questions.dart';
import 'package:flutter_auth/entity/Student.dart';

class SelectLevel extends StatefulWidget {
  static String id = "level_screen";
  _SelectLevelState createState() => _SelectLevelState();
}

class _SelectLevelState extends State<SelectLevel> {
  Student currentStudent;
  String selectedWorld;
  String selectedStage;
  String selectedLevel;
  List<String> clearedLevels;

  @override
  void initState() {
    super.initState();
    selectedLevel = 'Easy';
    currentStudent = UserAccountMgr.studentDetails;
  }

  @override
  Widget build(BuildContext context) {
    Map temp = ModalRoute.of(context).settings.arguments;
    selectedWorld = temp['world'];
    selectedStage = temp['stage'];
    clearedLevels = temp['levels'];
    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        backgroundColor: kPrimaryColor,
        title: Center(
          child: Text(
            'SOLO CAMPAIGN MODE',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                letterSpacing: 2.0,
                fontSize: 23.0),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildLevelCard("Easy"),
              _buildLevelCard("Medium"),
              _buildLevelCard("Hard"),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: RectangleButton(
                'PLAY',
                clearedLevels.contains(selectedLevel)
                    ? () {
                        Navigator.pushNamed(context, BattleScreen.id,
                            arguments: {
                              "world": selectedWorld,
                              "stage": selectedStage,
                              "level": selectedLevel,
                              "mode": "Solo Campaign",
                              "extra": {}
                            });
                      }
                    : null),
          ),
        ],
      ),
    );
  }

  Widget _buildLevelCard(String level) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedLevel = level;
        });
      },
      child: Column(
        children: [
          SizedBox(height: 10),
          Container(
            width: level == selectedLevel
                ? MediaQuery.of(context).size.width * (0.275)
                : MediaQuery.of(context).size.width * (0.25),
            height: level == selectedLevel
                ? MediaQuery.of(context).size.height * (0.6)
                : MediaQuery.of(context).size.height * (0.575),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 2.0,
                  spreadRadius: 0.0,
                )
              ],
              border: level == selectedLevel
                  ? Border.all(color: Colors.black, width: 5)
                  : null,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: clearedLevels.contains(level)
                    ? AssetImage(
                        'assets/images/levels/$selectedWorld/$selectedStage/$level.png')
                    : AssetImage('assets/images/lock.png'),
              ),
            ),
          ),
          Text(
            level,
            style: TextStyle(
                fontFamily: 'Regular',
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
        ],
      ),
    );
  }
}
