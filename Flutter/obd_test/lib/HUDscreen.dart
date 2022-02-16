import 'package:flutter/material.dart';

// class HUDdisplay extends StatefulWidget {
//   const HUDdisplay({Key? key}) : super(key: key);
//   @override
//   _HUDdisplayState createState() => _HUDdisplayState();
// }

// class _HUDdisplayState extends State<HUDdisplay> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("asdfadsf"),
//       ),
//       body: Container(),
//     );
//   }
// }

class HUDdisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("asdfadsf"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text("data"),
        ],),
      ),
    );
  }
}
