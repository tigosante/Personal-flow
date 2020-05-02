import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class CamposLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double tamanhoTela = MediaQuery.of(context).size.width;
    EdgeInsets paddingContainer = EdgeInsets.only(
        left: tamanhoTela * 0.05,
        right: tamanhoTela * 0.05,
        bottom: tamanhoTela * 0.05);
    EdgeInsets paddingInput =
        EdgeInsets.only(left: tamanhoTela * 0.03, right: tamanhoTela * 0.03);

    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: paddingContainer,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(bottom: tamanhoTela * 0.01),
                    child: Text("e-mail",
                        style: TextStyle(
                            fontSize: tamanhoTela * 0.04,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple[700]))),
                Container(
                  padding: paddingInput,
                  decoration: BoxDecoration(
                    // color: Colors.teal[700],
                    border: Border.all(color: Colors.teal[700]),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                        suffixIcon: Icon(EvaIcons.checkmarkCircle,
                            color: Colors.teal[700]),
                        border: InputBorder.none),
                    style: TextStyle(
                        color: Colors.teal[700], fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: paddingContainer,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(bottom: tamanhoTela * 0.01),
                    child: Text("senha",
                        style: TextStyle(
                            fontSize: tamanhoTela * 0.04,
                            fontWeight: FontWeight.bold,
                            color: Colors.yellow[900]))),
                Container(
                  padding: paddingInput,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.indigo[700],
                  ),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                        suffixIcon:
                            Icon(EvaIcons.checkmarkCircle, color: Colors.white),
                        border: InputBorder.none),
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
