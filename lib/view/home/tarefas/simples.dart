import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:personal_flow/controller/geral.dart';
import 'package:personal_flow/view/componentes/tarefasController.dart';
import 'package:personal_flow/view/home/componentes/agendar.dart';
import 'package:personal_flow/view/home/componentes/composta/dateHora.dart';
import 'package:provider/provider.dart';

double _tamanhoTela = 0;

String _tipo = "editar";
String _tarefa = "Tarefa";

class Simples extends StatefulWidget {
  Simples({Key key, this.titulo, this.data, this.hora, this.agendada}) : super(key: key);

  String titulo;
  String data;
  String hora;
  List<bool> agendada;
  @override
  _SimplesState createState() => _SimplesState();
}

class _SimplesState extends State<Simples> {
  @override
  Widget build(BuildContext context) {
    setState(() => _tamanhoTela = MediaQuery.of(context).size.width);

    return Consumer<TarefasController>(
        builder: (context, tarefasController, widget) {
      tarefasController.popular();
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
              header: ListTile(
                title: Text(
                  this.widget.titulo,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                subtitle: DataHora(
                  data: this.widget.data,
                  hora: this.widget.hora,
                ),
                onTap: () => modal(context, _tamanhoTela, _tipo, this.widget.titulo),
              ),
              expanded: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Agendar(cor: Colors.indigo, agendada: this.widget.agendada,),
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
    });
  }
}
