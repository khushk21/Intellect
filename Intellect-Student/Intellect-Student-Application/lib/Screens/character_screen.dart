import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/components/user_detail_card.dart';
import 'package:flutter_auth/components/short_rectangle_button.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/entity/Student.dart';
import 'package:flutter_auth/control/UserAccountMgr.dart';
import "dart:collection";

class CharacterScreen extends StatefulWidget {
  @override
  static String id = "character_page";
  _CharacterScreenState createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  String selectedCharacter;
  Student currentStudent;
  Map characterMap = {
    "Character 1": "None",
    "Character 2": "20% Extra Time",
    "Character 3": "20% Extra Health and 20% Extra Time",
  };
  Map unlockMap = {
    "Character 1": "0",
    "Character 2": "World 2",
    "Character 3": "World 3",
  };
  List<String> clearedWorlds = [];

  @override
  void initState() {
    super.initState();
    currentStudent = UserAccountMgr.studentDetails;
    selectedCharacter = currentStudent.character == ""
        ? "Character 1"
        : currentStudent.character;
    var temp = UserAccountMgr.studentDetails.world;

    temp.forEach((element) {
      clearedWorlds.add(element.name);
    });
    clearedWorlds = clearedWorlds.toSet().toList();
    print(clearedWorlds);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 5.0,
          backgroundColor: kPrimaryColor,
          title: Center(
            child: Text(
              'SELECT CHARACTER',
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
            _buildCharSelection(),
            Column(
              children: [
                userDetailCard(currentStudent: currentStudent),
                _buildDescription(),
              ],
            ),
          ],
        ));
  }

  Widget _buildCharSelection() {
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
              selectedCharacter = selectedCharacter == "Character 1"
                  ? "Character 3"
                  : selectedCharacter == "Character 3"
                      ? "Character 2"
                      : "Character 1";
            });
          },
          icon: Icon(
            Icons.arrow_left_sharp,
            color: kMainTheme.primaryColor,
          ),
        ),
        Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.height * 0.75,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: int.parse(selectedCharacter
                              .substring(selectedCharacter.length - 1)) <=
                          clearedWorlds.length
                      ? AssetImage(
                          'assets/images/characters/$selectedCharacter.png')
                      : AssetImage('assets/images/lock.png'),
                ),
              ),
            ),
            Text(
              selectedCharacter,
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
              selectedCharacter = selectedCharacter == "Character 1"
                  ? "Character 2"
                  : selectedCharacter == "Character 2"
                      ? "Character 3"
                      : "Character 1";
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
            'Selected: $selectedCharacter',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: kMainTheme.primaryColor,
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: 'Regular'),
          ),
          Text(
            'Ability: ${characterMap[selectedCharacter]}',
            style: TextStyle(
                color: kMainTheme.accentColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Regular'),
            textAlign: TextAlign.center,
          ),
          Text(
            int.parse(selectedCharacter
                        .substring(selectedCharacter.length - 1)) <=
                    clearedWorlds.length
                ? ""
                : 'Unlocks when you unlock ${unlockMap[selectedCharacter]}',
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
                'Select Character',
                int.parse(selectedCharacter
                            .substring(selectedCharacter.length - 1)) <=
                        clearedWorlds.length
                    ? buttonFunction
                    : null),
          ),
        ],
      ),
    );
  }

  buttonFunction() {
    currentStudent.character = selectedCharacter;
    UserAccountMgr.updateStudentDetails(
        currentStudent.username, "character", selectedCharacter);
    Navigator.pop(context);
  }
}
