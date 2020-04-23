import 'package:flutter/material.dart';

import 'data/data_tarefa.dart';
import 'hora/hora_tarefa.dart';

class DataHora extends StatelessWidget {
  final int index;
  DataHora({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double tamanhoTela = MediaQuery.of(context).size.width;

    return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          DataTarefa(index: index),
          Text("-",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: tamanhoTela * 0.035)),
          HoraTarefa(index: index)
        ]);
  }
}
