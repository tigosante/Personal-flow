import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:personalflow/app/modules/componentes/card_tarefa/componentes/botoes.dart';
import 'package:personalflow/app/modules/componentes/data_hora/data_hora.dart';

import '../../../../app_controller.dart';
import 'componentes/barra_progresso.dart';
import 'componentes/body.dart';

class TarefaComposta extends StatelessWidget {
  final controller = Modular.get<AppController>();

  @override
  Widget build(BuildContext context) {
    double tamanhoTela = MediaQuery.of(context).size.width;

    return Card(
      elevation: 5,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(tamanhoTela * 0.035)),
      child: Observer(builder: (_) {
        return ExpansionTile(
          title: Padding(
            padding: EdgeInsets.only(top: tamanhoTela * 0.03),
            child: Text("Título da composta.",
                style: TextStyle(
                    fontSize: tamanhoTela * 0.045,
                    fontWeight: FontWeight.bold,
                    color: controller.colorTarefa)),
          ),
          subtitle: Column(
            children: <Widget>[
              Container(width: tamanhoTela, child: DataHora()),
              Container(
                  width: tamanhoTela,
                  child: BarraProgresso(tamanhoTela: tamanhoTela)),
            ],
          ),
          children: <Widget>[
            Divider(indent: tamanhoTela * 0.05, endIndent: tamanhoTela * 0.05),
            BodyComposta(),
            BotoesTarefa(tamanhoTela: tamanhoTela),
          ],
        );
      }),
    );
  }
}
