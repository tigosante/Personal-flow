import 'package:flutter/material.dart';

class Graphic extends StatefulWidget {
  Graphic({Key key}) : super(key: key);

  _GraphicState createState() => _GraphicState();
}

class _GraphicState extends State<Graphic> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
       child: Center(
         child: Text("Gráfico"),
       ),
    );
  }
}