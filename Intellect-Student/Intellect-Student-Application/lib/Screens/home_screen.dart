import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/assignment_screen.dart';
import 'package:flutter_auth/Screens/challenges_screen.dart';
import 'package:flutter_auth/Screens/character_screen.dart';
import 'package:flutter_auth/Screens/leaderboard_filter_screen.dart';
import 'package:flutter_auth/Screens/settings_screen.dart';
import 'package:flutter_auth/Screens/welcome_screen.dart';
import 'package:flutter_auth/Screens/worlds_screen.dart';
import 'dart:core';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/control/QuestionsMgr.dart';
import 'package:flutter_auth/control/UserAccountMgr.dart';
import 'challenges_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  HomeScreen();
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void initState() {
    super.initState();

    UserAccountMgr.playBackgroundMusic();
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          elevation: 5.0,
          leading: RotatedBox(
            quarterTurns: 2,
            child: IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                UserAccountMgr.stopBackgroundMusic();
                Navigator.popUntil(
                    context, ModalRoute.withName(WelcomeScreen.id));
              },
            ),
          ),
          backgroundColor: kPrimaryColor,
          title: Center(
            child: Text(
              'HOME',
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
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              "assets/images/login_bottom.png",
              width: size.width * 0.4,
            ),
          ),
          Center(child: SingleChildScrollView(child: buildMain()))
        ]));
  }

  buildMain() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          buildButton(Icons.emoji_events, "Solo Campaign", () {
            Navigator.pushNamed(context, WorldsScreen.id);
          }),
          buildButton(Icons.person_add_alt_1, "Challenge Friends", () {
            Navigator.pushNamed(context, ChallengeScreen.id);
          }),
          buildButton(Icons.leaderboard, "Leaderboard", () async {
            Navigator.pushNamed(context, LeaderBoardFilterScreen.id);
          }),
        ]),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          buildButton(Icons.assignment, "Assignment", () {
            Navigator.pushNamed(context, AssignmentScreen.id);
          }),
          buildButton(Icons.texture, "Change Character", () {
            Navigator.pushNamed(context, CharacterScreen.id);
          }),
          buildButton(Icons.settings, "Settings", () {
            Navigator.pushNamed(context, SettingsScreen.id);
          }),
        ]),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.075,
        ),
      ],
    );
  }

  buildButton(IconData icon, String title, Function onpressed) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          child: Container(
              child: Icon(
            icon,
            size: 75,
            color: Colors.black,
          )),
          onTap: onpressed,
        ),
        Container(
          width: 100,
          child: Text(
            title,
            style: TextStyle(color: Colors.black, fontSize: 14),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
