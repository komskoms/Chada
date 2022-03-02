import 'package:flutter/material.dart';
import 'package:obd_test/comms.dart';
import 'package:obd_test/main.dart';
import 'OBD_PID.dart';

class mainList extends StatefulWidget {
  @override
  State<mainList> createState() => _mainList();
}

class _mainList extends State<mainList> {
  @override
  Widget build(context) {
    return Container(
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 30),
        children: <Widget>[
          itemCard("1_speed", "SPEED", "VEHICLE_SPEED"),
          itemCard("2_engine", "ENGINE", "ENGINE_SPEED"),
          itemCard("3_battery", "BETTARY", "BATTERY_CHARGE"),
          itemCard("4_accelerate", "ACCEL", "THROTTLE_POSITION"),
        ],
      ),
    );
  }

  Widget itemCard(String image_name, String title, String PIDname) {
    assert(PidName.indexOf(PIDname) != -1,
        "Error: itemCard: PIDname [$PIDname] not found");
    carInfo info = carInfo();
    int _value = info.getValue[PidName.indexOf(PIDname)];
    bool _toggleMarker = info.getScanFlag[PidName.indexOf(PIDname)];
    String _unit = info.selectUnit(PIDname);

    return GestureDetector(
        onTap: () {
          setState(() {
            _toggleMarker = (_toggleMarker == true) ? false : true;
            info.getScanFlag[PidName.indexOf(PIDname)] = _toggleMarker;
          });
        },
        child: Container(
          child: Row(
            children: [
              Container(
                  width: 60,
                  height: 60,
                  padding: EdgeInsets.all(8),
                  margin:
                      EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 10),
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
                  child: Text("$title",
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
                    "$_value $_unit",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: (_toggleMarker == true)
                      ? Color(0xff7EBCB3)
                      : Color(0x00000000),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Color(0xff7EBCB3),
                    width: 2,
                  ),
                ),
              ),
            ],
          ),
        ));
  }

}
  // itemCard("1_speed", "SPEED", "VEHICLE_SPEED"),
        //   itemCard("2_engine", "ENGINE", "ENGINE_SPEED"),
        //   itemCard("3_battery", "BETTARY", "BATTERY_CHARGE"),
        //   itemCard("4_accelerate", "ACCEL", "THROTTLE_POSITION"),

// class CustomLayoutRow01 extends Row {
//   static List<Widget> _children = [
//     Container(
//       alignment: Alignment.center,
//       color: Colors.cyan,
//     ),
//     Container(
//       alignment: Alignment.center,
//       color: Colors.yellow,
//     ),
//   ];

//   CustomLayoutRow01() : super(children: _children);
// }
