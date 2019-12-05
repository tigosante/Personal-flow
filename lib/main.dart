import 'package:flutter/material.dart';
import 'package:personal_flow/view/telas.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title                     : "Personal Flow",
      home                      : Telas(),
      debugShowCheckedModeBanner: false,
    );
  }
}
