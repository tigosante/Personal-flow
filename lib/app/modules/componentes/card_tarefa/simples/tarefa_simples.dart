import 'package:flutter/material.dart';
import 'package:personalflow/app/modules/componentes/data_hora/data_hora.dart';

class TarefaSimples extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double tamanhoTela = MediaQuery.of(context).size.width;

    return Card(
      elevation: 1.5,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(tamanhoTela * 0.035)),
      child: ListTile(
        title: Padding(
          padding: EdgeInsets.only(
            top: tamanhoTela * 0.03,
            left: tamanhoTela * 0.015,
          ),
          child: Text(
            "Título da tarefa.",
            style: TextStyle(fontSize: tamanhoTela * 0.045),
          ),
        ),
        subtitle: DataHora(),
        trailing: IconButton(
            icon: Icon(
              Icons.check_circle,
              color: Colors.teal,
            ),
            onPressed: () {}),
      ),
    );
  }
}
