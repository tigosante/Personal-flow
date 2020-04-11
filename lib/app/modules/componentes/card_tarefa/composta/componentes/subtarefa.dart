import 'package:flutter/material.dart';

import '../../../data_hora/data_hora.dart';

class Subtarefa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double tamanhoTela = MediaQuery.of(context).size.width;

    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: tamanhoTela * 0.02),
          child: ListTile(
              title: Text("Tarefa",
                  style: TextStyle(fontSize: tamanhoTela * 0.045)),
              subtitle: DataHora(),
              trailing: IconButton(
                  icon: Icon(Icons.check, color: Colors.teal[700]),
                  onPressed: () {})),
        ),
        Divider(indent: tamanhoTela * 0.05, endIndent: tamanhoTela * 0.05),
      ],
    );
  }
}
