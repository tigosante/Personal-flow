import 'package:flutter/material.dart';

import '../../../data_hora/data_hora.dart';

class Subtarefa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double tamanhoTela = MediaQuery.of(context).size.width;

    return ListTile(
      title: Text("Tarefa", style: TextStyle(fontSize: tamanhoTela * 0.045)),
      subtitle: DataHora(),
      trailing: IconButton(icon: Icon(Icons.camera), onPressed: () {}),
      onTap: () {},
    );
  }
}
