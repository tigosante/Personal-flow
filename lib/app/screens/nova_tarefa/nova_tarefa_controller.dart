import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:personalflow/core/model/simples/model.dart';

part 'nova_tarefa_controller.g.dart';

class NovaTarefaController = _NovaTarefaControllerBase
    with _$NovaTarefaController;

abstract class _NovaTarefaControllerBase with Store {
  @observable
  String dataNovaTarefa;

  @observable
  String horaNovaTarefa;

  @observable
  int qntTarefas = 0;

  @observable
  TextEditingController cSimples = TextEditingController(text: "");

  @observable
  Function addNovaTarefa;

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

  @observable
  Icon iconButtonNewTask = Icon(Icons.playlist_add_check);

  @observable
  int indexPage = 0;

  @observable
  List<Subatarefas> subtarefas = <Subatarefas>[Subatarefas(title: "Tarefa")];

  @observable
  PageController pageController =
      PageController(initialPage: 0, keepPage: true);

  Color colorSelect = Colors.indigo[700];
  Color colorNoSelect = Colors.grey.withOpacity(0.2);

  Color colorTextSelec = Colors.white;
  Color colorTextNoSelec = Colors.black;

  @action
  void changeTask(int index) {
    indexPage = index;

    if (index == 0) {
      iconButtonNewTask = Icon(Icons.playlist_add_check);
    } else {
      iconButtonNewTask = Icon(Icons.check);
      addNovaTarefa = addNovaTarefaSimplis;
    }

    pageController.animateToPage(index,
        duration: Duration(milliseconds: 500), curve: Curves.ease);
  }

  @action
  void novaTarefa(BuildContext context) {
    if (addNovaTarefaSimplis()) {
      Navigator.of(context).pop();
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.yellow,
          content: Text("Título vazio!",
              style:
                  TextStyle(color: Colors.red, fontWeight: FontWeight.bold))));
    }
  }

  @action
  bool addNovaTarefaSimplis() {
    return ModelTarefaSimples(
            title: cSimples.text,
            data: dataNovaTarefa ?? "",
            hora: horaNovaTarefa ?? "")
        .addNovaTarefa(qntTarefas);
  }

  @action
  void addNovaTarefaComposta() {}
}

class Subatarefas {
  final String title;

  Subatarefas({this.title});
}
