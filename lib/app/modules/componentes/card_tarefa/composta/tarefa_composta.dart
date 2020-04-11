import 'package:flutter/material.dart';
import 'package:personalflow/app/modules/componentes/card_tarefa/componentes/botoes.dart';
import 'package:personalflow/app/modules/componentes/data_hora/data_hora.dart';

import 'componentes/barra_progresso.dart';
import 'componentes/body.dart';

class TarefaComposta extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double tamanhoTela = MediaQuery.of(context).size.width;

    return Card(
      elevation: 1.5,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(tamanhoTela * 0.035)),
      child: ExpansionTile(
        title: Text("Título da composta.",
            style: TextStyle(fontSize: tamanhoTela * 0.045)),
        subtitle: DataHora(),
        children: <Widget>[
          BarraProgresso(tamanhoTela: tamanhoTela),
          BodyComposta(),
          BotoesTarefa(tamanhoTela: tamanhoTela),
        ],
      ),
    );
  }
}
