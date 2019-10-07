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
      // theme: ThemeData.dark(),
      home: Scaffold(
        body: Column(
          children: <Widget>[
            Center(
              child: Container(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.15),
                width: MediaQuery.of(context).size.width * 0.95,
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.04),
                  ),
                  child: Container(
                    child: Text("foi"),
                    color: Colors.amber,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}