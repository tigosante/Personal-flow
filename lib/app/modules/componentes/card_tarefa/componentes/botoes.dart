import 'package:flutter/material.dart';

class BotoesTarefa extends StatelessWidget {
  BotoesTarefa({Key key, this.tamanhoTela}) : super(key: key);

  final double tamanhoTela;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: tamanhoTela * 0.03,
        left: tamanhoTela * 0.01,
        right: tamanhoTela * 0.01,
        bottom: tamanhoTela * 0.02,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          {
            "title": "Nova tarefa",
            "color": Colors.indigo[600],
            "splash": Color.fromRGBO(56, 72, 171, 0.1)
          },
          {
            "title": "Apagar",
            "color": Colors.red[600],
            "splash": Color.fromRGBO(229, 56, 53, 0.1)
          },
          {
            "title": "Concluir",
            "color": Colors.teal[600],
            "splash": Color.fromRGBO(0, 137, 123, 0.1)
          },
        ].map((value) {
          return FlatButton(
            splashColor: value["splash"],
            color: value["splash"],
            child: Container(
                width: tamanhoTela * 0.2,
                height: tamanhoTela * 0.09,
                child: Center(
                    child: Text(value["title"],
                        style: TextStyle(color: value["color"])))),
            onPressed: () {},
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(tamanhoTela * 0.03)),
          );
        }).toList(),
      ),
    );
  }
}
