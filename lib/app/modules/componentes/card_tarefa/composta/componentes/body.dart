import 'package:flutter/material.dart';

import 'subtarefa.dart';

class BodyComposta extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double tamanhoTela = MediaQuery.of(context).size.width;
    int number = 0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [0, 1, 2].map((int index) {
        number++;
        Color cor;

        if (number == 1) {
          cor = Colors.indigo.withOpacity(0.2);
        } else if (number == 2) {
          cor = Colors.red.withOpacity(0.2);
        } else {
          cor = Colors.teal.withOpacity(0.2);
          number = 0;
        }

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
            child: Subtarefa(),
          ),
        );
      }).toList(),
    );
  }
}
