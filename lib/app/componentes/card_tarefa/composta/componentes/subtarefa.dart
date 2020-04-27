import 'package:flutter/material.dart';
import 'package:personalflow/app/screens/nova_tarefa/widgets/data_hora/data_hora_nova_tarefa.dart';

class Subtarefa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double tamanhoTela = MediaQuery.of(context).size.width;

    return Column(children: <Widget>[
      Padding(
          padding: EdgeInsets.only(top: tamanhoTela * 0.02),
          child: ListTile(
              title: Text("Tarefa",
                  style: TextStyle(
                      fontSize: tamanhoTela * 0.045,
                      fontWeight: FontWeight.bold)),
              subtitle: DataHoraNovaTarefa(),
              trailing: IconButton(
                  icon: Icon(Icons.check, color: Colors.teal[700]),
                  onPressed: () {})))
    ]);
  }
}
