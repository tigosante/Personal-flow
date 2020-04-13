import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../app_controller.dart';
import 'barra_pesquisa_controller.dart';

class BarraPesquisa extends StatelessWidget {
  final controller = Modular.get<BarraPesquisaController>();
  final appController = Modular.get<AppController>();

  @override
  Widget build(BuildContext context) {
    double tamanhoTela = MediaQuery.of(context).size.width;

    return Padding(
        padding: EdgeInsets.only(
          top: tamanhoTela * 0.04,
          left: tamanhoTela * 0.06,
          right: tamanhoTela * 0.06,
          bottom: tamanhoTela * 0.03,
        ),
        child: Observer(builder: (_) {
          return Card(
              elevation: 0,
              color: Colors.teal.withOpacity(0.2),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(tamanhoTela * 0.1)),
              child: Row(children: <Widget>[
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(left: tamanhoTela * 0.04),
                        child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Buscar tarefa")))),
                controller.iconBarra,
              ]));
        }));
  }
}
