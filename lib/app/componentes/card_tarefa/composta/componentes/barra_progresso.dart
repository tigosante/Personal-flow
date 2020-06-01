import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:personalflow/core/models/composta_model.dart';

class BarraProgresso extends StatelessWidget {
  BarraProgresso({Key key, this.tamanhoTela, this.data, this.max})
      : super(key: key);

  final int max;
  final dynamic data;
  final double tamanhoTela;

  @override
  Widget build(BuildContext context) => Padding(
      padding:
          EdgeInsets.only(top: tamanhoTela * 0.01, bottom: tamanhoTela * 0.03),
      child: FAProgressBar(
          maxValue: max ?? 0,
          currentValue: _concluidas(),
          progressColor: Colors.indigo[600],
          backgroundColor: Colors.transparent));

  int _concluidas() {
    int tamanho = 0;
    for (Subtarefa subtarefa in data) {
      if (subtarefa.check) tamanho++;
    }
    return tamanho;
  }
}
