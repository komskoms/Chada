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
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            color: Colors.blue,
            child: ListView(
              shrinkWrap: true,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.3 * 0.3,
                  color: Colors.amber,
                  child: Text("data"),
                ),
                Container(
                  color: Colors.amber,
                  child: Text("data"),
                ),
                Container(
                  color: Colors.amber,
                  child: Text("data"),
                ),
                Container(
                  color: Colors.amber,
                  child: Text("data"),
                ),
                Container(
                  color: Colors.amber,
                  child: Text("data"),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            color: Colors.red,
            child: ElevatedButton(),
          ),
        ],
      ),
    ));
  }
}
