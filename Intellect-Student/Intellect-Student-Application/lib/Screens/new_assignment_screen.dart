import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/battle_screen.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/control/AssignmentMgr.dart';
import 'package:flutter_auth/entity/Assignment.dart';
import 'package:intl/intl.dart';

class NewAssignmentScreen extends StatefulWidget {
  static String id = "NewAssignmentScreen";
  @override
  _NewAssignmentScreenState createState() => _NewAssignmentScreenState();
}

class _NewAssignmentScreenState extends State<NewAssignmentScreen> {
  List<Assignment> assignments = [];
  bool haveAssignment = false;
  @override
  void initState() {
    super.initState();
    getPendingAssignments();
  }

  getPendingAssignments() async {
    List<Assignment> temp = await AssignmentMgr.readAssignment();
    print(temp);
    setState(() {
      assignments = temp;
      haveAssignment = true;
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
            "PENDING ASSIGNMENTS",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                letterSpacing: 2.0,
                fontSize: 23.0),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
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
              haveAssignment
                  ? buildMain()
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Center(child: CircularProgressIndicator())),
            ],
          ),
        ),
      ),
    );
  }

  buildMain() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          assignments.length != 0
              ? Center(
                  child: DataTable(
                    sortColumnIndex: 2,
                    sortAscending: false,
                    columns: <DataColumn>[
                      DataColumn(label: Text('Code')),
                      DataColumn(label: Text('Title')),
                      DataColumn(label: Text('World')),
                      DataColumn(label: Text('Due on : ')),
                      DataColumn(label: Text('ATTEMPT?')),
                    ],
                    rows: buildDataRow(),
                  ),
                )
              : Center(
                  child: Text("Sorry, no data to display!", style: kBigText),
                ),
        ],
      ),
    );
  }

  buildDataRow() {
    List<DataRow> tableRows = [];
    assignments.forEach((element) {
      tableRows.add(DataRow(cells: [
        DataCell(Text(element.assignmentCode)),
        DataCell(Text(element.title)),
        DataCell(Text(element.world)),
        DataCell(Text(
            DateFormat("dd-MMM-yyyy").format(DateTime.parse(element.dueDate)))),
        DataCell(TextButton(
          child: Text("play"),
          onPressed: () {
            Navigator.pushNamed(context, BattleScreen.id, arguments: {
              "world": element.world,
              "stage": "",
              "level": "",
              "mode": "Assignment",
              "extra": {
                "assignment_id": element.dueDate,
              }
            });
          },
        ))
      ]));
    });
    return tableRows;
  }
}
