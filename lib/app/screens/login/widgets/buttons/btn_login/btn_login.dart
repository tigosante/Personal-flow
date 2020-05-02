import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class BtnLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double tamanhoTela = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(right: tamanhoTela * .05),
      child: RaisedButton.icon(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(tamanhoTela * 0.1)),
        label: Icon(EvaIcons.arrowRightOutline, color: Colors.white),
        color: Colors.purple[900],
        icon: Text(
          "Entrar",
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {},
      ),
    );
  }
}
