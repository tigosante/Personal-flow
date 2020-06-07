import 'package:flutter/material.dart';
import 'package:personalflow/pages/nova_tarefa/widgets/data_hora/data_hora_nova_tarefa.dart';

class SubtarefaInput extends StatelessWidget {
  SubtarefaInput({Key key, this.subtarefa, this.tamanhoTela}) : super(key: key);

  final String subtarefa;
  final double tamanhoTela;

  @override
  Widget build(BuildContext context) => Padding(
      padding: EdgeInsets.only(bottom: tamanhoTela * 0.02),
      child: Container(
          width: tamanhoTela * 0.95,
          child: Card(
              elevation: 0,
              color: Colors.yellow.withOpacity(0.5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(tamanhoTela * 0.05)),
              child: ListTile(
                  title: Container(
                      child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Título da subtarefa"))),
                  subtitle: Container(
                      width: tamanhoTela, child: DataHoraNovaTarefa()),
                  trailing: IconButton(
                      icon:
                          Icon(Icons.remove_circle_outline, color: Colors.red),
                      onPressed: () {})))));
}
