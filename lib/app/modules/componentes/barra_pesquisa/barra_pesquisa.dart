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

    return Observer(builder: (_) {
      return Container(
        height: tamanhoTela * 0.25,
        width: tamanhoTela,
        decoration: BoxDecoration(
            color: appController.colorBarra,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(tamanhoTela * 0.03),
              bottomRight: Radius.circular(tamanhoTela * 0.03),
            )),
        child: Padding(
          padding: EdgeInsets.only(
            top: tamanhoTela * 0.08,
            left: tamanhoTela * 0.014,
            right: tamanhoTela * 0.015,
            bottom: tamanhoTela * 0.03,
          ),
          child: Card(
            elevation: 0,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(tamanhoTela * 0.05),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: tamanhoTela * 0.03),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Buscar tarefa",
                      ),
                    ),
                  ),
                ),
                controller.iconBarra,
              ],
            ),
          ),
        ),
      );
    });
  }
}
