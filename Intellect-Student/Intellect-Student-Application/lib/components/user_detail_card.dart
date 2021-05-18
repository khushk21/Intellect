import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/control/UserAccountMgr.dart';
import 'package:flutter_auth/entity/Student.dart';

class userDetailCard extends StatelessWidget {
  userDetailCard({
    Key key,
    @required this.currentStudent,
  }) : super(key: key);

  final Student currentStudent;
  final String selectedCharacter = UserAccountMgr.studentDetails.character;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: Card(
          color: Color(0xff938BC0),
          child: Row(
            children: [
              SizedBox(width: 25),
              CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                          'assets/images/characters/$selectedCharacter.png'),
                    ),
                  ),
                ),
                radius: 30.0,
              ),
              SizedBox(width: 25),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    currentStudent.username,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20.0,
                      fontFamily: 'ConcertOne',
                      letterSpacing: 1.5,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Lvl ${currentStudent.experience}",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                      fontFamily: 'ConcertOne',
                      letterSpacing: 1.5,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              SizedBox(width: 25),
            ],
          )),
    );
  }
}
