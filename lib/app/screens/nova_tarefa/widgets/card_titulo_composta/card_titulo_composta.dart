import 'package:flutter/material.dart';
import 'package:personalflow/app/screens/nova_tarefa/widgets/data_hora/data_hora_nova_tarefa.dart';

class CardTituloComposta extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double tamanhoTela = MediaQuery.of(context).size.width;

    return Container(
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
                subtitle: DataHoraNovaTarefa())));
  }
}
