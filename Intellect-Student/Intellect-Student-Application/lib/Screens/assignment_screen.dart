import 'package:flutter/material.dart';
import 'package:flutter_auth/components/rounded_button.dart';

import '.././constants.dart';
import '../constants.dart';
import './new_assignment_screen.dart';
import './past_assignment_screen.dart';

class AssignmentScreen extends StatelessWidget {
  static String id = "assignment_screen";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        backgroundColor: kPrimaryColor,
        title: Center(
          child: Text(
            'ASSIGNMENTS',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                letterSpacing: 2.0,
                fontSize: 23.0),
          ),
        ),
      ),
      body: Container(
        height: size.height,
        width: double.infinity,
        child: Stack(
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
            buildMain(context),
          ],
        ),
      ),
    );
  }

  Widget buildMain(context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RoundedButton(
            text: "Pending Assignments",
            press: () {
              print('Student access New Assignments');
              Navigator.pushNamed(context, NewAssignmentScreen.id);
            },
          ),
          RoundedButton(
            text: "Past Assignments",
            color: kPrimaryLightColor,
            textColor: Colors.black,
            press: () {
              print('Student access Past Assignments');
              Navigator.pushNamed(context, PastAssignmentScreen.id);
            },
          ),
        ],
      ),
    );
  }
}
