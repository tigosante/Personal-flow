import 'package:flutter/material.dart';

int _paginaIndex = 0;
bool   _selecionada = true;
double _tamanhoTela = 0;

class TipoTarefa extends StatefulWidget {
  TipoTarefa({Key key, this.tipo}): super(key: key);

  int tipo;

  @override
  _TipoTarefaState createState() => _TipoTarefaState();
}

class _TipoTarefaState extends State<TipoTarefa> {
  @override
  Widget build(BuildContext context) {
    setState((){
      _tamanhoTela = MediaQuery.of(context).size.width;
      _paginaIndex = widget.tipo;
    });

    return Center(
      child: Card(
        elevation   : 0,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape       : RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_tamanhoTela * 0.05),
        ),
        child: Container(
          width     : _tamanhoTela * 0.8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(_tamanhoTela * 0.05),
            border      : Border.all(color: Colors.indigo, width: _tamanhoTela * 0.002),
          ),
          child: Row(
            mainAxisSize     : MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children         : <Widget>[
              InkWell(
                splashColor   : Colors.indigo[50],
                highlightColor: Colors.indigo[50],
                child         : Container(
                  padding: EdgeInsets.only(
                    top   : _tamanhoTela * 0.03,
                    left  : _tamanhoTela * 0.05,
                    right : _tamanhoTela * 0.05,
                    bottom: _tamanhoTela * 0.03,
                  ),
                  color: _selecionada ? Colors.indigo: Colors.transparent,
                  width: _tamanhoTela * 0.398,
                  child: Center(
                    child: Text(
                      "Composta",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color     : _selecionada ? Colors.white: Colors.grey,
                      ),
                    ),
                  ),
                ),
                onTap: () => setState(() => _selecionada = !(_paginaIndex == 0)),
              ),
              InkWell(
                splashColor   : Colors.indigo[50],
                highlightColor: Colors.indigo[50],
                child         : Container(
                  padding: EdgeInsets.only(
                    top   : _tamanhoTela * 0.03,
                    left  : _tamanhoTela * 0.05,
                    right : _tamanhoTela * 0.05,
                    bottom: _tamanhoTela * 0.03,
                  ),
                  color: _selecionada ? Colors.transparent: Colors.indigo,
                  width: _tamanhoTela * 0.398,
                  child: Center(
                    child: Text(
                      "Simples",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color     : _selecionada ? Colors.grey: Colors.white,
                      ),
                    ),
                  ),
                ),
                onTap: () => setState((){
                  _selecionada = _paginaIndex == 1;
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
