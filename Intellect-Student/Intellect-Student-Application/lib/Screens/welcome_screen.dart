import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/login_screen.dart';
import 'package:flutter_auth/Screens/reset_screen.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  static String id = 'welcome_page';
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        backgroundColor: kPrimaryColor,
        title: Center(
          child: Text(
            'WELCOME TO INTELLECT',
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
                  SizedBox(height: size.height * 0.01),
                  SvgPicture.asset(
                    "assets/icons/chat.svg",
                    height: size.height * 0.45,
                  ),
                  SizedBox(height: size.height * 0.02),
                  RoundedButton(
                    text: "LOGIN",
                    press: () {
                      Navigator.pushNamed(context, LoginScreen.id);
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, ResetScreen.id);
                    },
                    child: Text(
                      "FORGOT PASSWORD?",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
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
