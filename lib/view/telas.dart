import 'package:flutter/material.dart';
import 'package:personal_flow/view/DrawerPainel.dart';
import 'package:personal_flow/view/componentes/barraNavegacao.dart';
import 'package:personal_flow/view/grafico/grafico.dart';
import 'package:personal_flow/view/home/home.dart';

int          _paginaIndex = 0;
List<Widget> _pagina      = [Home(), Grafico()];

double _tamanhoTela = 0;

String titulo = "Tarefas";

Color _bola    = Colors.amber[800];
Color _barra   = Colors.indigo[800];
Color _aciton  = Colors.indigo[900];
Color _appbar  = Colors.indigo[800];
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
        titulo   = "Tarefas";
        _bola    = Colors.amber[800];
        _barra   = Colors.indigo[800];
        _aciton  = Colors.indigo[900];
        _appbar  = Colors.indigo[800];
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
        titulo   = "Gráfico";
        _bola    = Colors.indigo[800];
        _barra   = Colors.amber[800];
        _aciton  = Colors.amber[900];
        _appbar  = Colors.amber[800];
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
      appBar: AppBar(
        elevation       : 0,
        backgroundColor : Colors.transparent,
        iconTheme: IconThemeData(color: _aciton),
        actions: <Widget>[
          _paginaIndex == 0 ?IconButton(
            icon: Icon(Icons.search),
            onPressed: (){},
          ) : Container(color: Colors.transparent,)
        ],
        title           : Text(
          titulo,
          style: TextStyle(color: _appbar),
        ),
      ),
      body: PageView.builder(
        controller   : PageController(initialPage: _paginaIndex),
        itemCount    : _pagina.length,
        itemBuilder  : (BuildContext context, int index) => _pagina[_paginaIndex],
        onPageChanged: (index) => setState(() => _paginaIndex = index),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index                : _paginaIndex,
        color                : _barra,
        height               : _tamanhoTela * 0.15,
        backgroundColor      : Colors.white,
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
