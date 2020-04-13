import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
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
        appBar: AppBar(
            title: Padding(
                padding: EdgeInsets.only(
                    top: tamanhoTela * 0.02, bottom: tamanhoTela * 0.03),
                child: Observer(builder: (_) {
                  return Card(
                      elevation: 0,
                      color: appController.colorBarraPesquisa,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(tamanhoTela * 0.1)),
                      child: Row(children: <Widget>[
                        Expanded(
                            child: Padding(
                                padding:
                                    EdgeInsets.only(left: tamanhoTela * 0.04),
                                child: TextField(
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Buscar tarefa")))),
                        barraController.iconBarra,
                      ]));
                }))),
        body: Column(children: <Widget>[
          Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.only(
                    top: tamanhoTela * 0.03,
                    bottom: tamanhoTela * 0.2,
                  ),
                  itemCount: 7,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                        padding: EdgeInsets.only(
                            left: tamanhoTela * 0.01,
                            right: tamanhoTela * 0.01,
                            bottom: tamanhoTela * 0.01),
                        child: index % 2 == 0
                            ? TarefaComposta()
                            : TarefaSimples());
                  }))
        ]),
        floatingActionButton: FloatingActionButton.extended(
            elevation: 5,
            label:
                Text("Adiconar tarefa", style: TextStyle(color: Colors.white)),
            icon: Icon(Icons.playlist_add_check, color: Colors.white),
            backgroundColor: Colors.teal[900],
            onPressed: homeController.navigationNewTask));
  }
}
