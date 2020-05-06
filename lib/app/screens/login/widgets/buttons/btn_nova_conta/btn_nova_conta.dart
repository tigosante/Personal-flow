import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:personalflow/app/screens/login/login_controller.dart';

class BtnNovaConta extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double tamanhoTela = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(
          top: tamanhoTela * 0.05,
          left: tamanhoTela * 0.05,
          right: tamanhoTela * 0.05),
      child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(tamanhoTela * 0.1)),
          color: Colors.teal[900].withOpacity(0.1),
          child: Center(
            child: Container(
              padding: EdgeInsets.all(tamanhoTela * 0.025),
              child: Text("Criar nova conta",
                  style: TextStyle(color: Colors.teal)),
            ),
          ),
          onPressed: () => Modular.get<LoginController>().loginWith("email")),
    );
  }
}
