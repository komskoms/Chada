import 'dart:math';
import 'dart:ui';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:obd_test/OBD_PID.dart';
import 'package:obd_test/bottomDrawer.dart';
import 'HUDscreen.dart';
import 'homeListView.dart';
import 'comms.dart';
import 'diagnose.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OBD_App',
      theme: ThemeData(
        colorScheme: ColorScheme.dark(),
        primarySwatch: Colors.indigo,
      ),
      home: MyPage(),
    );
  }
}

class MyPage extends StatelessWidget {
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
  @override
  State<_buildBody> createState() => _buildBodyState();
}

class _buildBodyState extends State<_buildBody> {
  carInfo info = carInfo();
  bool showMainMenu = false;
  bool showBottomMenu = false;

  @override
  void initState() {
    super.initState();

    info.switchTest();
    Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() {
        if (info.getServer != null) {
          info.scanAll();
          info.printReceived();
        }
      });
    });
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
                child: drawerForSetting())
            ],
          ),
        ),
      );
    } 
  }

  Widget mainUpper(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      margin: EdgeInsets.only(top: 20, right: 20, left: 20),
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: mainMenu(context),
            ),
            Expanded(
              flex: 3,
              child: mainUpperRight(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget mainMenu(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      primary: Color(0xff6161F5),
      minimumSize: Size(MediaQuery.of(context).size.width * 0.3,
                        MediaQuery.of(context).size.height * 0.3 * 0.17),
    );

    if (showMainMenu == false) {
      return Container(
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
        child: Column(
          children: [
            ElevatedButton(
              style: style,
              onPressed: () {
                setState(() {
                  showMainMenu = false;
                });
              },
              child: Text(
                "닫 기",
                style: TextStyle(
                    color: Color(0xffefefef), fontWeight: FontWeight.bold),
                ),
              ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3 * 0.06,
            ),
            ElevatedButton(
              style: style,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => diagnose()));
              },
              child: Text(
                "차량진단",
                style: TextStyle(
                    color: Color(0xffefefef), fontWeight: FontWeight.bold),
                ),
              ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3 * 0.06,
            ),
            ElevatedButton(
              style: style,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HUDdisplay()));
              },
              child: Text(
                "H U D",
                style: TextStyle(
                    color: Color(0xffefefef), fontWeight: FontWeight.bold),
                ),
              ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3 * 0.06,
            ),
            ElevatedButton(
              style: style,
              onPressed: () {
                setState(() {
                  showBottomMenu = (showBottomMenu) ? false : true;
                });
              },
              child: Text(
                "블루투스",
                style: TextStyle(
                    color: Color(0xffefefef), fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget mainUpperRight(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3 * 0.95,
      margin: EdgeInsets.only(left: 30),
      child: mainSimpleInfo(context),
    );
  }

  Widget mainSimpleInfo(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3 * 0.9,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Color(0xff6161F5)),
      child: Column(
        children: [
          infoKeyValue(
              "RPM", "${info.getValue[PidName.indexOf("ENGINE_SPEED")]} rpm"),
          infoKeyValue("Temp",
              "${info.getValue[PidName.indexOf("ENGINE_COOLANT_TEMPERATURE")]} ˚C"),
          infoKeyValue("Load",
              "${info.getValue[PidName.indexOf("CALCULATED_ENGINE_LOAD")]} %"),
          infoKeyValue("Fuel",
              "${info.getValue[PidName.indexOf("FUEL_TANK_LEVEL_INPUT")]} %"),
        ],
      ),
    );
  }

  Widget infoKeyValue(String _key, String _val) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3 * 0.9 * 0.25,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              alignment: AlignmentDirectional(1.0, 0.25),
              child: Text(
                _key,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              alignment: AlignmentDirectional(0.1, 0.25),
              child: Text(
                _val,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
