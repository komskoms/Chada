import 'package:flutter/material.dart';

class HUDdisplay extends StatefulWidget {
  const HUDdisplay({Key key}) : super(key: key);
  @override
  _HUDdisplayState createState() => _HUDdisplayState();
}

class _HUDdisplayState extends State<HUDdisplay> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () => Navigator.pop(context),
      child: Scaffold(
        body: PageView(
          children: [
            split05(context),
            split04(context),
            split03(context),
            split02(context),
          ],),
    ));
  }

  Widget split05(BuildContext context) {
    return Container(
      child: Text("This should be 5-splited screen"),
    );
  }
  Widget split04(BuildContext context) {
    return Container(
      child: Text("This should be 4-splited screen"),
    );
  }
  Widget split03(BuildContext context) {
    return Container(
      child: Text("This should be 3-splited screen"),
    );
  }
  Widget split02(BuildContext context) {
    return Container(
      child: Text("This should be 2-splited screen"),
    );
  }
}
