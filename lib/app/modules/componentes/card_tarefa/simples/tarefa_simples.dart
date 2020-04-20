import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:personalflow/app/model/simples/model.dart';
import 'package:personalflow/app/modules/componentes/data_hora/data_hora.dart';
import 'package:personalflow/app/modules/home/pages/simples/simples_controller.dart';

class TarefaSimples extends StatelessWidget {
  final int index;
  TarefaSimples({this.index});

  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<SimplesController>();
    double tamanhoTela = MediaQuery.of(context).size.width;
    List<ModelTarefaSimples> tarefas = controller.tarefaSimples.data;

    return Card(
        elevation: 0,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(tamanhoTela * 0.05)),
        child: Slidable(
          actionPane: SlidableDrawerActionPane(),
          controller: SlidableController(),
          secondaryActions: <Widget>[
            IconSlideAction(
                icon: Icons.remove_circle_outline,
                color: Colors.red[700],
                caption: 'Remover',
                onTap: tarefas[index].delete),
            IconSlideAction(
              icon: Icons.archive,
              caption: 'Arquivar',
              color: Colors.yellow[800],
              // onTap: tarefas[index].delete
            )
          ],
          child: ListTile(
              onTap: () {
                controller.dialogTarefa(context, tarefas[index], tamanhoTela);
              },
              title: Padding(
                  padding: EdgeInsets.only(
                      top: tamanhoTela * 0.03, left: tamanhoTela * 0.015),
                  child: Text(tarefas[index].title,
                      style: TextStyle(
                          fontSize: tamanhoTela * 0.045,
                          fontWeight: FontWeight.bold))),
              subtitle: DataHora(),
              trailing: IconButton(
                  icon: Icon(
                      tarefas[index].check
                          ? Icons.check
                          : Icons.radio_button_unchecked,
                      color: Colors.teal[700]),
                  onPressed: tarefas[index].updateCheck)),
        ));
  }
}
