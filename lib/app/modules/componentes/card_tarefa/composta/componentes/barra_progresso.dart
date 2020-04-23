import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

class BarraProgresso extends StatelessWidget {
  BarraProgresso({Key key, this.tamanhoTela}) : super(key: key);

  final double tamanhoTela;

  @override
  Widget build(BuildContext context) => Padding(
      padding:
          EdgeInsets.only(top: tamanhoTela * 0.01, bottom: tamanhoTela * 0.03),
      child: FAProgressBar(
          currentValue: 80,
          progressColor: Colors.indigo[600],
          backgroundColor: Colors.transparent));
}
