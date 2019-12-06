import 'package:flutter/material.dart';
import 'package:personal_flow/view/home/componentes/composta/barraProgresso.dart';
import 'package:personal_flow/view/home/componentes/composta/editarAdiconarTexto.dart';
import 'package:personal_flow/view/home/componentes/dias.dart';

List<Widget> geradorTarefas(quantidade, tela) {
  return List<Widget>.generate(quantidade, (item)=> item % 2 == 0 ? tela[0] : tela[1]);
}

List<Widget> geradorLista(quantidade, componente) {
  return List<Widget>.generate(quantidade, (_) => componente);
}

List<Widget> geradorListaDias(cor) {
  List<String> dias = [
    " Dom ",
    "  Seg  ",
    "  Ter  ",
    "  Qua  ",
    "  Qui  ",
    "  Sex  ",
    "  Sáb  "
  ];

  return List<Widget>.generate(7, (dia) => Dias(dias: dias[dia], cor: cor));
}

List<Widget> geradorNovaComposta(quantidade, componente) {
  return List<Widget>.generate(quantidade, (_) => componente);
}

List<Widget> geradorBotoes(_tamanhoTela, quantidade) {
  List<String>      _title = ["Excluir", "Concluir"];
  List<List<Color>> _cores = [[Colors.red[50], Colors.red], [Colors.blue[50], Colors.blue]];

  if(quantidade == 4){
    _title = ["Excluir", "Add tarefa", "Editar", "Concluir"];

    _cores = [
      [Colors.red[50],    Colors.red],
      [Colors.teal[50],   Colors.teal],
      [Colors.orange[50], Colors.orange],
      [Colors.blue[50],   Colors.blue]
    ];
  }

  return List<Widget>.generate(
      quantidade,
      (botao) => FlatButton(
            splashColor   : _cores[botao][0],
            highlightColor: _cores[botao][0],
            shape         : RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_tamanhoTela * 0.02),
            ),
            child: Text(
              _title[botao],
              style: TextStyle(
                color: _cores[botao][1],
              ),
            ),
            onPressed: () {},
          ));
}

Widget geradorCorpo(quantidade, componente) {
  return Column(
      mainAxisSize      : MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children          : geradorLista(quantidade, componente));
}

Widget barraProgresso() {
  return BarraProgresso(
    maxValue     : 10,
    currentValue : 5,
    progressColor: Colors.indigo[300],
  );
}

modal(context, _tamanhoTela, tipo, tarefa) {
  String botao   = "";
  String titulo  = "";
  String hinText = "";

  switch (tipo) {
    case "adicionar": 
      botao   = "Adicionar";
      titulo  = "Adiconar Subtarefa";
      hinText = "Nova tarefa";
      break;
    case "editar": 
      botao   = "Salvar";
      titulo  = "Editor de título";
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

  bool get estadoGet        => _estado;
  set  estadoSet(estadoGet) => _estado = !estadoGet;

  mudarEstado() {
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
