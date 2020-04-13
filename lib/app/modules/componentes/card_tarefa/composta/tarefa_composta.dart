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
      elevation: 0.5,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(tamanhoTela * 0.05)),
      child: ExpansionTile(
        title: Padding(
          padding: EdgeInsets.only(
              top: tamanhoTela * 0.03, left: tamanhoTela * 0.018),
          child: Text("Título da composta.",
              style: TextStyle(
                  fontSize: tamanhoTela * 0.045, fontWeight: FontWeight.bold)),
        ),
        subtitle: Column(
          children: <Widget>[
            Container(width: tamanhoTela, child: DataHora()),
            Padding(
              padding: EdgeInsets.only(left: tamanhoTela * 0.02),
              child: Container(
                  width: tamanhoTela,
                  height: tamanhoTela * 0.06,
                  child: BarraProgresso(tamanhoTela: tamanhoTela)),
            ),
          ],
        ),
        children: <Widget>[
          BodyComposta(),
          BotoesTarefa(tamanhoTela: tamanhoTela),
        ],
      ),
    );
  }
}
