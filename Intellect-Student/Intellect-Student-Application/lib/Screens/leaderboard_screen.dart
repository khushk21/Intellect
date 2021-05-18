import 'package:flutter/material.dart';
import 'dart:core';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/control/LeaderboardMgr.dart';
import 'package:flutter_auth/control/UserAccountMgr.dart';

class Leaderboard extends StatefulWidget {
  @override
  static String id = "leaderboard_screen";
  _LeaderboardState createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  String world;
  String stage;
  String level;
  Map leaderboard = {};
  bool haveboard = false;
  int rank = 0;

  getLeaderBoard() async {
    Map temp = await LeaderboardMgr.getLeaderBoard(world, stage, level);
    setState(() {
      leaderboard = temp;
      haveboard = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    Map temp = ModalRoute.of(context).settings.arguments;
    world = temp['world'];
    stage = temp['stage'];
    level = temp['level'];
    if (!haveboard) {
      getLeaderBoard();
    }
    print("$world  $stage  $level");
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          elevation: 5.0,
          leading: RotatedBox(
            quarterTurns: 2,
            child: IconButton(
              icon: Icon(Icons.arrow_forward_rounded),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          backgroundColor: kPrimaryColor,
          title: Center(
            child: Text(
              'LEADERBOARD',
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
            left: 0,
            child: Image.asset(
              "assets/images/main_bottom.png",
              width: size.width * 0.2,
            ),
          ),
          haveboard
              ? buildMain()
              : Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Center(child: CircularProgressIndicator()))
        ]));
  }

  buildMain() {
    Size size = MediaQuery.of(context).size;

    return Container(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 10.0),
        height: size.height,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SingleChildScrollView(
              child: DataTable(
                sortColumnIndex: 2,
                sortAscending: false,
                columns: <DataColumn>[
                  DataColumn(label: Text('Rank')),
                  DataColumn(label: Text('Username')),
                  DataColumn(label: Text('Score')),
                ],
                rows: buildDataRow(),
              ),
            ),
            Container(
                width: 200,
                height: 800,
                margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                decoration: BoxDecoration(
                  color: Colors.purple[200],
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 90.0),
                    Text(UserAccountMgr.studentDetails.username,
                        style: TextStyle(
                            color: Colors.grey[900],
                            letterSpacing: 2.0,
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 20.0),
                    Text('Rank: $rank',
                        style: TextStyle(
                            color: Colors.grey[900],
                            letterSpacing: 2.0,
                            fontSize: 21.0,
                            fontWeight: FontWeight.w700)),
                    SizedBox(height: 20.0),
                    Text(
                        "Score: ${leaderboard[UserAccountMgr.studentDetails.username].toString()}",
                        style: TextStyle(
                            color: Colors.grey[900],
                            letterSpacing: 2.0,
                            fontSize: 21.0,
                            fontWeight: FontWeight.w700)),
                  ],
                )),
          ],
        ));
  }

  buildDataRow() {
    List<DataRow> tableRows = [];
    int i = leaderboard.length;
    leaderboard.forEach((key, value) {
      if (key == UserAccountMgr.studentDetails.username) {
        setState(() {
          rank = i;
        });
      }
      tableRows.add(DataRow(cells: [
        DataCell(Text(i.toString())),
        DataCell(Text(key)),
        DataCell(Text(value.toString())),
      ]));
      i--;
    });
    List<DataRow> reversedList = new List.from(tableRows.reversed);
    return reversedList;
  }
}
