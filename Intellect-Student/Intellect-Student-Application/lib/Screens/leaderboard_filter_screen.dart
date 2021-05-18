import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/leaderboard_screen.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/control/UserAccountMgr.dart';

import '../constants.dart';

class LeaderBoardFilterScreen extends StatefulWidget {
  static const String id = 'leaderboard_filter_screen';

  @override
  _LeaderBoardFilterScreenState createState() =>
      _LeaderBoardFilterScreenState();
}

class _LeaderBoardFilterScreenState extends State<LeaderBoardFilterScreen> {
  Map clearedStages = {};
  String _selectedWorld;
  String _selectedStage;
  String _selectedLevel;

  @override
  void initState() {
    super.initState();
    getDetails();
  }

  void getDetails() async {
    List<String> levels = [];
    Map stageMap = {};
    for (var world in UserAccountMgr.studentDetails.world) {
      stageMap = {};
      for (var stage in world.stage) {
        levels = [];
        for (var level in stage.level) {
          levels.add(level.levelNum);
        }
        levels.add("All");
        stageMap[stage.stageNum] = levels;
      }
      stageMap['All'] = ["All"];
      clearedStages[world.name] = stageMap;
    }
    setState(() {
      _selectedWorld = clearedStages.keys.toList()[0];
      _selectedStage = clearedStages[_selectedWorld].keys.toList()[0];
      _selectedLevel = clearedStages[_selectedWorld][_selectedStage][0];
    });
  }

  List<DropdownMenuItem<String>> buildDropdownMenuItems(List items) {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String item in items) {
      dropdownItems.add(
        DropdownMenuItem(
          value: item,
          child: Text(item),
        ),
      );
    }
    return dropdownItems;
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          elevation: 5.0,
          backgroundColor: kPrimaryColor,
          title: Center(
            child: Text(
              'LEADERBOARD FILTER',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2.0,
                  fontSize: 23.0),
            ),
          ),
        ),
        body: Stack(alignment: Alignment.center, children: <Widget>[
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
          new Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Select a World",
                            style: kMediumText,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          DropdownButton(
                            value: _selectedWorld,
                            items: buildDropdownMenuItems(
                                clearedStages.keys.toList()),
                            onChanged: (String value) {
                              setState(() {
                                _selectedWorld = value;
                                _selectedStage = clearedStages[_selectedWorld]
                                    .keys
                                    .toList()[0];
                                _selectedLevel = clearedStages[_selectedWorld]
                                    [_selectedStage][0];
                              });
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Select a Stage",
                            style: kMediumText,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          DropdownButton(
                            value: _selectedStage,
                            items: buildDropdownMenuItems(
                                clearedStages[_selectedWorld].keys.toList()),
                            onChanged: (String value) {
                              setState(() {
                                _selectedStage = value;
                                _selectedLevel = clearedStages[_selectedWorld]
                                    [_selectedStage][0];
                              });
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Select a Level",
                            style: kMediumText,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          DropdownButton(
                            value: _selectedLevel,
                            items: buildDropdownMenuItems(
                                clearedStages[_selectedWorld][_selectedStage]),
                            onChanged: (String value) {
                              setState(() {
                                _selectedLevel = value;
                              });
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      RoundedButton(
                        text: "VIEW",
                        press: () async {
                          Navigator.pushNamed(context, Leaderboard.id,
                              arguments: {
                                "world": _selectedWorld,
                                "stage": _selectedStage,
                                "level": _selectedLevel,
                              });
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ]));
  }
}
