import 'package:flutter/material.dart';
import 'package:personal_flow/app/screens/graphic/components/header.dart';

class Graphic extends StatefulWidget {
  Graphic({Key key}) : super(key: key);

  _GraphicState createState() => _GraphicState();
}

class _GraphicState extends State<Graphic> {
  @override
  Widget build(BuildContext context) {
    return HeaderGraphic();
  }
}