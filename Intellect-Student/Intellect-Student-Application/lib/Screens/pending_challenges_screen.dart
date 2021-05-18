import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/battle_screen.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/control/ChallengeMgr.dart';
import 'package:flutter_auth/entity/Challenge.dart';

class PendingChallengesScreen extends StatefulWidget {
  static String id = "PendingChallengeScreen";
  @override
  _PendingChallengesScreenState createState() =>
      _PendingChallengesScreenState();
}

class _PendingChallengesScreenState extends State<PendingChallengesScreen> {
  List<Challenge> challenges = [];
  bool haveChallenge = false;
  @override
  void initState() {
    super.initState();
    getPendingChallenges();
  }

  getPendingChallenges() async {
    List<Challenge> temp = await ChallengeMgr.retrieveCurrentChallenges();
    setState(() {
      challenges = temp;
      haveChallenge = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          elevation: 5.0,
          backgroundColor: kPrimaryColor,
          title: Center(
            child: Text(
              "PENDING CHALLENGES",
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
          haveChallenge
              ? challenges.length != 0
                  ? Center(
                      child: SingleChildScrollView(
                        child: DataTable(
                          sortColumnIndex: 2,
                          sortAscending: false,
                          columns: <DataColumn>[
                            DataColumn(label: Text('Received from')),
                            DataColumn(label: Text('World')),
                            DataColumn(label: Text('Stage')),
                            DataColumn(label: Text('Level')),
                            DataColumn(label: Text('Opponent score')),
                            DataColumn(label: Text('ATTEMPT?')),
                          ],
                          rows: buildDataRow(),
                        ),
                      ),
                    )
                  : Center(
                      child:
                          Text("Sorry, no data to display!", style: kBigText),
                    )
              : Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Center(child: CircularProgressIndicator())),
        ]));
  }

  buildDataRow() {
    List<DataRow> tableRows = [];
    challenges.forEach((element) {
      tableRows.add(DataRow(cells: [
        DataCell(Text(element.sender)),
        DataCell(Text(element.question['world'])),
        DataCell(Text(element.question['stage'])),
        DataCell(Text(element.question['level'])),
        DataCell(Text(element.myScore.toString())),
        DataCell(TextButton(
            child: Text("play"),
            onPressed: () {
              Navigator.pushNamed(context, BattleScreen.id, arguments: {
                "world": element.question['world'],
                "stage": element.question['stage'],
                "level": element.question['level'],
                "mode": "ChallengePlay",
                "extra": {
                  "chalenge_id": element.challengeId,
                  "score_to_beat": element.myScore
                }
              });
            }))
      ]));
    });
    return tableRows;
  }
}
