import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ChaDa/comms.dart';
import 'OBD_PID.dart';
import 'diagnose.dart';
import 'bottomDrawer.dart';
import 'HUDscreen.dart';

class listItem {
  String imagePath;
  String title;
  String PIDname;

  listItem(this.imagePath, this.title, this.PIDname);
}

class MyPage extends StatelessWidget {
  MyPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: _buildBody(),
      ),
    );
  }
}

class _buildBody extends StatefulWidget {
  _buildBody({Key key}) : super(key: key);

  @override
  State<_buildBody> createState() => _buildBodyState();
}

class _buildBodyState extends State<_buildBody> {

  carInfo info = carInfo();
  bool showMainMenu = true;
  bool showBottomMenu = false;
  bool selectEasyMode = true;

  @override
  void initState() {
    super.initState();

    info.initialSwitch();
    // Timer.periodic(Duration(seconds: 1), (timer) {
    //   setState(() {
    //     if (info.getServer != null) {
    //       info.startScan(0);
    //       // info.scanAll();
    //       info.printReceived();
    //       // print("This should be showing every second");
    //     }
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    if (true) {
      return SafeArea(
        child: Center(
          child: Stack(
            children: [
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  setState(() {
                    showBottomMenu = false;
                  });
                },
                child: Column(children: <Widget>[
                  mainUpper(context),
                  mainList(),
                ]),
              ),
              AnimatedOpacity(
                duration: Duration(milliseconds: 200),
                opacity: (showBottomMenu) ? 1.0 : 0.0,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(
                    color: Colors.white.withOpacity(0.2),
                  ),
                ),
              ),
              AnimatedPositioned(
                curve: Curves.easeInOut,
                duration: Duration(milliseconds: 200),
                left: MediaQuery.of(context).size.width * 0.05,
                bottom: (showBottomMenu) ? -(height * 0.4) : -height,
                child: drawerForSetting()
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget mainUpper(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      primary: Color(0xff6161F5),
      minimumSize: Size(MediaQuery.of(context).size.width * 0.3,
          MediaQuery.of(context).size.height * 0.3 * 0.17),
    );
    if (showMainMenu == false) {
      return Container(
        margin: EdgeInsets.only(top: 20, right: 20, left: 20),
        alignment: Alignment.topLeft,
        child: ElevatedButton(
          style: style,
          child: Text(
            "설 정",
            style: TextStyle(
                color: Color(0xffefefef), fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            setState(() {
              showMainMenu = true;
            });
          },
        ),
      );
    } else {
      return Container(
        height: MediaQuery.of(context).size.height * 0.3,
        margin: EdgeInsets.only(top: 20, right: 20, left: 20),
        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: mainMenuButtons(context),
              ),
              Expanded(
                flex: 3,
                child: mainMenuPIDList(context),
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget mainMenuButtons(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      primary: Color(0xff6161F5),
      minimumSize: Size(MediaQuery.of(context).size.width * 0.3,
          MediaQuery.of(context).size.height * 0.3 * 0.17),
    );

    return Container(
      height: MediaQuery.of(context).size.height * 0.3 * 0.95,
      child: Column(
        children: [
          Expanded(
              child: menuButtons(
            title: "모 드",
            style: style,
            onPressed: () {
              setState(() {
                selectEasyMode = selectEasyMode == true ? false : true;
              });
            },
          )),
          Padding(padding: EdgeInsets.all(5)),
          Expanded(
              child: menuButtons(
            title: "차량진단",
            style: style,
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => diagnose()));
            },
          )),
          Padding(padding: EdgeInsets.all(5)),
          Expanded(
              child: menuButtons(
            title: "H U D",
            style: style,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HUDdisplay()));
            },
          )),
          Padding(padding: EdgeInsets.all(5)),
          Expanded(
              child: menuButtons(
            title: "블루투스",
            style: style,
            onPressed: () {
              setState(() {
                showBottomMenu = (showBottomMenu) ? false : true;
              });
            },
          )),
        ],
      ),
    );
  }

  Widget menuButtons(
      {String title, ButtonStyle style, void Function() onPressed}) {
    return Container(
        child: ElevatedButton(
      style: style,
      onPressed: onPressed,
      child: Text(
        title,
        style: TextStyle(
            color: Color(0xffefefef),
            fontSize: 12,
            overflow: TextOverflow.fade,
            fontWeight: FontWeight.bold),
      ),
    ));
  }

