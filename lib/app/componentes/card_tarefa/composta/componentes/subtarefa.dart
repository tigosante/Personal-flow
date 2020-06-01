import 'package:flutter/material.dart';
import 'package:personalflow/app/componentes/data_hora/composta/data_hora.dart';
import 'package:personalflow/core/models/composta_model.dart';

class SubtarefaWidget extends StatelessWidget {
  SubtarefaWidget({Key key, this.subtarefa}) : super(key: key);

  final Subtarefa subtarefa;

  @override
  Widget build(BuildContext context) {
    double tamanhoTela = MediaQuery.of(context).size.width;

    return Column(children: <Widget>[
      Padding(
          padding: EdgeInsets.only(top: tamanhoTela * 0.02),
          child: ListTile(
              title: Text(subtarefa.title,
                  style: TextStyle(
                      fontSize: tamanhoTela * 0.045,
                      fontWeight: FontWeight.bold)),
              subtitle: DataHoraComsposta(
                dataHora: [subtarefa.data, subtarefa.hora],
              ),
              trailing: IconButton(
                  icon: Icon(
                      subtarefa.check
                          ? Icons.check
                          : Icons.radio_button_unchecked,
                      color: Colors.teal[700]),
                  onPressed: () {})))
    ]);
  }
}
