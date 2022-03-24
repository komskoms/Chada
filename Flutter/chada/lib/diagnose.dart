import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'OBD_PID.dart';
import 'comms.dart';

class diagnose extends StatefulWidget {
  const diagnose({Key key}) : super(key: key);
  @override
  _diagnoseState createState() => _diagnoseState();
}

class _diagnoseState extends State<diagnose> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double witdh = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Container(
      color: Colors.amber[50],
      child: Column(
        children: [
          Container(
            color: Colors.amber[100],
            height: MediaQuery.of(context).size.height * 0.4,
          ),
          Container(
            color: Colors.orange,
            height: MediaQuery.of(context).size.height * 0.1,
            child: Text(
              "진단 중...",
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            color: Colors.blue,
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                dtcCode("dtc code name"),
                dtcCode("dtc code name"),
                dtcCode("dtc code name"),
              ]
            ),
          ), 
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            color: Colors.red,
            child: ButtonBar(),
          ),
        ],
      ),
    ));
  }

  Widget dtcCode(String dtcName) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3 * 0.2,
        color: Colors.amber,
        child: Text(
          dtcName,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
