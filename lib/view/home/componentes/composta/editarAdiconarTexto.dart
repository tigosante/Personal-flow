import 'package:flutter/material.dart';

double _tamanhoTela = 0;

class EdiatarAdicionarTexto extends StatefulWidget {
  EdiatarAdicionarTexto(
      {Key key, this.titulo, this.botao, this.hinText, this.tarefa})
      :  super(key: key);

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
        children    : <Widget>[
          Padding(
            padding: EdgeInsets.only(
              top   : _tamanhoTela * 0.04,
              bottom: _tamanhoTela * 0.05,
            ),
            child: Text(
              widget.titulo,
              style: TextStyle(
                color: Colors.indigo[400],
                fontSize  : _tamanhoTela * 0.04,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left  : _tamanhoTela * 0.05,
              right : _tamanhoTela * 0.05,
              bottom: _tamanhoTela * 0.03,
            ),
            child: Row(
              mainAxisSize     : MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children         : <Widget>[
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.indigo[50],
                            width: _tamanhoTela * 0.004),
                        borderRadius: 
                            BorderRadius.circular(_tamanhoTela * 0.04)),
                    child: Padding(
                      padding: EdgeInsets.only(left: _tamanhoTela * 0.025),
                      child  : TextField(
                          controller: controllerText,
                          decoration: InputDecoration(
                            hintText: widget.hinText,
                            border  : InputBorder.none,
                          )),
                    ),
                  ),
                ),
                SizedBox(
                  width: _tamanhoTela * 0.05,
                ),
                RaisedButton(
                  elevation     : 0,
                  color         : Colors.indigo[300],
                  splashColor   : Colors.indigo[400],
                  highlightColor: Colors.indigo[400],
                  shape         : RoundedRectangleBorder(
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
