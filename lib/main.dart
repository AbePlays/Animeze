import 'package:animeze/screens/Home/Home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animeze',
      theme: ThemeData(fontFamily: 'Poppins'),
      home: Home(),
    );
  }
}
