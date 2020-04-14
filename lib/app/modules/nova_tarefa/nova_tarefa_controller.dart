import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'nova_tarefa_controller.g.dart';

class NovaTarefaController = _NovaTarefaControllerBase
    with _$NovaTarefaController;

abstract class _NovaTarefaControllerBase with Store {
  @observable
  bool selectValue0 = true;

  @observable
  bool selectValue1 = false;

  @observable
  Color colorItemSelect0 = Colors.indigo[700];

  @observable
  Color colorItemSelect1 = Colors.grey.withOpacity(0.2);

  @observable
  Color colorText0 = Colors.white;

  @observable
  Color colorText1 = Colors.black;

  Color colorSelect = Colors.indigo[700];
  Color colorNoSelect = Colors.grey.withOpacity(0.2);

  Color colorTextSelec = Colors.white;
  Color colorTextNoSelec = Colors.black;

  @observable
  int indexPage = 0;

  @observable
  List<Subatarefas> subtarefas = <Subatarefas>[Subatarefas(title: "Tarefa")];

  @observable
  PageController pageController =
      PageController(initialPage: 0, keepPage: true);

  @action
  void changeTask(int index) {
    indexPage = index;
    pageController.animateToPage(index,
        duration: Duration(milliseconds: 500), curve: Curves.ease);
  }
}

class Subatarefas {
  final String title;

  Subatarefas({this.title});
}
