import 'package:flutter/material.dart';

double _tamanhoTela = 0;

class EdiatarAdicionarTexto extends StatefulWidget {
  EdiatarAdicionarTexto(
      {Key key, this.titulo, this.botao, this.hinText, this.tarefa})
      : super(key: key);

  String botao;
  String titulo;
  String tarefa;
  String hinText;

  @override
  _EdiatarAdicionarTextoState createState() => _EdiatarAdicionarTextoState();
}

class _EdiatarAdicionarTextoState extends State<EdiatarAdicionarTexto> {
  @override
  Widget build(BuildContext context) {
    TextEditingController controllerText =
        TextEditingController(text: this.widget.tarefa);
    setState(() => _tamanhoTela = MediaQuery.of(context).size.width);

    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              top: _tamanhoTela * 0.04,
              bottom: _tamanhoTela * 0.05,
            ),
            child: Text(
              widget.titulo,
              style: TextStyle(
                fontSize: _tamanhoTela * 0.035,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: _tamanhoTela * 0.05,
              right: _tamanhoTela * 0.05,
              bottom: _tamanhoTela * 0.03,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: TextField(
                      controller: controllerText,
                      decoration: InputDecoration(
                        hintText: widget.hinText,
                        border: InputBorder.none,
                      )),
                ),
                RaisedButton(
                  elevation: 0,
                  color: Colors.teal[300],
                  splashColor: Colors.teal[400],
                  highlightColor: Colors.teal[400],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(_tamanhoTela * 0.02),
                  ),
                  child: Text(
                    widget.botao,
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
