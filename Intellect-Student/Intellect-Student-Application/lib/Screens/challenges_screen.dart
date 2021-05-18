import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/challenge_received_history.dart';
import 'package:flutter_auth/Screens/challenge_sent_history.dart';
import 'package:flutter_auth/Screens/create_new_challenge.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import '.././constants.dart';
import './pending_challenges_screen.dart';

class ChallengeScreen extends StatelessWidget {
  static String id = "ChallengeScreen";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        backgroundColor: kPrimaryColor,
        title: Center(
          child: Text(
            'Player v/s Player',
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
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RoundedButton(
                    text: "Create Challenges",
                    press: () {
                      Navigator.pushNamed(context, CreateNewChallengeScreen.id);
                    },
                  ),
                  RoundedButton(
                    text: "Pending Challenges",
                    color: kPrimaryLightColor,
                    textColor: Colors.black,
                    press: () {
                      Navigator.pushNamed(context, PendingChallengesScreen.id);
                    },
                  ),
                  RoundedButton(
                    text: "Sent History",
                    press: () {
                      Navigator.pushNamed(context, ChallengeSentHistory.id);
                    },
                  ),
                  RoundedButton(
                    text: "Received History",
                    color: kPrimaryLightColor,
                    textColor: Colors.black,
                    press: () {
                      Navigator.pushNamed(context, ChallengeReceivedHistory.id);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
