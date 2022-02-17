import 'package:flutter/material.dart';

class drawerForSetting extends StatefulWidget {
  @override
  State<drawerForSetting> createState() => drawerForSettingState();
}

class drawerForSettingState extends State<drawerForSetting> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width * 0.9;

    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child: Container(
        width: width,
        height: height,
        color: Colors.deepPurpleAccent,
        child: Text("ImTesting"),
      ),
    );
  }
}
