import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:personal_flow/controller/tarefas/composta/controllerComposta.dart';
import 'package:personal_flow/view/home/componentes/agendar.dart';
import 'package:personal_flow/view/home/componentes/composta/opcoesCompost.dart';
import 'package:personal_flow/view/home/componentes/composta/subtarefa.dart';

double _tamanhoTela = 0;
String _tipo = "editar";

class Composta extends StatefulWidget {
  Composta({Key key}) : super(key: key);

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
        elevation: 0.5,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_tamanhoTela * 0.02),
        ),
        child: Container(
            width: _tamanhoTela * 0.95,
            child: ExpandablePanel(
              iconColor: Colors.indigo,
              headerAlignment: ExpandablePanelHeaderAlignment.center,
              header: ListTile(
                title: Text(
                  tarefa,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                onTap: () => modal(context, _tamanhoTela, _tipo, tarefa),
              ),
              collapsed: Container(
                child: barraProgresso(),
              ),
              expanded: Container(
                padding: EdgeInsets.only(
                  top: _tamanhoTela * 0.02,
                ),
                child: Column(
                  children: <Widget>[
                    Agendar(
                      cor: Colors.indigo,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: _tamanhoTela * 0.03,
                        bottom: _tamanhoTela * 0.05
                      ),
                      child: Container(
                        width: _tamanhoTela * 0.9,
                          decoration: BoxDecoration(
                              color: Colors.indigo[50],
                              borderRadius:
                                  BorderRadius.circular(_tamanhoTela * 0.025)),
                          child: geradorCorpo(5, Subtarefa())),
                    ),
                    OpcoesComposta(),
                    barraProgresso(),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
