import 'package:flutter/material.dart';
import 'package:obd_test/main.dart';

Widget LayoutFrontMain(MyApp _page) {
  return Center();
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
