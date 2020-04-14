import 'package:flutter/material.dart';
import 'package:personalflow/app/modules/componentes/data_hora/data_hora.dart';

class NewTaskSimple extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double tamanhoTela = MediaQuery.of(context).size.width;

    return Column(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(top: tamanhoTela * 0.02),
            child: Container(
              width: tamanhoTela * 0.95,
              child: Card(
                  elevation: 0,
                  color: Colors.blue[700].withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(tamanhoTela * 0.05)),
                  child: ListTile(
                      title: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Título da Tarefa")),
                      subtitle: DataHora())),
            )),
      ],
    );
  }
}
