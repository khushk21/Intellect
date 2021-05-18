import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/forgot_screen.dart';
import 'package:flutter_auth/Screens/welcome_screen.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_input_field.dart';
import 'package:flutter_auth/control/OTPMgr.dart';
import 'package:flutter_svg/svg.dart';

class OtpScreen extends StatefulWidget {
  @override
  static String id = "otp_screen";
  _OtpScreenState createState() => _OtpScreenState();
}

String enteredOtp = "";

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context).settings.arguments;
    String email = args['email'];
    Size size = MediaQuery.of(context).size;

    return Scaffold(
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
                    Text(
                      "OTP",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: size.height * 0.03),
                    SvgPicture.asset(
                      "assets/icons/signup.svg",
                      height: size.height * 0.35,
                    ),
                    RoundedInputField(
                      hintText: "Enter the OTP sent",
                      onChanged: (value) {
                        enteredOtp = value;
                      },
                    ),
                    RoundedButton(
                      text: "Verify",
                      press: () {
                        print(email);
                        print(OTPMgr.verifyOTP(email, enteredOtp));
                        if (OTPMgr.verifyOTP(email, enteredOtp)) {
                          Navigator.pushNamed(context, ForgotPassword.id,
                              arguments: email);
                        } else {
                          print('Wrong otp entered, retry');
                          showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              return AlertDialog(
                                title: Center(
                                  child: Text('Wrong OTP'),
                                ),
                                content: Text(
                                  'You have entered a wrong OTP.\n' +
                                      OTPMgr.numAttempts.toString() +
                                      ' attempts left.',
                                ),
                                actions: <Widget>[
                                  new FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    textColor: Colors.grey,
                                    child: const Text('Retry'),
                                  ),
                                ],
                              );
                            },
                          );
                          if ((OTPMgr.maxTries())) {
                            Navigator.popUntil(
                                context, ModalRoute.withName(WelcomeScreen.id));
                          }
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
