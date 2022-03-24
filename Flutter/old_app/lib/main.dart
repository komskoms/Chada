import 'package:flutter/material.dart';
import 'homeListView.dart';


void main() => runApp(const Chada());

class Chada extends StatelessWidget {
  const Chada({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChaDa',
      theme: ThemeData(
        colorScheme: ColorScheme.dark(),
        primarySwatch: Colors.indigo,
      ),
      home: MyPage(),
    );
  }
}
