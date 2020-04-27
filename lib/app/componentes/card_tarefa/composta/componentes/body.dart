import 'package:flutter/material.dart';
import 'package:personalflow/core/model/composta/model.dart';

import 'subtarefa.dart';

class BodyComposta extends StatelessWidget {
  BodyComposta({Key key, this.data}) : super(key: key);
  final dynamic data;

  int number = 0;
  double tamanhoTela;

  @override
  Widget build(BuildContext context) {
    tamanhoTela = MediaQuery.of(context).size.width;
    return Column(
        mainAxisSize: MainAxisSize.min,
        children: data.map<Widget>((Subtarefa subtarefa) {
          Color cor = _color();

          return Padding(
              padding: EdgeInsets.only(
                  top: tamanhoTela * 0.01,
                  left: tamanhoTela * 0.02,
                  right: tamanhoTela * 0.02,
                  bottom: tamanhoTela * 0.001),
              child: Container(
                decoration: BoxDecoration(
                    color: cor,
                    borderRadius:
                        BorderRadius.all(Radius.circular(tamanhoTela * 0.06))),
                child: SubtarefaWidget(subtarefa: subtarefa),
              ));
        }).toList());
  }

  Color _color() {
    number++;

    if (number == 1)
      return Colors.indigo.withOpacity(0.2);
    else if (number == 2)
      return Colors.red.withOpacity(0.2);
    else {
      number = 0;
      return Colors.teal.withOpacity(0.2);
    }
  }
}
