import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/select_stage.dart';
import 'package:flutter_auth/components/user_detail_card.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/components/short_rectangle_button.dart';
import 'package:flutter_auth/control/UserAccountMgr.dart';
import 'package:flutter_auth/entity/Level.dart';
import 'package:flutter_auth/entity/Stage.dart';
import 'package:flutter_auth/entity/Student.dart';
import 'package:flutter_auth/entity/World.dart';

class WorldsScreen extends StatefulWidget {
  @override
  static String id = "worlds_screen_page";
  _WorldsScreenState createState() => _WorldsScreenState();
}

class _WorldsScreenState extends State<WorldsScreen> {
  Student currentStudent;

  String selectedWorld;
  Map descriptionMap = {
    'World 1': "Addition and Subtraction",
    'World 2': "Multiplication and Division",
    'World 3': "BODMAS",
  };

  Map clearedDetails = {};

  @override
  void initState() {
    super.initState();
    selectedWorld = 'World 1';

    currentStudent = UserAccountMgr.studentDetails;
    getDetails();
    print(clearedDetails.keys.toList());
  }

  void getDetails() {
    List<String> levels = [];
    Map stageMap = {};
    print(UserAccountMgr.studentDetails.world);
    for (World world in UserAccountMgr.studentDetails.world) {
      stageMap = {};
      for (Stage stage in world.stage) {
        levels = [];
        for (Level level in stage.level) {
          levels.add(level.levelNum);
        }
        stageMap[stage.stageNum] = levels;
      }
      clearedDetails[world.name] = stageMap;
    }
  }

  @override
  Widget build(BuildContext context) {
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
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildWorldSelection(),
          Column(
            children: [
              userDetailCard(currentStudent: currentStudent),
              _buildDescription(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWorldSelection() {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.015,
        ),
        IconButton(
          iconSize: 60,
          padding: EdgeInsets.all(0),
          onPressed: () {
            setState(() {
              selectedWorld = selectedWorld == "World 1"
                  ? "World 3"
                  : selectedWorld == "World 3"
                      ? "World 2"
                      : "World 1";
            });
          },
          icon: Icon(
            Icons.arrow_left_sharp,
            color: kMainTheme.primaryColor,
          ),
        ),
        Column(
          children: [
            SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.height * 0.75,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: clearedDetails.keys.toList().contains(selectedWorld)
                      ? AssetImage('assets/images/worlds/$selectedWorld.png')
                      : AssetImage('assets/images/lock.png'),
                ),
              ),
            ),
            Text(
              selectedWorld,
              style: TextStyle(
                  fontFamily: 'Regular',
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ],
        ),
        IconButton(
          iconSize: 60,
          padding: EdgeInsets.all(0),
          onPressed: () {
            setState(() {
              selectedWorld = selectedWorld == "World 1"
                  ? "World 2"
                  : selectedWorld == "World 2"
                      ? "World 3"
                      : "World 1";
            });
          },
          icon: Icon(
            Icons.arrow_right_sharp,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      width: MediaQuery.of(context).size.width * 0.45,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Selected: $selectedWorld',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: kMainTheme.primaryColor,
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: 'Regular'),
          ),
          Text(
            'Theme: ${descriptionMap[selectedWorld]}',
            style: TextStyle(
                color: kMainTheme.accentColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Regular'),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: RectangleButton(
                'Select World',
                clearedDetails.keys.toList().contains(selectedWorld)
                    ? () {
                        Navigator.pushNamed(context, SelectStage.id,
                            arguments: {
                              'world': selectedWorld,
                              'stages': clearedDetails[selectedWorld]
                            });
                      }
                    : null),
          ),
        ],
      ),
    );
  }
}
