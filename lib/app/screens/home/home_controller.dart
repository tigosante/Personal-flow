import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:personalflow/app/screens/home/pages/composta/composta_page.dart';
import 'package:personalflow/app/screens/home/pages/simples/simples_page.dart';
import 'package:personalflow/app/screens/nova_tarefa/nova_tarefa_controller.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  int oldTela;

  @observable
  int telaAtual = 0;

  @observable
  List<Pages> pages = <Pages>[
    Pages(tabTitle: 'Simples', body: SimplesPage()),
    Pages(tabTitle: 'Composta', body: CompostaPage()),
  ];

  @action
  void changeTela(int tela) {
    if (tela != oldTela) {
      telaAtual = tela;
      oldTela = tela;
    }
  }

  @action
  void navigationNewTask() {
    Modular.get<NovaTarefaController>().indexPage = 0;
    Modular.get<NovaTarefaController>().cSimples.text = "";
    Modular.to.pushNamed("/adicionar_tarefa");
  }
}

class Pages {
  Pages({
    this.tabTitle,
    this.body,
  });

  final dynamic tabTitle;
  final Widget body;
}
