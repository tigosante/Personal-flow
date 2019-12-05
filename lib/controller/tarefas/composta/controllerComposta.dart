import 'package:flutter/material.dart';
import 'package:personal_flow/view/home/componentes/composta/barraProgresso.dart';
import 'package:personal_flow/view/home/componentes/composta/editarAdiconarTexto.dart';

List<Widget> geradorLista(quantidade, componente) {
  return List<Widget>.generate(quantidade, (_) => componente);
}

Widget geradorCorpo(quantidade, componente) {
  return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: geradorLista(quantidade, componente));
}

Widget barraProgresso() {
  return BarraProgresso(
    maxValue: 10,
    currentValue: 5,
    progressColor: Colors.blue[300],
  );
}

modal(context, _tamanhoTela, tipo, tarefa) {
  String botao = "";
  String titulo = "";
  String hinText = "";

  switch (tipo) {
    case "adicionar":
      botao = "Adicionar";
      titulo = "Adiconar Subtarefa";
      hinText = "Nova tarefa";
      break;
    case "editar":
      botao = "Salvar";
      titulo = "Editor de título";
      hinText = "Título";
      break;
  }

  showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_tamanhoTela * 0.04),
      ),
      context: context,
      builder: (BuildContext context) => EdiatarAdicionarTexto(
          titulo: titulo, botao: botao, hinText: hinText, tarefa: tarefa));
}

class CheckBoxComposta {
  bool _estado = false;

  bool get estadoGet => _estado;
  set estadoSet(estadoGet) => _estado = !estadoGet;

  mudarEstado() {
    return _estado
        ? Icon(
            Icons.check_circle,
            color: Colors.teal,
          )
        : Icon(
            Icons.check_circle_outline,
            color: Colors.red,
          );
  }
}
