import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:personalflow/app/modules/componentes/barra_pesquisa/barra_pesquisa.dart';
import 'package:personalflow/app/modules/componentes/barra_pesquisa/barra_pesquisa_controller.dart';
import 'package:personalflow/app/modules/componentes/card_tarefa/composta/tarefa_composta.dart';
import 'package:personalflow/app/modules/componentes/card_tarefa/simples/tarefa_simples.dart';
import '../../app_controller.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final appController = Modular.get<AppController>();
  final homeController = Modular.get<HomeController>();
  final barraController = Modular.get<BarraPesquisaController>();

  @override
  Widget build(BuildContext context) {
    double tamanhoTela = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(title: BarraPesquisa()),
        body: Center(
            child: Container(
                width: tamanhoTela * 0.9,
                child: ListView.builder(
                    padding: EdgeInsets.only(
                      top: tamanhoTela * 0.03,
                      bottom: tamanhoTela * 0.2,
                    ),
                    itemCount: 3,
                    itemBuilder: (BuildContext _, int index) =>
                        index % 2 == 0 ? TarefaComposta() : TarefaSimples()))),
        floatingActionButton: FloatingActionButton.extended(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(tamanhoTela * 0.05)),
            label:
                Text("Adiconar tarefa", style: TextStyle(color: Colors.black)),
            icon: Icon(Icons.playlist_add_check, color: Colors.black),
            splashColor: Colors.red.withOpacity(0.2),
            highlightElevation: 0,
            elevation: 0,
            onPressed: homeController.navigationNewTask));
  }
}
