import 'package:flutter/material.dart';
import 'package:personalflow/app/modules/componentes/data_hora/data_hora.dart';

class TarefaSimples extends StatelessWidget {
  final String title;
  final bool check;

  TarefaSimples({this.title, this.check});

  @override
  Widget build(BuildContext context) {
    double tamanhoTela = MediaQuery.of(context).size.width;

    return Card(
        elevation: 0,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(tamanhoTela * 0.05)),
        child: ListTile(
            title: Padding(
                padding: EdgeInsets.only(
                    top: tamanhoTela * 0.03, left: tamanhoTela * 0.015),
                child: Text(title,
                    style: TextStyle(
                        fontSize: tamanhoTela * 0.045,
                        fontWeight: FontWeight.bold))),
            subtitle: DataHora(),
            trailing: IconButton(
                icon: Icon(check ? Icons.check : Icons.radio_button_unchecked,
                    color: Colors.teal[700]),
                onPressed: () {})));
  }
}
