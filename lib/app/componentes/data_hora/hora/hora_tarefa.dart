import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:personalflow/app/screens/home/pages/simples/simples_controller.dart';
import 'package:personalflow/core/model/simples/model.dart';
import 'package:personalflow/core/view/view_simples.dart';

class HoraTarefa extends StatelessWidget {
  final int index;
  HoraTarefa({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double tamanhoTela = MediaQuery.of(context).size.width;
    ModelTarefaSimples tarefa =
        Modular.get<SimplesController>().tarefaSimples.data[index];

    return Card(
        elevation: 0,
        color: Colors.transparent,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(tamanhoTela * 0.05)),
        child: InkWell(
            child: Container(
                padding: EdgeInsets.only(
                    top: tamanhoTela * 0.02,
                    left: tamanhoTela * 0.01,
                    right: tamanhoTela * 0.01,
                    bottom: tamanhoTela * 0.02),
                child: Text(tarefa.hora,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: tamanhoTela * 0.035))),
            onTap: () async {
              tarefa.saveHora(await ViewSimples.popUpHora(context));
            }));
  }
}
