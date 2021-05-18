import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/control/AssignmentMgr.dart';
import 'package:flutter_auth/entity/Assignment.dart';

class PastAssignmentScreen extends StatefulWidget {
  static String id = "PastAssignmentScreen";
  @override
  _PastAssignmentScreenState createState() => _PastAssignmentScreenState();
}

class _PastAssignmentScreenState extends State<PastAssignmentScreen> {
  List<Assignment> assignments = [];
  bool haveAssignment = false;
  @override
  void initState() {
    super.initState();
    getAssignments();
  }

  getAssignments() async {
    List<Assignment> temp = await AssignmentMgr.retrievePastAssignments();
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
              "PAST ASSIGNMENT",
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
          haveAssignment
              ? assignments.length == 0
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
                            DataColumn(label: Text('Code')),
                            DataColumn(label: Text('Title')),
                            DataColumn(label: Text('World')),
                            DataColumn(label: Text('Result')),
                            DataColumn(label: Text('Score')),
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
    assignments.forEach((element) {
      tableRows.add(DataRow(cells: [
        DataCell(Text(element.assignmentCode)),
        DataCell(Text(element.title)),
        DataCell(Text(element.world)),
        DataCell(Text(element.cleared.length != 0 ? "PASS" : "FAIL")),
        DataCell(Text(element.cleared.length != 0
            ? element.cleared[0]['score'].toString()
            : "N/A")),
      ]));
    });
    return tableRows;
  }
}
