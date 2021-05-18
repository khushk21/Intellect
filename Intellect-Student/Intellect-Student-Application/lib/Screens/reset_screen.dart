import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/otp_screen.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_input_field.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_auth/control/OTPMgr.dart';

class ResetScreen extends StatefulWidget {
  @override
  static String id = "reset_screen";
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  @override
  bool exists = false;
  String enteredEmail = "";

  checkEmail() async {
    bool temp = await OTPMgr.validateEmail(enteredEmail);
    setState(() {
      exists = temp;
    });
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        backgroundColor: kPrimaryColor,
        title: Center(
          child: Text(
            "FORGOT PASSWORD",
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
                "assets/images/reset_top.png",
                width: size.width * 0.35,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset(
                "assets/images/main_bottom.png",
                width: size.width * 0.25,
              ),
            ),
            SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: size.height * 0.03),
                    SvgPicture.asset(
                      "assets/icons/signup.svg",
                      height: size.height * 0.35,
                    ),
                    RoundedInputField(
                      hintText: "Your Email",
                      onChanged: (value) {
                        enteredEmail = value;
                      },
                    ),
                    RoundedButton(
                      text: "Request OTP",
                      press: () async {
                        await checkEmail();
                        if (exists) {
                          Map args = {
                            'email': enteredEmail,
                          };
                          OTPMgr.sendOTP(enteredEmail);
                          Navigator.pushNamed(context, OtpScreen.id,
                              arguments: args);
                        } else {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                    title: Text("ERROR!"),
                                    content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text("Please enter valid email ID")
                                        ]),
                                  ));
                        }
                      },
                    ),
                    SizedBox(height: size.height * 0.03),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
