import 'package:flutter/material.dart';

double _tamanhoTela = 0;

class OpcoesComposta extends StatefulWidget {
  OpcoesComposta({Key key}): super(key: key);

  @override
  _OpcoesCompostaState createState() => _OpcoesCompostaState();
}

class _OpcoesCompostaState extends State<OpcoesComposta> {
  @override
  Widget build(BuildContext context) {
    setState(() => _tamanhoTela = MediaQuery.of(context).size.width);
    return Padding(
      padding: EdgeInsets.only(
          left: _tamanhoTela * 0.02, right: _tamanhoTela * 0.02),
      child: Row(
        mainAxisSize     : MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children         : <Widget>[
          FlatButton(
            splashColor   : Colors.blueGrey[50],
            highlightColor: Colors.blueGrey[50],
            shape         : RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_tamanhoTela * 0.02),
            ),
            child: Text(
              "Editar",
              style: TextStyle(
                color: Colors.blueGrey,
              ),
            ),
            onPressed: () {},
          ),
          FlatButton(
            splashColor   : Colors.blue[50],
            highlightColor: Colors.blue[50],
            shape         : RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_tamanhoTela * 0.02),
            ),
            child: Text(
              "Concluir",
              style: TextStyle(color: Colors.blue[400]),
            ),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
