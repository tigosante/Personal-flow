import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class HeaderGraphic extends StatefulWidget {
  HeaderGraphic({Key key}) : super(key: key);

  _HeaderGraphicState createState() => _HeaderGraphicState();
}

class _HeaderGraphicState extends State<HeaderGraphic> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Center(
        child: Center(
          child: Card(
            child: Text("foi"),
          ),
        ),
      ),
    );
  }
}