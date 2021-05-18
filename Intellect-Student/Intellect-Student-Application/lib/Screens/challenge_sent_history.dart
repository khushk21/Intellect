import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/control/ChallengeMgr.dart';
import 'package:flutter_auth/entity/Challenge.dart';

class ChallengeSentHistory extends StatefulWidget {
  static String id = "challenge_sent_history";
  @override
  _ChallengeSentHistoryState createState() => _ChallengeSentHistoryState();
}

class _ChallengeSentHistoryState extends State<ChallengeSentHistory> {
  List<Challenge> challenges = [];
  bool haveChallenge = false;
  @override
  void initState() {
    super.initState();
    getReceivedChallenges();
  }

  getReceivedChallenges() async {
    List<Challenge> temp = await ChallengeMgr.retrievePastSentChallenges();
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
              "CHALLENGES SENT HISTORY",
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
              ? challenges.length == 0
                  ? Center(
                      child:
                          Text("Sorry, no data to display!", style: kBigText),
                    )
                  : Center(
                      child: SingleChildScrollView(
                        child: DataTable(
                          sortColumnIndex: 2,
                          sortAscending: false,
                          columns: <DataColumn>[
                            DataColumn(label: Text('Sent on')),
                            DataColumn(label: Text('Sent to')),
                            DataColumn(label: Text('World')),
                            DataColumn(label: Text('Stage')),
                            DataColumn(label: Text('Level')),
                            DataColumn(label: Text('Your score')),
                            DataColumn(label: Text('Opponent score')),
                          ],
                          rows: buildDataRow(),
                        ),
                      ),
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
        DataCell(Text(element.challengeId.substring(0, 10))),
        DataCell(Text(element.receiver ?? "null")),
        DataCell(Text(element.question['world'])),
        DataCell(Text(element.question['stage'])),
        DataCell(Text(element.question['level'])),
        DataCell(Text(element.myScore.toString())),
        DataCell(Text(element.receiverScore.toString())),
      ]));
    });
    return tableRows;
  }
}