  Widget mainMenuPIDList(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3 * 0.95,
      margin: EdgeInsets.only(left: 30),
      child: mainSimpleInfo(context),
    );
  }

  Widget mainSimpleInfo(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            child: Text(
              selectEasyMode == true ? "일반인 모드" : "전문가 모드",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: Color(0xff6161F5),
                width: 1,
              ),
            ),
          )
        ),
        Padding(padding: EdgeInsets.all(1)),
        Expanded(
          flex: 6,
          child: Container(
            padding: EdgeInsets.only(bottom: 2, top: 2),
            // height: MediaQuery.of(context).size.height * 0.3 * 0.9,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Color(0xff6161F5)),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount:
                  selectEasyMode == true ? pidGroupsEasy.length : pidGroups.length,
              itemBuilder: (BuildContext context, int index) {
                if (selectEasyMode == true) {
                  return pidGroupCardEasy(index);
                } else {
                  return pidGroupCard(index);
                }
              },
            ),
          )
        )
      ]
    );
  }

  Widget pidGroupCardEasy(int index) {
    return Listener(
        onPointerUp: (_) {
          setState(() {
            selectedGroup = index;
          });
        },
        behavior: HitTestBehavior.translucent,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.3 * 0.9 * 0.2,
          child: Card(
            elevation: 4.0,
            color: Color.fromARGB(255, 115, 108, 179), // take out to outside
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
            // alignment: AlignmentDirectional(0, 0.25),
            child: Text(
              index == 0
                  ? "엔진계통"
                  : index == 1
                      ? "연료계통"
                      : index == 2
                          ? "주행관련"
                          : index == 3
                              ? "기타정보"
                              : "",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ));
  }

  Widget pidGroupCard(int pidGroupIndex) {
    return Listener(
        onPointerUp: (_) {
          setState(() {
            selectedGroup = pidGroupIndex;
          });
        },
        behavior: HitTestBehavior.translucent,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.3 * 0.9 * 0.2,
          child: Card(
            elevation: 4.0,
            color: Color.fromARGB(255, 115, 108, 179),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
            // alignment: AlignmentDirectional(0, 0.25),
            child: Text(
              pidGroupIndex == 0
                  ? "BookMarks"
                  : "PID ${(pidGroupIndex - 1) * 0x10} ~ ${(pidGroupIndex) * 0x10 - 1}",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ));
  }

  Widget mainList() {
    List<List<String>> _group =
        selectEasyMode == true ? pidGroupsEasy : pidGroups;

    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 30),
        itemCount: _group[selectedGroup].length,
        itemBuilder: (BuildContext context, int index) {
          return itemCard(toListItem(_group[selectedGroup][index]));
        },
      ),
    );
  }

  listItem toListItem(String pid) {
    switch (pid) {
      case "VEHICLE_SPEED":
        return listItem("1_speed", "SPEED", "VEHICLE_SPEED");
      case "ENGINE_SPEED":
        return listItem("2_engine", "Engine Speed", "ENGINE_SPEED");
      case "CONTROL_MODULE_VOLTAGE":
        return listItem(
            "3_battery", "Bettery Voltage", "CONTROL_MODULE_VOLTAGE");
      case "RELATIVE_ACCELERATOR_PEDAL_POSITTION":
        return listItem("4_accelerate", "Accel Position",
            "RELATIVE_ACCELERATOR_PEDAL_POSITTION");
      case "THROTTLE_POSITION":
        return listItem("4_accelerate", "Throttle", "THROTTLE_POSITION");
      case "ENGINE_COOLANT_TEMPERATURE":
        return listItem(
            "2_engine", "Coolant Temp", "ENGINE_COOLANT_TEMPERATURE");
      case "CALCULATED_ENGINE_LOAD":
        return listItem("2_engine", "Engine Load", "CALCULATED_ENGINE_LOAD");
      case "FUEL_TANK_LEVEL_INPUT":
        return listItem("2_engine", "Fuel Level", "FUEL_TANK_LEVEL_INPUT");
      case "RUN_TIME_SINCE_ENGINE_START":
        return listItem(
            "2_engine", "Engine Run Time", "RUN_TIME_SINCE_ENGINE_START");
      case "HYBRID_BATTERY_PACK_REMAINING_LIFE":
        return listItem("3_battery", "Battery Life ( for hybrid )",
            "HYBRID_BATTERY_PACK_REMAINING_LIFE");
      case "FUEL_PRESSURE":
        return listItem("2_engine", "Fuel Pressure", "FUEL_PRESSURE");
      case "ENGINE_FUEL_RATE":
        return listItem("2_engine", "Fuel Rate", "ENGINE_FUEL_RATE");
      case "DISTANCE_TRAVELED_WITH_MIL_ON":
        return listItem(
            "2_engine", "Dist MIL On", "DISTANCE_TRAVELED_WITH_MIL_ON");
      case "TIME_SINCE_TROUBLE_CODES_CLEARED":
        return listItem(
            "2_engine", "Time DTC Cleared", "TIME_SINCE_TROUBLE_CODES_CLEARED");
      default:
        return listItem("2_engine", pid, pid);
    }
  }

  Widget itemCard(listItem item) {
    assert(PidName.indexOf(item.PIDname) != -1,
        "Error: itemCard: PIDname [${item.PIDname}] not found");

    carInfo info = carInfo();
    int _value = info.getValue[PidName.indexOf(item.PIDname)];
    bool _toggleMarker = info.getScanFlag[PidName.indexOf(item.PIDname)];
    String _unit = info.selectUnit(item.PIDname);

    return GestureDetector(
      onTap: () {
        setState(() {
          _toggleMarker = (_toggleMarker == true) ? false : true;
          info.getScanFlag[PidName.indexOf(item.PIDname)] = _toggleMarker;
        });
      },
      child: Container(
        child: Row(
          children: [
            Container(
              width: 45,
              height: 45,
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Color(0xff7EBCB3),
              ),
              child: Image.asset(
                'assets/images/${item.imagePath}.png',
                fit: BoxFit.contain,
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                height: 60,
                margin: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 10),
                alignment: AlignmentDirectional(-1, 0),
                child: Text(
                  "${item.title}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
      ),
    );
  }
}
