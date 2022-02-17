import 'dart:ui';

import 'package:flutter/material.dart';
import 'HUDscreen.dart';
import 'homeListView.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
  MyPage({Key? key}) : super(key: key);

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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              mainUpper(context),
              mainList(),
    ])));
  }

  Widget mainUpper(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30, bottom: 0, left: 30, right: 30),
      child: Center(
          child: Row(
            children: [
              Expanded(child: mainLeftside(context)),
              Expanded(child: mainSimpleInfo(context)),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
    )));
  }

  Widget mainLeftside(BuildContext context) {
    return Row(
      children: [
        Container(
          child: ElevatedButton(
            child: Icon(
              Icons.menu,
              color: Color(0xffefefef),
            ),
            onPressed: () => showMenu(
                context: context,
                position: RelativeRect.fromLTRB(0, 120, 0, 100),
                items: [
                  PopupMenuItem<String>(
                    child: Text("showSnackbar"),
                    onTap: () {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text("Wha~~~~~T??")));
                    },
                  ),
                  PopupMenuItem<String>(
                    child: Text("HUDmode"),
                    onTap: () {
                      // Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HUDdisplay()));
                    },
                  ),
                  PopupMenuItem<String>(
                    child: Text("Setting"),
                    onTap: () {
                      // Navigator.pop(context);
                      Navigator.push<void>(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HUDdisplay()));
                    },
                  ),
                ]),
            // onPressed: () => ScaffoldMessenger.of(context)
            //     .showSnackBar(SnackBar(content: Text("Wha~~~~~T??"))),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xff6161F5)),
                minimumSize: MaterialStateProperty.all<Size>(Size(50, 60)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)))),
          ),
        ),
        Expanded(
            child: Column(
              children: [
                mainCarStatus(context),
                mainSelector(context)
              ],
        ))
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
