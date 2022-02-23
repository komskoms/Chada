import 'package:flutter/material.dart';
import 'package:obd_test/coms.dart';
import 'package:obd_test/main.dart';

class mainList extends StatelessWidget {
  carInfo info = carInfo();

  @override
  Widget build(context) {
    return Container(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(10),
        children: <Widget>[
          itemCard("1_speed", "SPEED", "${info.CUR_SPD}"),
          itemCard("2_engine", "ENGINE", "${info.ENG_RPM}"),
          itemCard("3_battery", "BETTARY", "${info.BAT_CHG}"),
          itemCard("4_accelerate", "ACCEL", "${info.ACCEL}"),
        ],
      ),
    );
  }

  Widget itemCard(String image_name, String name, String value) {
    return Container(
      child: Row(
        children: [
          Container(
              width: 60,
              height: 60,
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Color(0xff7EBCB3),
              ),
              child: Image.asset(
                'assets/images/$image_name.png',
                fit: BoxFit.contain,
              )),
          Expanded(
            flex: 1,
            child: Container(
              height: 80,
              margin: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10),
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
              margin: EdgeInsets.only(left: 50.0),
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
