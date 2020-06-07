import 'package:flutter/material.dart';

import 'data/data_tarefa.dart';
import 'hora/hora_tarefa.dart';

class DataHoraComsposta extends StatelessWidget {
  DataHoraComsposta({Key key, this.dataHora}) : super(key: key);
  final List<String> dataHora;

  @override
  Widget build(BuildContext context) {
    double tamanhoTela = MediaQuery.of(context).size.width;

    return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          DataTarefaComposta(data: dataHora[0]),
          Text("-",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: tamanhoTela * 0.035)),
          HoraTarefaComposta(hora: dataHora[1])
        ]);
  }
}
