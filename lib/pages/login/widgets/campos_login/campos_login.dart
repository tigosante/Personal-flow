import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:personalflow/pages/login/controllers/login_controller.dart';

class CamposLogin extends StatelessWidget {
  final auth = Modular.get<LoginController>();

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
        child: Observer(
            builder: (_) => Column(children: <Widget>[
                  Padding(
                      padding: paddingContainer,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                                padding:
                                    EdgeInsets.only(bottom: tamanhoTela * 0.01),
                                child: Text("e-mail",
                                    style: TextStyle(
                                        fontSize: tamanhoTela * 0.04,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.purple))),
                            Container(
                                padding: paddingInput,
                                decoration: BoxDecoration(
                                  color: Colors.orange[700].withOpacity(0.1),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(tamanhoTela * 0.05)),
                                ),
                                child: TextField(
                                    controller: auth.controllerEmail,
                                    decoration: InputDecoration(
                                        suffixIcon: Icon(
                                            EvaIcons.checkmarkCircle,
                                            color: Colors.orange),
                                        border: InputBorder.none),
                                    style: TextStyle(
                                        color: Colors.orange,
                                        fontWeight: FontWeight.bold)))
                          ])),
                  Padding(
                      padding: paddingContainer,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                                padding:
                                    EdgeInsets.only(bottom: tamanhoTela * 0.01),
                                child: Text("senha",
                                    style: TextStyle(
                                        fontSize: tamanhoTela * 0.04,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.yellow[900]))),
                            Container(
                                padding: paddingInput,
                                decoration: BoxDecoration(
                                    color: Colors.indigo[700].withOpacity(0.1),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(tamanhoTela * 0.05))),
                                child: TextField(
                                    controller: auth.controllerSenhaEmail,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        suffixIcon: Icon(
                                            EvaIcons.checkmarkCircle,
                                            color: Colors.indigo),
                                        border: InputBorder.none),
                                    style: TextStyle(
                                        color: Colors.indigo,
                                        fontWeight: FontWeight.bold)))
                          ]))
                ])));
  }
}
