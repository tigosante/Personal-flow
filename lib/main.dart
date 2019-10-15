import 'package:flutter/material.dart';
import 'package:personal_flow/app/screens/home/home2.dart';
// import 'package:personal_flow/app/screens/home/home.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: 
      // new ThemeData.dark(),
      ThemeData(
        primarySwatch: Colors.orange,
        fontFamily: 'Orkney-medium'
      ),

      home: Home(),
    );
  }
}
