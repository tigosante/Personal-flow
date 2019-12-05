import 'package:flutter/material.dart';
import 'package:personal_flow/view/DrawerPainel.dart';
import 'package:personal_flow/view/componentes/barraNavegacao.dart';
import 'package:personal_flow/view/grafico/grafico.dart';
import 'package:personal_flow/view/home/home.dart';

int          _paginaIndex = 0;
List<Widget> _pagina      = [Home(), Grafico()];

String titulo = "Tarefas";

Color bola      = Colors.amber[700];
Color barra     = Colors.blue[700];
Color aciton    = Colors.blue[900];
Color drawer    = Colors.blue[700];
Color appbar    = Colors.blue[500];
Color tarefa    = Colors.black;
Color grafico   = Colors.white;
Color corTitulo = Colors.amber[900];

class Telas extends StatefulWidget {
  Telas({Key key}): super(key: key);

  @override
  _TelasState createState() => _TelasState();
}

class _TelasState extends State<Telas> {
  @override
  Widget build(BuildContext context) {
    setState(() {
      if (_paginaIndex == 0) {
        titulo    = "Tarefas";
        bola      = Colors.amber[700];
        barra     = Colors.blue[700];
        aciton    = Colors.blue[900];
        drawer    = Colors.blue[200];
        appbar    = Colors.blue[200];
        tarefa    = Colors.black;
        grafico   = Colors.white;
        corTitulo = Colors.blue[800];
      } else {
        titulo    = "Gráfico";
        bola      = Colors.blue[700];
        barra     = Colors.amber[700];
        aciton    = Colors.amber[900];
        drawer    = Colors.amber[200];
        appbar    = Colors.amber[200];
        tarefa    = Colors.black;
        grafico   = Colors.white;
        corTitulo = Colors.amber[900];
      }
    });
    return Scaffold(
      drawerScrimColor: drawer,
      endDrawer       : Drawer(
        elevation: 0,
        child    : DrawerPainel(),
      ),
      appBar: AppBar(
        elevation       : 0,
        backgroundColor : appbar,
        actionsIconTheme: IconThemeData(color: aciton),
        title           : Text(
          titulo,
          style: TextStyle(color: corTitulo),
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
        color                : barra,
        backgroundColor      : Colors.white,
        buttonBackgroundColor: bola,
        items                : <Widget>[
          Icon(
            Icons.list,
            color: tarefa,
          ),
          Icon(
            Icons.format_line_spacing,
            color: grafico,
          ),
        ],
        onTap: (index) => setState(() => _paginaIndex = index),
      ),
    );
  }
}
