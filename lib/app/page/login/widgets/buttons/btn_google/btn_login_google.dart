import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:personalflow/app/page/login/login_controller.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class BtnLoginGoogle extends StatelessWidget {
  BtnLoginGoogle({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double tamanhoTela = MediaQuery.of(context).size.width;
    return Padding(
        padding: EdgeInsets.only(left: tamanhoTela * 0.05),
        child: Container(
            child: FlatButton.icon(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(tamanhoTela * 0.1)),
                label: Icon(EvaIcons.google,
                    color: Colors.red, size: tamanhoTela * 0.04),
                color: Colors.red[900].withOpacity(0.1),
                icon: Text("Google", style: TextStyle(color: Colors.red)),
                onPressed: () =>
                    Modular.get<LoginController>().loginWith("google"))));
  }
}
