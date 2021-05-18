import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/select_level.dart';
import 'package:flutter_auth/components/short_rectangle_button.dart';
import 'package:flutter_auth/components/user_detail_card.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/control/UserAccountMgr.dart';
import 'package:flutter_auth/entity/Student.dart';

class SelectStage extends StatefulWidget {
  @override
  static String id = "stage_screen";
  _SelectStageState createState() => _SelectStageState();
}

class _SelectStageState extends State<SelectStage> {
  Student currentStudent;

  String selectedStage;
  Map descriptionMap = {
    'Stage 1': "3 Operand Equations",
    'Stage 2': "4 Operand Equations",
    'Stage 3': "5 Operand Equations",
  };
  String selectedWorld;
  Map clearedStage = {};
  @override
  void initState() {
    super.initState();
    selectedStage = 'Stage 1';
    currentStudent = UserAccountMgr.studentDetails;
  }

  @override
  Widget build(BuildContext context) {
    Map temp = ModalRoute.of(context).settings.arguments;
    selectedWorld = temp['world'];
    clearedStage = temp['stages'];
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
          _buildStageSelection(),
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

  Widget _buildStageSelection() {
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
              selectedStage = selectedStage == "Stage 1"
                  ? "Stage 3"
                  : selectedStage == "Stage 3"
                      ? "Stage 2"
                      : "Stage 1";
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
                  image: clearedStage.keys.toList().contains(selectedStage)
                      ? AssetImage(
                          'assets/images/stages/$selectedWorld - $selectedStage.png')
                      : AssetImage('assets/images/lock.png'),
                ),
              ),
            ),
            Text(
              selectedStage,
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
              selectedStage = selectedStage == "Stage 1"
                  ? "Stage 2"
                  : selectedStage == "Stage 2"
                      ? "Stage 3"
                      : "Stage 1";
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
            'Selected: $selectedStage',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: kMainTheme.primaryColor,
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: 'Regular'),
          ),
          Text(
            'Topic: ${descriptionMap[selectedStage]}',
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
                'Select Stage',
                clearedStage.keys.toList().contains(selectedStage)
                    ? () {
                        Navigator.pushNamed(context, SelectLevel.id,
                            arguments: {
                              'stage': selectedStage,
                              'world': selectedWorld,
                              'levels': clearedStage[selectedStage],
                            });
                      }
                    : null),
          ),
        ],
      ),
    );
  }
}
