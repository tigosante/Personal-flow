import 'package:flutter/material.dart';
import 'package:personal_flow/controller/geral.dart';

int          _paginaIndex = 0;
double       _tamanhoTela = 0;
String tipo = "novaTarefa";
List<bool>   _selecionada = [true, false];
List<String> _textos      = ["Compostas", "Simples"];

class TipoTarefa extends StatefulWidget {
  TipoTarefa({Key key}): super(key: key);

  @override
  _TipoTarefaState createState() => _TipoTarefaState();
}

class _TipoTarefaState extends State<TipoTarefa> {
  @override
  Widget build(BuildContext context) {
    setState(() => _tamanhoTela = MediaQuery.of(context).size.width);

    return Center(
      child: ToggleButtons(
        isSelected         : _selecionada,
        color              : Colors.grey,
        fillColor          : Colors.indigo[700],
        hoverColor         : Colors.indigo[100],
        focusColor         : Colors.indigo[100],
        splashColor        : Colors.indigo[200],
        borderColor        : Colors.indigo[700],
        selectedColor      : Colors.white,
        disabledColor      : Colors.transparent,
        highlightColor     : Colors.indigo[50],
        disabledBorderColor: Colors.grey,
        selectedBorderColor: Colors.indigo[700],
        borderRadius       : BorderRadius.circular(_tamanhoTela * 0.05),
        children           : gerarBotoesSeletores(2, tipo, _textos),

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
