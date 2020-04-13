import 'package:flutter/material.dart';

class NewTaskComposed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double tamanhoTela = MediaQuery.of(context).size.width;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(tamanhoTela * 0.1),
          ),
          child: Container(
            width: tamanhoTela * 0.8,
            child: Padding(
              padding: EdgeInsets.only(
                  left: tamanhoTela * 0.05, right: tamanhoTela * 0.01),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Título da Tarefa",
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
