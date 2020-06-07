import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class BtnLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double tamanhoTela = MediaQuery.of(context).size.width;
    return Padding(
        padding: EdgeInsets.only(right: tamanhoTela * .05),
        child: FlatButton.icon(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(tamanhoTela * 0.1)),
            label: Icon(EvaIcons.arrowRight, color: Colors.purple),
            color: Colors.purple[900].withOpacity(0.1),
            icon: Text("Conectar-se", style: TextStyle(color: Colors.purple)),
            onPressed: () {}));
  }
}
