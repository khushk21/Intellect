import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/character_screen.dart';
import 'package:flutter_auth/Screens/home_screen.dart';
import 'package:flutter_auth/Screens/welcome_screen.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/control/UserAccountMgr.dart';
import 'package:flutter_svg/svg.dart';

class ForgotPassword extends StatefulWidget {
  static String id = "forgot_screen";
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

String enteredPassword = "";
String confirmPassword = "";

class _ForgotPasswordState extends State<ForgotPassword> {
  bool obscureBool1 = true;
  bool obscureBool2 = true;

  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context).settings.arguments;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                "assets/images/main_top.png",
                width: size.width * 0.35,
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
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "LOGIN",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: size.height * 0.03),
                  SvgPicture.asset(
                    "assets/icons/login.svg",
                    height: size.height * 0.35,
                  ),
                  SizedBox(height: size.height * 0.03),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    width: size.width * 0.5,
                    decoration: BoxDecoration(
                      color: kPrimaryLightColor,
                      borderRadius: BorderRadius.circular(29),
                      border: Border.all(color: Colors.white),
                    ),
                    child: TextField(
                      obscureText: obscureBool1,
                      onChanged: (value) {
                        enteredPassword = value;
                      },
                      cursorColor: kPrimaryColor,
                      decoration: InputDecoration(
                        hintText: "New Password",
                        icon: Icon(
                          Icons.lock,
                          color: kPrimaryColor,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscureBool1 = !obscureBool1;
                            });
                          },
                          icon: Icon(
                            obscureBool1
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: kPrimaryColor,
                          ),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    width: size.width * 0.5,
                    decoration: BoxDecoration(
                      color: kPrimaryLightColor,
                      borderRadius: BorderRadius.circular(29),
                      border: Border.all(color: Colors.white),
                    ),
                    child: TextField(
                      obscureText: obscureBool2,
                      onChanged: (value) {
                        confirmPassword = value;
                      },
                      cursorColor: kPrimaryColor,
                      decoration: InputDecoration(
                        hintText: "Confirm New Password",
                        icon: Icon(
                          Icons.lock,
                          color: kPrimaryColor,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscureBool2 = !obscureBool2;
                            });
                          },
                          icon: Icon(
                            obscureBool2
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: kPrimaryColor,
                          ),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  RoundedButton(
                    text: "Change Password",
                    press: confirmPassword == enteredPassword &&
                            enteredPassword != ""
                        ? () async {
                            await UserAccountMgr.updateUserPassword(
                                email, enteredPassword);
                            Navigator.popUntil(
                                context, ModalRoute.withName(WelcomeScreen.id));
                            Navigator.pushNamed(context, HomeScreen.id);
                          }
                        : () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      title: Text(
                                        "PASSWORDS DONT MATCH",
                                        textAlign: TextAlign.center,
                                      ),
                                    ));
                          },
                  ),
                  SizedBox(height: size.height * 0.03),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
