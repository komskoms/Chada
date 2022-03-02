import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'OBD_PID.dart';
import 'comms.dart';

class HUDdisplay extends StatefulWidget {
  const HUDdisplay({Key key}) : super(key: key);
  @override
  _HUDdisplayState createState() => _HUDdisplayState();
}

class _HUDdisplayState extends State<HUDdisplay> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double witdh = MediaQuery.of(context).size.width;

    return OrientationBuilder(builder: (context, orientation) {
      return GestureDetector(
          onDoubleTap: () => Navigator.pop(context),
          child: Scaffold(
              body: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(math.pi),
            child: PageView(
              children: [
                showBox(context, orientation, "Speed", "VEHICLE_SPEED"),
                // split05(context),
                // split04(context),
                // split03(context),
                // split02(context),
              ],
            ),
          )));
    });
  }

  Widget showBox(BuildContext context, Orientation orientation, String title,
      String PIDname) {
    carInfo info = carInfo();

    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(MediaQuery.of(context).size.height * 0.05),
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Color(0xff6161F5),
                width: 1,
              ),
            ),
            child: Text(
              "$title",
              style: TextStyle(
                // fontSize: MediaQuery.of(context).size.height * 0.3,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          Container(
              child: Text(
            "${info.getValue[PidName.indexOf(PIDname)]}",
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.3,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.start,
          )),
          Container(child: Text("${info.selectUnit(PIDname)}")),
        ],
      )
    );
  }
// 5분할 화면

  Widget split05(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                margin: EdgeInsets.only(top: 40, bottom: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Color(0xff6161F5),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Container(
                          child: Text(
                            "Data1",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          ),
                          alignment: AlignmentDirectional(0.0, 0.0),
                        )),
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Text(
                          "750",
                          style: TextStyle(
                              fontSize: 50, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                        alignment: AlignmentDirectional(0.0, 0.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 3,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        margin: EdgeInsets.only(
                          top: 5,
                          bottom: 5,
                          left: MediaQuery.of(context).size.width * 0.1,
                          right: 5,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Color(0xff6161F5),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Container(
                                  child: Text(
                                    "Data2",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                )),
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: Text(
                                  "24'C",
                                  style: TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                                alignment: AlignmentDirectional(0.0, -1.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        margin: EdgeInsets.only(
                          top: 5,
                          bottom: 5,
                          left: 5,
                          right: MediaQuery.of(context).size.width * 0.1,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Color(0xff6161F5),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Container(
                                  child: Text(
                                    "Data3",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                )),
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: Text(
                                  "0%",
                                  style: TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                                alignment: AlignmentDirectional(0.0, -1.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
            Expanded(
                flex: 3,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        margin: EdgeInsets.only(
                          top: 5,
                          bottom: 40,
                          left: MediaQuery.of(context).size.width * 0.1,
                          right: 5,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Color(0xff6161F5),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Container(
                                  child: Text(
                                    "Data4",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                )),
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: Text(
                                  "42%",
                                  style: TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                                alignment: AlignmentDirectional(0.0, -1.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        margin: EdgeInsets.only(
                          top: 5,
                          bottom: 40,
                          left: 5,
                          right: MediaQuery.of(context).size.width * 0.1,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Color(0xff6161F5),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Container(
                                  child: Text(
                                    "Extra",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                )),
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: Text(
                                  "-",
                                  style: TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                                alignment: AlignmentDirectional(0.0, -1.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

//4분할 화면

  Widget split04(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 40, bottom: 40),
        child: Column(
          children: [
            Expanded(
                child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.45,
                    margin: EdgeInsets.only(
                      top: 5,
                      bottom: 5,
                      left: MediaQuery.of(context).size.width * 0.1,
                      right: 5,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Color(0xff6161F5),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Container(
                              child: Text(
                                "Data2",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                              alignment: AlignmentDirectional(0.0, 0.0),
                            )),
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: Text(
                              "24'C",
                              style: TextStyle(
                                  fontSize: 50, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            alignment: AlignmentDirectional(0.0, -1.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.45,
                    margin: EdgeInsets.only(
                      top: 5,
                      bottom: 5,
                      left: 5,
                      right: MediaQuery.of(context).size.width * 0.1,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Color(0xff6161F5),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Container(
                              child: Text(
                                "Data3",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                              alignment: AlignmentDirectional(0.0, 0.0),
                            )),
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: Text(
                              "0%",
                              style: TextStyle(
                                  fontSize: 50, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            alignment: AlignmentDirectional(0.0, -1.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
            Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.45,
                        margin: EdgeInsets.only(
                          top: 5,
                          bottom: 5,
                          left: MediaQuery.of(context).size.width * 0.1,
                          right: 5,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Color(0xff6161F5),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Container(
                                  child: Text(
                                    "Data4",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                )),
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: Text(
                                  "42%",
                                  style: TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                                alignment: AlignmentDirectional(0.0, -1.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.45,
                        margin: EdgeInsets.only(
                          top: 5,
                          bottom: 5,
                          left: 5,
                          right: MediaQuery.of(context).size.width * 0.1,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Color(0xff6161F5),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Container(
                                  child: Text(
                                    "Extra",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                )),
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: Text(
                                  "-",
                                  style: TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                                alignment: AlignmentDirectional(0.0, -1.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

// 3분할 화면

  Widget split03(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 40, bottom: 40),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Color(0xff6161F5),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Container(
                          child: Text(
                            "Data1",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          ),
                          alignment: AlignmentDirectional(0.0, 0.0),
                        )),
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Text(
                          "750",
                          style: TextStyle(
                              fontSize: 50, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                        alignment: AlignmentDirectional(0.0, 0.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        margin: EdgeInsets.only(
                          top: 5,
                          left: MediaQuery.of(context).size.width * 0.1,
                          right: 5,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Color(0xff6161F5),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Container(
                                  child: Text(
                                    "Data4",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                )),
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: Text(
                                  "42%",
                                  style: TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                                alignment: AlignmentDirectional(0.0, -1.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        margin: EdgeInsets.only(
                          top: 5,
                          left: 5,
                          right: MediaQuery.of(context).size.width * 0.1,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Color(0xff6161F5),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Container(
                                  child: Text(
                                    "Extra",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                )),
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: Text(
                                  "-",
                                  style: TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                                alignment: AlignmentDirectional(0.0, -1.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

//2분할 화면

  Widget split02(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 40, bottom: 40),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(bottom: 5),
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Color(0xff6161F5),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Container(
                          child: Text(
                            "Data1",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          ),
                          alignment: AlignmentDirectional(0.0, 0.0),
                        )),
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Text(
                          "750",
                          style: TextStyle(
                              fontSize: 50, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                        alignment: AlignmentDirectional(0.0, 0.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(top: 5),
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Color(0xff6161F5),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Container(
                          child: Text(
                            "Data1",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          ),
                          alignment: AlignmentDirectional(0.0, 0.0),
                        )),
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Text(
                          "750",
                          style: TextStyle(
                              fontSize: 50, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                        alignment: AlignmentDirectional(0.0, 0.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
