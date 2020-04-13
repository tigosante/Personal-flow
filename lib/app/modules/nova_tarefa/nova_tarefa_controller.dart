import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import 'componentes/new_task_composed/new_task_composed.dart';
import 'componentes/new_task_simple/new_task_simple.dart';

part 'nova_tarefa_controller.g.dart';

class NovaTarefaController = _NovaTarefaControllerBase
    with _$NovaTarefaController;

abstract class _NovaTarefaControllerBase with Store {
  @observable
  bool selectValue0 = true;

  @observable
  bool selectValue1 = false;

  @observable
  Color colorItemSelect0 = Colors.indigo[900];

  @observable
  Color colorItemSelect1 = Colors.grey.withOpacity(0.2);

  @observable
  Color colorText0 = Colors.white;

  @observable
  Color colorText1 = Colors.black;

  Color colorSelect = Colors.indigo[900];
  Color colorNoSelect = Colors.grey.withOpacity(0.2);

  Color colorTextSelec = Colors.white;
  Color colorTextNoSelec = Colors.black;

  @observable
  int indexPage = 0;

  List<Widget> items = [NewTaskComposed(), NewTaskSimple()];

  @action
  void changeTask(int index) {
    if (index == 0) {
      colorText0 = colorTextSelec;
      colorItemSelect0 = colorSelect;
      colorText1 = colorTextNoSelec;
      colorItemSelect1 = colorNoSelect;
      selectValue0 = true;
      selectValue1 = false;
    } else {
      colorText0 = colorTextNoSelec;
      colorItemSelect0 = colorNoSelect;
      colorText1 = colorTextSelec;
      colorItemSelect1 = colorSelect;
      selectValue0 = false;
      selectValue1 = true;
    }

    indexPage = index;
  }
}
