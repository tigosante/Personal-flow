import 'package:flutter/material.dart';

class GeneratioCards {
  dynamic context_screen;
  double screen_size;
  String font_button;

  double screenSize() => screen_size = MediaQuery.of(context_screen).size.width;
  String fontButtun() => font_button = 'orkney-bold';

  double get outScreenSize => screenSize();
  String get outFontButton => fontButtun();

  GeneratioCards({@required this.context_screen});
}

class TasksProp{
  double screen_size;
  dynamic context_screen;
  
  double screenSize() => screen_size = MediaQuery.of(context_screen).size.width;
  double get outScreenSize => screenSize();
  TasksProp({@required this.context_screen});
}

class Buttons {
  List<Color> cor_button_concl = [Colors.blue[400], Colors.orange[400]];

  dynamic context;
  List toDoList = [];
  int index;

  Color cor_concluir() =>
      index % 2 != 0 ? cor_button_concl[0] : cor_button_concl[1];

  dynamic concluir() {
    if (!toDoList[index]["ok"]) {
      List<bool> antigo = [];

      if (!toDoList[index]["ok"]) {
        toDoList[index]["ok"] = !toDoList[index]["ok"];
      }

      for (int i = 0; i < toDoList[index]["details"].length; i++) {
        antigo.add(toDoList[index]["details"]["$i"]["bool"]);
        toDoList[index]["details"]["$i"]["bool"] = true;
        // completos++;
      }

      final snack = SnackBar(
        content: Text("Tarefa concluída"),
        duration: Duration(seconds: 2),
        action: SnackBarAction(
          label: "Desfazer",
          onPressed: () {
            for (int i = 0; i < toDoList[index]["details"].length; i++) {
              toDoList[index]["details"]["$i"]["bool"] = antigo[i];
              // ompletos--;
            }

            toDoList[index]["ok"] = false;

            // saveData();
          },
        ),
      );

      Scaffold.of(context).removeCurrentSnackBar();
      Scaffold.of(context).showSnackBar(snack);
    }
  }

  Buttons(
      {@required this.toDoList, @required this.index, @required this.context});

  // Color cor_concluir() {}
}

class Informacoes {
  dynamic saveDate;
  List toDoList = [];
  int index;
  int index_sub;

  // Títuto da tarefa.
  String get outTitle => toDoList[index]["title"];

  // Títuto da subtarefa.
  String titleSub() {
    return toDoList[index]["details"]["$index_sub"]["title"].toString();
  }

  // Ícone esquerdo da subtarefa.
  Icon leadIconSub() {
    return boolSub()
        ? Icon(
            Icons.check_circle,
          )
        : Icon(
            Icons.panorama_fish_eye,
            color: Colors.transparent,
          );
  }

  // Íconde direito da subtarefa.
  Icon traiIcon() {
    return boolSub()
        ? Icon(
            Icons.check_circle,
            color: Colors.transparent,
          )
        : Icon(
            Icons.panorama_fish_eye,
          );
  }

  // Valor (booleano) da subtarefa.
  bool boolSub() {
    return toDoList[index]["details"]["$index_sub"]["bool"];
  }

  stateIconLead() {
    if (toDoList[index]["details"].length <= 1) {
      toDoList[index]["details"]["$index_sub"]["bool"] = false;
      toDoList[index]["ok"] = false;
    } else {
      toDoList[index]["details"]["$index_sub"]["bool"] = false;
      toDoList[index]["ok"] = false;
    }
    return toDoList;
  }

  stateIconTrai() {
    if (toDoList[index]["details"].length <= 1) {
      toDoList[index]["details"]["$index_sub"]["bool"] = true;
      toDoList[index]["ok"] = true;
    } else {
      toDoList[index]["details"]["$index_sub"]["bool"] = true;
    }
    return toDoList;
  }

  Informacoes({@required this.toDoList, @required this.index, this.index_sub});
}
