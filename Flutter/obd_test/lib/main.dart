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
      body: _buildBody(),
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
            child: Column(children: <Widget>[
      mainUpper(context),
      mainList(),
    ])));
  }
}

Widget mainUpper(BuildContext context) {
  return Container(
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
          child: Icon(Icons.menu),
          onPressed: () => showMenu(
              context: context,
              position: RelativeRect.fromLTRB(50, 50, 50, 50),
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HUDdisplay()));
                  },
                ),
                PopupMenuItem<String>(
                  child: Text("Setting"),
                  onTap: () {
                    // Navigator.pop(context);
                    Navigator.push<void>(context,
                        MaterialPageRoute(builder: (context) => HUDdisplay()));
                  },
                ),
              ]),
          // onPressed: () => ScaffoldMessenger.of(context)
          //     .showSnackBar(SnackBar(content: Text("Wha~~~~~T??"))),
          style: ButtonStyle(
              minimumSize: MaterialStateProperty.all<Size>(Size(50, 60)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)))),
        ),
        margin: EdgeInsets.all(10),
      ),
      Expanded(
          child: Column(
        children: [mainCarStatus(context), mainSelector(context)],
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
          style: TextStyle(fontSize: 10),
        ),
      ),
      Container(
        child: Icon(
          Icons.face_sharp,
          size: 60,
        ),
        margin: EdgeInsets.all(5),
      ),
    ],
  ));
}

Widget mainSelector(BuildContext context) {
  return Container(
    child: Column(
      children: [
        Container(
          child: Text(
            "Selected",
            style: TextStyle(fontSize: 10),
          ),
          margin: EdgeInsets.only(top: 5),
        ),
        Icon(Icons.precision_manufacturing_outlined, size: 60),
      ],
      mainAxisSize: MainAxisSize.max,
    ),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), color: Colors.indigo),
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
    margin: EdgeInsets.all(10),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), color: Colors.indigo),
  );
}

Widget infoKeyValue(String _key, String _val) {
  return Row(
    children: [
      Expanded(
          child: Container(
        child: Text(
          _key,
          style: TextStyle(fontSize: 10),
        ),
        alignment: AlignmentDirectional(-1.0, 1.0),
        margin: EdgeInsets.only(left: 15, top: 8),
      )),
      Expanded(
          child: Container(
        child: Text(
          _val,
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.start,
        ),
        margin: EdgeInsets.all(10),
      )),
    ],
  );
}
