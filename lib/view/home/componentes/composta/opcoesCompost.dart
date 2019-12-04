import 'package:flutter/material.dart';

double _tamanhoTela = 0;

class OpcoesComposta extends StatefulWidget {
  OpcoesComposta({Key key}) : super(key: key);

  @override
  _OpcoesCompostaState createState() => _OpcoesCompostaState();
}

class _OpcoesCompostaState extends State<OpcoesComposta> {
  @override
  Widget build(BuildContext context) {
    setState(() => _tamanhoTela = MediaQuery.of(context).size.width);
    return Padding(
      padding: EdgeInsets.only(
        top: _tamanhoTela * 0.03,
        left: _tamanhoTela * 0.02,
        right: _tamanhoTela * 0.02
      ),
      child: Row(
         mainAxisSize: MainAxisSize.max,
         mainAxisAlignment: MainAxisAlignment.end,
         children: <Widget>[
           FlatButton(
            splashColor: Colors.amber[200],
            highlightColor: Colors.amber[200],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_tamanhoTela * 0.02),
            ),
            child: Text(
              "Editar",
              style: TextStyle(
                color: Colors.amber[700],
              ),
            ),
            onPressed: (){},
           ),
           RaisedButton(
            splashColor: Colors.teal[300],
            highlightColor: Colors.teal[300],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_tamanhoTela * 0.02),
            ),
            elevation: 1,
            color: Colors.teal,
            child: Text(
              "Concluir",
              style: TextStyle(
                color: Colors.white
              ),
            ),
            onPressed: (){},
           )
         ],
      ),
    );
  }
}