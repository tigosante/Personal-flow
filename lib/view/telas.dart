import 'package:flutter/material.dart';
import 'package:personal_flow/view/DrawerPainel.dart';
import 'package:personal_flow/view/componentes/barraNavegacao.dart';
import 'package:personal_flow/view/grafico/grafico.dart';
import 'package:personal_flow/view/home/home.dart';

int          _paginaIndex = 0;
List<Widget> _pagina      = [Home(), Grafico()];

double _tamanhoTela = 0;


Color _bola    = Colors.amber[800];
Color _barra   = Colors.indigo[800];
Color _aciton  = Colors.indigo[900];
Color _tarefa  = Colors.black;
Color _grafico = Colors.white;

dynamic _iconeEsquerda = Icon(
  Icons.list,
  color: _tarefa,
);

dynamic _iconeDireita = CircleAvatar(
  child: Icon(
    Icons.list,
    color: _tarefa,
  ),
  backgroundColor: _barra,
);

class Telas extends StatefulWidget {
  Telas({Key key}): super(key: key);

  @override
  _TelasState createState() => _TelasState();
}

class _TelasState extends State<Telas> {
  @override
  Widget build(BuildContext context) {
    setState(() {
      _tamanhoTela = MediaQuery.of(context).size.width;

      if (_paginaIndex == 0) {
        _bola    = Colors.amber[800];
        _barra   = Colors.indigo[800];
        _aciton  = Colors.indigo[900];
        _tarefa  = Colors.white;
        _grafico = Colors.white;

        _iconeEsquerda = Icon(
          Icons.list,
          color: _tarefa,
        );

        _iconeDireita = _iconeDireita = CircleAvatar(
          child: Icon(
            Icons.format_line_spacing,
            color: _bola,
          ),
          backgroundColor: _grafico,
        );
      } else {
        _bola    = Colors.indigo[800];
        _barra   = Colors.amber[800];
        _aciton  = Colors.amber[900];
        _tarefa  = Colors.white;
        _grafico = Colors.white;

        _iconeEsquerda = _iconeDireita = CircleAvatar(
          child: Icon(
            Icons.list,
            color: _bola,
          ),
          backgroundColor: _grafico,
        );

        _iconeDireita = Icon(
          Icons.format_line_spacing,
          color: _tarefa,
        );
      }
    });

    return Scaffold(
      backgroundColor: Colors.grey[50],
      drawer         : Drawer(
        elevation: 0,
        child    : DrawerPainel(),
      ),
      body: PageView.builder(
        controller   : PageController(initialPage: 0),
        itemCount    : _pagina.length,
        itemBuilder  : (BuildContext context, int index) => _pagina[_paginaIndex],
        onPageChanged: (index) => setState(() => _paginaIndex = index),
      ),
      bottomNavigationBar: BarraNavegacao(
        index                : _paginaIndex,
        color                : _barra,
        height               : _tamanhoTela * 0.13,
        backgroundColor      : _barra,
        buttonBackgroundColor: _bola,
        items                : <Widget>[
          _iconeEsquerda,
          _iconeDireita,
        ],
        onTap: (index) => setState(() => _paginaIndex = index),
      ),

    );
  }
}
