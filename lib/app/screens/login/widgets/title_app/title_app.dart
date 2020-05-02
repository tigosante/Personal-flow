import 'package:flutter/material.dart';

class TitleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double tamanhoTela = MediaQuery.of(context).size.width;

    return Padding(
        child: Text("Personal Flow",
            style: TextStyle(
                color: Colors.orange[800],
                fontWeight: FontWeight.bold,
                letterSpacing: tamanhoTela * 0.005,
                fontSize: tamanhoTela * 0.05)),
        padding: EdgeInsets.only(
            top: tamanhoTela * 0.05, right: tamanhoTela * 0.05));
  }
}
