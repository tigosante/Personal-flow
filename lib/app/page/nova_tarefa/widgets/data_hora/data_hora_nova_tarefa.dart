import 'package:flutter/material.dart';

import 'data/data_nova_tarefa.dart';
import 'hora/hora_nova_tarefa.dart';

class DataHoraNovaTarefa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double tamanhoTela = MediaQuery.of(context).size.width;

    return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          DataNovaTarefa(),
          Text("-",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: tamanhoTela * 0.035)),
          HoraNovaTarefa()
        ]);
  }
}
