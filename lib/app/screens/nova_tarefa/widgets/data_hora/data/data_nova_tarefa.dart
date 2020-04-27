import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:personalflow/core/model/modelDefault.dart';
import 'package:personalflow/core/view/view_simples.dart';

import '../../../nova_tarefa_controller.dart';

class DataNovaTarefa extends StatelessWidget {
  final ctrl = Modular.get<NovaTarefaController>();

  @override
  Widget build(BuildContext context) {
    double tamanhoTela = MediaQuery.of(context).size.width;

    return Card(
        elevation: 0,
        color: Colors.transparent,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(tamanhoTela * 0.05)),
        child: Observer(
            builder: (_) => InkWell(
                child: Container(
                    padding: EdgeInsets.only(
                        top: tamanhoTela * 0.02,
                        left: tamanhoTela * 0.01,
                        right: tamanhoTela * 0.01,
                        bottom: tamanhoTela * 0.02),
                    child: Text(ctrl.dataNovaTarefa ?? "Data",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: tamanhoTela * 0.035))),
                onTap: () async {
                  ctrl.dataNovaTarefa = ModelDefault.dataTratada(
                      await ViewSimples.popUpData(context));
                })));
  }
}
