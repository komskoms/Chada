import 'package:flutter/material.dart';
import 'package:obd_test/main.dart';

class mainList extends StatelessWidget {
  @override
  Widget build(context) {
    return SafeArea(
        child: ListView(
      shrinkWrap: true,
      padding: EdgeInsets.all(10),
      children: <Widget>[
        itemCard("data01", "00"),
        itemCard("data02", "70"),
        itemCard("data03", "42"),
        itemCard("data04", "40"),
      ],
    ));
  }

  Widget itemCard(String name, String value) {
    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: Icon(
                Icons.adb_outlined,
                size: 60,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: 80,
              margin: EdgeInsets.all(5),
              alignment: AlignmentDirectional(-1, 0),
              child: Text("$name",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              height: 80,
              margin: EdgeInsets.all(5),
              alignment: AlignmentDirectional(-0.2, 0),
              child: Text(
                "$value unit",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomLayoutRow01 extends Row {
  static List<Widget> _children = [
    Container(
      alignment: Alignment.center,
      color: Colors.cyan,
    ),
    Container(
      alignment: Alignment.center,
      color: Colors.yellow,
    ),
  ];

  CustomLayoutRow01() : super(children: _children);
}
