import 'dart:ui';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:obd_test/bottomDrawer.dart';
import 'HUDscreen.dart';
import 'homeListView.dart';
import 'coms.dart';

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
    // TODO: implement initState
    super.initState();

    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (info.getServer != null) {
          info.scanAll();
        }
        // info.randomize();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    if (showBottomMenu == true) {
      return SafeArea(
          child: Center(
              child: Stack(
        children: [
          Column(children: <Widget>[
            mainUpper(context),
            mainList(),
          ]),
          GestureDetector(
              onTap: () {
                setState(() {
                  showBottomMenu = false;
                });
              },
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 200),
                opacity: (showBottomMenu) ? 1.0 : 0.0,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(
                    color: Colors.white.withOpacity(0.2),
                  ),
                ),
              )),
          AnimatedPositioned(
              curve: Curves.easeInOut,
              duration: Duration(milliseconds: 200),
              left: MediaQuery.of(context).size.width * 0.05,
              bottom: (showBottomMenu) ? -(height * 0.4) : -height,
              child: drawerForSetting())
        ],
      )));
    } else {
      return SafeArea(
          child: Center(
              child: Stack(
        children: [
          Column(children: <Widget>[
            mainUpper(context),
            mainList(),
          ]),
          AnimatedPositioned(
              curve: Curves.easeInOut,
              duration: Duration(milliseconds: 200),
              left: MediaQuery.of(context).size.width * 0.05,
              bottom: (showBottomMenu) ? -(height * 0.4) : -height,
              child: drawerForSetting())
        ],
      )));
    }
  }

  Widget mainUpper(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 20, right: 20, left: 20),
        child: Center(
            child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: mainMenu(context),
            ),
            Expanded(
              flex: 2,
              child: mainStatus(context),
            ),
            Expanded(
              flex: 3,
              child: mainSimpleInfo(context),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        )));
  }

  Widget mainMenu(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      primary: Color(0xff6161F5),
    );

    if (showMainMenu == false) {
      return Container(
        child: ElevatedButton(
          style: style,
          child: Icon(
            Icons.menu,
            color: Color(0xffefefef),
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
                child: Icon(
                  Icons.close,
                  color: Color(0xffefefef),
                )),
            ElevatedButton(
                style: style,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HUDdisplay()));
                },
                child: Icon(
                  Icons.table_rows_outlined,
                  color: Color(0xffefefef),
                )),
            ElevatedButton(
                style: style,
                onPressed: () {
                  setState(() {
                    showBottomMenu = (showBottomMenu) ? false : true;
                  });
                },
                child: Icon(
                  Icons.settings,
                  color: Color(0xffefefef),
                )),
          ],
        ),
      );
    }
  }

  Widget mainStatus(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Column(
          children: [mainCarStatus(context), mainSelector(context)],
        )),
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
    );
  }

  Widget mainCarStatus(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: Text(
              "My Car Status",
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            child: Icon(
              Icons.face_sharp,
              size: 60,
            ),
            margin: EdgeInsets.only(top: 10, bottom: 0),
          ),
        ],
      ),
    );
  }

  Widget mainSelector(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18),
      margin: EdgeInsets.only(top: 5, bottom: 10, left: 15, right: 15),
      child: Column(
        children: [
          Container(
            child: Text(
              "Selected",
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
            margin: EdgeInsets.only(bottom: 5),
          ),
          Image.asset('assets/images/1_speed.png', fit: BoxFit.contain),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Color(0xff6161F5)),
    );
  }

  Widget mainSimpleInfo(BuildContext context) {
    return Container(
      child: Column(
        children: [
          infoKeyValue("RPM", "${info.ENG_RPM}rpm"),
          infoKeyValue("Temp", "${info.COOL_TMP}˚C"),
          infoKeyValue("Load", "${info.ENG_LOAD}%"),
          infoKeyValue("Fuel", "${info.FUEL_LVL}%"),
        ],
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Color(0xff6161F5)),
    );
  }

  Widget infoKeyValue(String _key, String _val) {
    return Container(
      margin: EdgeInsets.all(11),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                child: Text(
                  _key,
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
                alignment: AlignmentDirectional(0.0, 0.0),
              )),
          Expanded(
            flex: 2,
            child: Container(
              child: Text(
                _val,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
              alignment: AlignmentDirectional(0.5, 0.0),
            ),
          ),
        ],
      ),
    );
  }
}
