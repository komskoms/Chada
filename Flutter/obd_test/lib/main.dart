import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:obd_test/bottomDrawer.dart';
import 'HUDscreen.dart';
import 'homeListView.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OBD_AppTest',
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
  bool showMainMenu = false;
  bool showBottomMenu = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double threshold = 100;

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
        child: Center(
            child: Row(
      children: [
        Expanded(
          flex: 1,
          child: mainMenu(context),
        ),
        Expanded(
          flex: 3,
          child: mainStatus(context),
        ),
        Expanded(
          flex: 4,
          child: mainSimpleInfo(context),
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    )));
  }

  Widget mainMenu(BuildContext context) {
    if (showMainMenu == false) {
      return Container(
        child: ElevatedButton(
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
                onPressed: () {
                  setState(() {
                    showMainMenu = false;
                  });
                },
                child: Icon(Icons.close)),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HUDdisplay()));
                },
                child: Icon(Icons.table_rows_outlined)),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    showBottomMenu = (showBottomMenu) ? false : true;
                  });
                },
                child: Icon(Icons.settings)),
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
            margin: EdgeInsets.all(10),
          ),
        ],
      ),
    );
  }

  Widget mainSelector(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            child: Text(
              "Selected",
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
            margin: EdgeInsets.only(bottom: 7),
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
          infoKeyValue("RPM", "750"),
          infoKeyValue("Temp", "24'C"),
          infoKeyValue("Load", "0%"),
          infoKeyValue("Fuel", "42%"),
        ],
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xff6161F5)),
    );
  }

  Widget infoKeyValue(String _key, String _val) {
    return Container(
      margin: EdgeInsets.only(top: 13, left: 5, bottom: 13),
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
