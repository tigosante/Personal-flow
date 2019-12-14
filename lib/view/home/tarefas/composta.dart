import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:personal_flow/controller/geral.dart';
import 'package:personal_flow/controller/composta.dart';
import 'package:personal_flow/view/home/componentes/agendar.dart';
import 'package:personal_flow/view/home/componentes/composta/opcoesCompost.dart';

double _tamanhoTela = 0;
String _tipo        = "editar";

class Composta extends StatefulWidget {
  Composta(
      {Key key, this.titulo, this.subtarefa, this.agendada, this.documentID})
      :  super(key: key);

  String titulo;
  String documentID;
  dynamic subtarefa;
  List<bool> agendada;

  @override
  _CompostaState createState() => _CompostaState();
}

class _CompostaState extends State<Composta> {
  @override
  Widget build(BuildContext context) {
    String tarefa = "Título da tarefa";
    setState(() => _tamanhoTela = MediaQuery.of(context).size.width);

    return Center(
      child: Card(
        elevation   : 5,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape       : RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_tamanhoTela * 0.02),
        ),
        child: Container(
            width: _tamanhoTela * 0.95,
            child: ExpandablePanel(
              iconColor      : Colors.indigo,
              headerAlignment: ExpandablePanelHeaderAlignment.center,
              header         : Padding(
                padding: EdgeInsets.only(
                  top   : _tamanhoTela * 0.01,
                  bottom: _tamanhoTela * 0.01,
                ),
                child: ListTile(
                  title: Text(
                    this.widget.titulo,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  onTap: () => modal(context, _tamanhoTela, _tipo, tarefa),
                ),
              ),
              collapsed: Container(
                child: barraProgresso(Colors.indigo[300]),
              ),
              expanded: Container(
                padding: EdgeInsets.only(
                  top: _tamanhoTela * 0.02,
                ),
                child: Column(
                  children: <Widget>[
                    Agendar(cor: Colors.indigo, agendada: widget.agendada),
                    Padding(
                      padding: EdgeInsets.only(
                          top   : _tamanhoTela * 0.03,
                          bottom: _tamanhoTela * 0.05),
                      child: Container(
                          width     : _tamanhoTela * 0.9,
                          decoration: BoxDecoration(
                              color       : Color.fromRGBO(0, 15, 243, 0.1),
                              borderRadius: 
                                  BorderRadius.circular(_tamanhoTela * 0.025)),
                          child: geradorCorpo(this.widget.documentID)),
                    ),
                    OpcoesComposta(),
                    barraProgresso(Colors.indigo[300]),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
