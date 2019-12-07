import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_flow/view/home/componentes/composta/editarAdiconarTexto.dart';
import 'package:personal_flow/view/home/componentes/dias.dart';

List<Widget> geradorTarefas(int quantidade, List<Widget> tela) {
  return List<Widget>.generate(
      quantidade, (item) => item % 2 == 0 ? tela[0] : tela[1]);
}

List<Widget> geradorLista(quantidade, componente) {
  return List<Widget>.generate(quantidade, (_) => componente);
}

List<Widget> geradorListaDias(cor) {
  List<String> dias = [
    " Dom "
    ,"  Seg  "
    ,"  Ter  "
    ,"  Qua  "
    ,"  Qui  "
    ,"  Sex  "
    ,"  Sáb  "
  ];

  return List<Widget>.generate(7, (dia) => Dias(dias: dias[dia], cor: cor));
}

List<Widget> geradorBotoes(double _tamanhoTela, int quantidade, BuildContext context) {
  List<String>      _title = ["Excluir", "Concluir"];
  List<List<Color>> _cores = [
    [Colors.red[50], Colors.red],
    [Colors.blue[50], Colors.blue]
  ];

  if (quantidade == 3) {
    _title = ["Adicionar tarefa", "Excluir", "Concluir"];

    _cores = [
      [Colors.teal[50], Colors.teal]
      ,[Colors.red[50], Colors.red]
      ,[Colors.blue[50], Colors.blue]
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
            onPressed: (){},
          ));
}

Widget tituloPaginas(String _tipo, double _tamanhoTela) {
  Color _cor;
  String _titulo;
  Widget _trailing = Container();

  switch (_tipo) {
    case "tarefas": 
      _titulo   = "Tarefas";
      _cor      = Colors.blue[800];
      _trailing = IconButton(
        icon     : Icon(Icons.search, color: Colors.blue[800]),
        onPressed: () {},
      );
      break;

    case "grafico": 
      _titulo   = "Gráfico";
      _cor      = Colors.amber[800];
      _trailing = IconButton(
        icon     : Icon(Icons.more_horiz, color: Colors.amber[800]),
        onPressed: () {},
      );
      break;
  }

  return Padding(
    padding: EdgeInsets.only(
      top   : _tamanhoTela * 0.07,
      bottom: _tamanhoTela * 0.02,
    ),
    child: ListTile(
      title: Text(
        _titulo,
        style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize  : _tamanhoTela * 0.05,
            color     : _cor),
      ),
      trailing: _trailing,
    ),
  );
}

modal(BuildContext context, double _tamanhoTela, String tipo, String tarefa) {
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
