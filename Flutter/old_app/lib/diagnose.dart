import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'OBD_PID.dart';
import 'comms.dart';

enum DiagStatus { Diag_Standby, Diag_Running, Diag_Finished }

class diagnose extends StatefulWidget {
  const diagnose({Key key}) : super(key: key);
  @override
  _diagnoseState createState() => _diagnoseState();
}

class _diagnoseState extends State<diagnose> {
  DiagStatus _diagStatus = DiagStatus.Diag_Standby;
  bool _animationControl = false;

  List<String> diagResults = List.generate(0, (index) => null, growable: true);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double witdh = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Container(
        color: Colors.grey[900],
        child: Column(
          children: [
            carImageView(),
            diagnosisButton(),
            detailedDiagInfo(),
          ],
        ),
      )
    );
  }

  Widget carImageView() {
    return Stack(children: <Widget>[
      Container(
        height: MediaQuery.of(context).size.height * 0.4,
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Image.asset("assets/images/car_illustrated.png"),
      )
    ]);
  }

  Widget diagnosisButton() {
    return Container(
        padding: EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width * 0.8,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              // onSurface: Color.fromARGB(255, 55, 9, 13),
              primary: Color(0xff6161F5),
              shadowColor: Color.fromARGB(255, 90, 7, 131),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              )),
          onPressed: _diagStatus != DiagStatus.Diag_Standby
              ? null
              : () {
                  setState(() {
                    _diagStatus = DiagStatus.Diag_Running;
                    runDiagnosis();
                  });
                },
          child: Text(
            _diagStatus == DiagStatus.Diag_Standby
                ? "진단 시작"
                : _diagStatus == DiagStatus.Diag_Running
                    ? "진단 중..."
                    : "진단 완료",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: _diagStatus == DiagStatus.Diag_Standby ?
                Colors.white : Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ));
  }

  Widget detailedDiagInfo() {
    return Container(
      padding: EdgeInsets.all(20),
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: diagResults.length > 0
            ? diagResults.length
            : _diagStatus == DiagStatus.Diag_Finished
                ? 1
                : 0,
        itemBuilder: (BuildContext context, int index) {
          if (diagResults.length == 0) {
            return dtcCode("No Trouble have Found");
          } else {
            return dtcCode(diagResults[index]);
          }
        },
      ),
    );
  }

  Widget dtcCode(String dtcName) {
    return Center(
      child: Container(
        child: Text(
          dtcName,
          style: TextStyle(
            fontSize: 15,
            decorationStyle: TextDecorationStyle.double,
          ),
        ),
      ),
    );
  }

  void runDiagnosis() {
    var rand = math.Random();
    int iter = rand.nextInt(30); // 0~30

    if (15 < iter) iter = 0; // 0~14, 15~30=>0
    Timer(Duration(seconds: 5), () {
      setState(() {
        _diagStatus = DiagStatus.Diag_Finished;
        while (iter != 0) {
          iter--;
          diagResults
              .add("Random DTC Code: ${rand.nextInt(10000).toRadixString(16)}");
        }
        print(diagResults);
      });
    });
  }
}
