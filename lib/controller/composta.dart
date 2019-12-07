import 'package:flutter/material.dart';
import 'package:personal_flow/controller/geral.dart';
import 'package:personal_flow/view/home/componentes/composta/barraProgresso.dart';

Widget geradorCorpo(int quantidade, Widget componente) {
  return Column(
      mainAxisSize      : MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children          : geradorLista(quantidade, componente));
}

Widget barraProgresso(Color cor) {
  return BarraProgresso(
    maxValue     : 10,
    currentValue : 5,
    progressColor: cor,
  );
}

class CheckBoxComposta {
  bool _estado = false;

  bool get estadoGet        => _estado;
  set  estadoSet(estadoGet) => _estado = !estadoGet;

  Icon mudarEstado() {
    return _estado
        ? Icon(
            Icons.check_circle,
            color: Colors.indigo,
          )
        : Icon(
            Icons.panorama_fish_eye,
            color: Colors.indigo[300],
          );
  }
}
