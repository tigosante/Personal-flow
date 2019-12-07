import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:personal_flow/controller/geral.dart';
import 'package:personal_flow/view/home/componentes/agendar.dart';
import 'package:personal_flow/view/home/componentes/composta/dateHora.dart';

double _tamanhoTela = 0;

String _tipo   = "editar";
String _tarefa = "Tarefa";

class Simples extends StatefulWidget {
  Simples({Key key}): super(key: key);

  @override
  _SimplesState createState() => _SimplesState();
}

class _SimplesState extends State<Simples> {
  @override
  Widget build(BuildContext context) {
    setState(() => _tamanhoTela = MediaQuery.of(context).size.width);
    return Center(
      child: Card(
        elevation   : 0.5,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape       : RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_tamanhoTela * 0.02),
        ),
        child: Container(
          width: _tamanhoTela * 0.95,
          child: ExpandablePanel(
            iconColor: Colors.indigo,
            header   : ListTile(
              title: Text(
                _tarefa,
                style: TextStyle(
                  fontWeight: FontWeight.w500
                ),
              ),
              subtitle: DataHora(),
              onTap   : () => modal(context, _tamanhoTela, _tipo, _tarefa),
            ),
            expanded: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Agendar(cor: Colors.indigo),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: geradorBotoes(_tamanhoTela, 2, context),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
