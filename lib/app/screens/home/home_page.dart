import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:personalflow/app/componentes/barra_pesquisa/barra_pesquisa.dart';
import 'package:personalflow/app/componentes/barra_pesquisa/barra_pesquisa_controller.dart';
import '../../app_controller.dart';
import 'home_controller.dart';

class HomePage extends StatelessWidget {
  final appController = Modular.get<AppController>();
  final homeController = Modular.get<HomeController>();
  final barraController = Modular.get<BarraPesquisaController>();

  @override
  Widget build(BuildContext context) {
    double tamanhoTela = MediaQuery.of(context).size.width;

    return DefaultTabController(
      initialIndex: 0,
      length: homeController.pages.length,
      child: Scaffold(
          appBar: AppBar(
              title: BarraPesquisa(),
              bottom: TabBar(
                  onTap: homeController.changeTela,
                  indicatorColor: Colors.indigo,
                  labelColor: Colors.indigo,
                  isScrollable: true,
                  tabs: homeController.pages
                      .map((page) => Tab(text: page.tabTitle))
                      .toList())),
          body: Observer(
              builder: (_) =>
                  homeController.pages[homeController.telaAtual].body),
          floatingActionButton: FloatingActionButton.extended(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(tamanhoTela * 0.05)),
              label: Text("Adiconar tarefa",
                  style: TextStyle(color: Colors.white)),
              icon: Icon(Icons.playlist_add_check, color: Colors.white),
              splashColor: Colors.red.withOpacity(0.2),
              highlightElevation: 0,
              elevation: 0,
              onPressed: homeController.navigationNewTask)),
    );
  }
}
