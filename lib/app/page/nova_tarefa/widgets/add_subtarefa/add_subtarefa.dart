import 'package:flutter/material.dart';

class AddSubtarefa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double tamanhoTela = MediaQuery.of(context).size.width;

    return Container(
        width: tamanhoTela * 0.85,
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Acionar subtarefa",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: tamanhoTela * 0.04,
                      color: Colors.teal[600],
                      letterSpacing: tamanhoTela * 0.002)),
              IconButton(
                  icon: Icon(Icons.add_circle, color: Colors.yellow[900]),
                  onPressed: () {})
            ]));
  }
}
