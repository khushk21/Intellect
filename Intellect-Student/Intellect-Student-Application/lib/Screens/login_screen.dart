import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/first_time_login.dart';
import 'package:flutter_auth/Screens/home_screen.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_input_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_auth/control/LoginMgr.dart';
import '../constants.dart';

class LoginScreen extends StatefulWidget {
  static String id = "sigin_page";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

String enteredUsername = "";
String enteredPassword = "";
bool obscureBool = true;

class _LoginScreenState extends State<LoginScreen> {
  @override
  buildPopUp(String title, String body) {
    return AlertDialog(
      title: Text(title),
      content: Column(mainAxisSize: MainAxisSize.min, children: [Text(body)]),
    );
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        backgroundColor: kPrimaryColor,
        title: Center(
          child: Text(
            'LOGIN',
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
                  SizedBox(height: size.height * 0.03),
                  SvgPicture.asset(
                    "assets/icons/login.svg",
                    height: size.height * 0.3,
                  ),
                  SizedBox(height: size.height * 0.03),
                  RoundedInputField(
                    hintText: "Enter Your Username",
                    onChanged: (value) {
                      enteredUsername = value;
                    },
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
                      obscureText: obscureBool,
                      onChanged: (value) {
                        enteredPassword = value;
                      },
                      cursorColor: kPrimaryColor,
                      decoration: InputDecoration(
                        hintText: "Password",
                        icon: Icon(
                          Icons.lock,
                          color: kPrimaryColor,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscureBool = !obscureBool;
                            });
                          },
                          icon: Icon(
                            obscureBool
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
                    text: "LOGIN",
                    press: () async {
                      var login = await LoginMgr.loginToSystem(
                          enteredUsername, enteredPassword);
                      if (login && enteredPassword != "password") {
                        print('Login successful');
                        Navigator.popAndPushNamed(context, HomeScreen.id);
                      } else if (login && enteredPassword == 'password') {
                        print("first time login");
                        Navigator.pushNamed(context, FirstLogin.id,
                            arguments: enteredUsername);
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => buildPopUp(
                                "Error",
                                'Please enter correct username and/or password.'));
                      }
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
