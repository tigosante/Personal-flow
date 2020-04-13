import 'package:flutter/material.dart';

import 'data/data_tarefa.dart';
import 'hora/hora_tarefa.dart';

class DataHora extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double tamanhoTela = MediaQuery.of(context).size.width;

    return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          DataTarefa(),
          Text(":",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: tamanhoTela * 0.035)),
          HoraTarefa()
        ]);
  }
}
