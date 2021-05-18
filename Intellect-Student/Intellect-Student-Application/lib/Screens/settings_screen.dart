import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/first_time_login.dart';
import 'package:flutter_auth/Screens/login_screen.dart';
import 'package:flutter_auth/Screens/welcome_screen.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/components/user_detail_card.dart';
import 'package:flutter_auth/control/UserAccountMgr.dart';
import 'package:flutter_auth/entity/Student.dart';

class SettingsScreen extends StatefulWidget {
  static String id = "settings_screen";
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Student currentStudent;
  bool bgm;
  @override
  void initState() {
    super.initState();
    currentStudent = UserAccountMgr.studentDetails;
    bgm = UserAccountMgr.bgmBool;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          elevation: 5.0,
          backgroundColor: kPrimaryColor,
          title: Padding(
            padding: const EdgeInsets.fromLTRB(270, 0, 0, 0),
            child: Text(
              'SETTINGS',
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
            right: 0,
            child: Image.asset(
              "assets/images/login_bottom.png",
              width: size.width * 0.4,
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
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * (0.25),
                height: MediaQuery.of(context).size.height * (0.2),
                child: userDetailCard(
                  currentStudent: currentStudent,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.music_note_outlined),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Background Music',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Regular'),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Switch(
                      value: bgm,
                      onChanged: (bool value) {
                        UserAccountMgr.bgmBool = value;
                        print(value);
                        if (value) {
                          UserAccountMgr.playBackgroundMusic();
                        } else {
                          UserAccountMgr.stopBackgroundMusic();
                        }
                        setState(() {
                          bgm = !bgm;
                        });
                      })
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * (0.25),
                      height: MediaQuery.of(context).size.height * (0.1),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onPressed: () {
                          Navigator.pushNamed(context, FirstLogin.id,
                              arguments:
                                  UserAccountMgr.studentDetails.username);
                        },
                        color: Color(0xFF8ac4d0),
                        child: Text(
                          'Change Password',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Regular'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * (0.25),
                      height: MediaQuery.of(context).size.height * (0.1),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onPressed: () {
                          UserAccountMgr.stopBackgroundMusic();
                          Navigator.popUntil(
                              context, ModalRoute.withName(WelcomeScreen.id));
                        },
                        color: Color(0xFF8ac4d0),
                        child: Text(
                          'Logout',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Regular'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ]));
  }
}
