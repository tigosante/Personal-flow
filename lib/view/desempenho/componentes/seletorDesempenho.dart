import 'package:flutter/material.dart';
import 'package:personal_flow/controller/geral.dart';
import 'package:personal_flow/view/componentes/botoes.dart';

int          _paginaIndex = 0;
double       _tamanhoTela = 0;
String tipo = "desempenho";
List<bool>   _selecionada = [true, false, false];
List<String> _textos      = ["Data", "Tarefas Simples", "Tarefas Compostas"];

class Seletor extends StatefulWidget {
  Seletor({Key key}): super(key: key);

  @override
  _SeletorState createState() => _SeletorState();
}

class _SeletorState extends State<Seletor> {
  @override
  Widget build(BuildContext context) {
    setState(() => _tamanhoTela = MediaQuery.of(context).size.width);

    return Padding(
      padding: EdgeInsets.only(
        bottom: _tamanhoTela * 0.03
      ),
      child: ToggleButtons(
        isSelected         : _selecionada,
        color              : Colors.grey,
        fillColor          : Colors.amber[700],
        hoverColor         : Colors.amber[100],
        focusColor         : Colors.amber[100],
        splashColor        : Colors.amber[200],
        borderColor        : Colors.amber[700],
        selectedColor      : Colors.white,
        disabledColor      : Colors.transparent,
        highlightColor     : Colors.amber[50],
        disabledBorderColor: Colors.grey,
        selectedBorderColor: Colors.amber[700],
        borderRadius       : BorderRadius.circular(_tamanhoTela * 0.05),
        children           : gerarBotoesSeletores(3, tipo, _textos),

        onPressed: (int item) => setState(() {
          for (int i = 0; i < _selecionada.length; i++) {
            _selecionada[i] = false;
          }
          _selecionada[item] = true;
        }),
      ),
    );
  }
}
