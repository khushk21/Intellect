import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/home_screen.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/control/UserAccountMgr.dart';

class FirstLogin extends StatefulWidget {
  static String id = "first_login_screen";
  @override
  _FirstLoginState createState() => _FirstLoginState();
}

String enteredPassword = "";
String confirmPassword = "";

class _FirstLoginState extends State<FirstLogin> {
  bool obscureBool1 = true;
  bool obscureBool2 = true;

  @override
  Widget build(BuildContext context) {
    String username = ModalRoute.of(context).settings.arguments;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        backgroundColor: kPrimaryColor,
        title: Center(
          child: Text(
            "CHANGE PASSWORD",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                letterSpacing: 2.0,
                fontSize: 23.0),
          ),
        ),
      ),
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
                            UserAccountMgr.updateFirstPassword(
                                username, enteredPassword);
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
