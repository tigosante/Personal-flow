import 'package:flutter/material.dart';

import 'package:date_format/date_format.dart';

class GeneratioCards {
  dynamic contextScreen;
  double screenSize;
  String fontButton;

  double screen_Size() => screenSize = MediaQuery.of(contextScreen).size.width;
  String font_Buttun() => fontButton = 'orkney-bold';

  double get outScreen_Size => screen_Size();
  String get outFontButton => font_Buttun();

  GeneratioCards({@required this.contextScreen});
}

class TasksProp {
  double screenSize;
  dynamic contextScreen;

  double screen_Size() => screenSize = MediaQuery.of(contextScreen).size.width;
  double get outScreen_Size => screen_Size();
  TasksProp({@required this.contextScreen});
}

class Buttons {
  dynamic context;
  List toDoList = [];
  int index;

  Color corConcluir() =>
      index % 2 != 0 ? Colors.blue[400] : Colors.orange[400];

  Buttons(
      {@required this.toDoList, @required this.index, @required this.context});
}

class Informacoes {
  dynamic saveDate;
  List toDoList = [];
  int index;
  int indexSub;

  // Títuto da tarefa.
  String get outTitle => toDoList[index]["title"];

  // Títuto da subtarefa.
  String titleSub() {
    return toDoList[index]["details"]["$indexSub"]["title"].toString();
  }

  // Ícone esquerdo da subtarefa.
  Icon okIconSub() {
    return Icon(
      Icons.check_circle,
      color: Colors.teal,
    );
  }

  // Íconde direito da subtarefa.
  Icon noOkIconSub() {
    return Icon(
      Icons.panorama_fish_eye,
      color: Colors.blue[600],
    );
  }

  // Valor (booleano) da subtarefa.
  bool boolSub() {
    return toDoList[index]["details"]["$indexSub"]["bool"];
  }

  stateIconLead() {
    int dtInvativacao = 0;
    for (int i = 0; i < toDoList[index]["details"].length; i++) {
      dtInvativacao +=
          toDoList[index]["details"]["$i"]["dtInativacao"] == null ? 0 : 1;
    }
    if (dtInvativacao == 0 || dtInvativacao == 1) {
      toDoList[index]["details"]["$indexSub"]["bool"] = false;
      toDoList[index]["details"]["$indexSub"]["conclusao"] = 0;
      toDoList[index]["bool"] = false;
      toDoList[index]["conclusao"] = 0;
    } else {
      toDoList[index]["details"]["$indexSub"]["bool"] = false;
      toDoList[index]["details"]["$indexSub"]["conclusao"] = 0;
      toDoList[index]["bool"] = false;
      toDoList[index]["conclusao"] = 0;
    }
    return toDoList;
  }

  stateIconTrai() {
    int dtInvativacao = 0;
    for (int i = 0; i < toDoList[index]["details"].length; i++) {
      dtInvativacao +=
          toDoList[index]["details"]["$i"]["dtInativacao"] == null ? 0 : 1;
    }
    if (dtInvativacao == 0 || dtInvativacao == 1) {
      toDoList[index]["details"]["$indexSub"]["bool"] = true;
      toDoList[index]["details"]["$indexSub"]["conclusao"] = 1;
      toDoList[index]["bool"] = true;
      toDoList[index]["conclusao"] = 1;
    } else {
      toDoList[index]["details"]["$indexSub"]["bool"] = true;
    }
    return toDoList;
  }

  Informacoes({@required this.toDoList, @required this.index, this.indexSub});
}

class DataHora {
  int index;
  int idChanel;
  int conclusao;
  int repeticao;
  int dataRepetidao;
  
  bool boolen;
  bool agendada;
  
  List diasAgendados;
  
  String tipo;
  String title;
  String dataAgenda;
  String dtInativacao;
  String titleFormatado;
  
  dynamic picked;
  dynamic context;


  calendario() {
    if (picked != null) {
      Map<String, dynamic> content = Map();

      String dataNoForm;
      String dataForm;

      int day;
      int mot;
      int yea;

      dataNoForm =
          picked.toString().split(" ").removeAt(0).replaceAll("-", "/");
      yea = int.parse(dataNoForm.split("/").toList()[0].toString());
      mot = int.parse(dataNoForm.split("/").toList()[1].toString());
      day = int.parse(dataNoForm.split("/").toList()[2].toString());

      dataForm = formatDate(DateTime(yea, mot, day), [D, ', ', d, ' ', M]);

      for (int i = 0; i < 12; i++) {
        dataForm = dataForm.replaceAll("Feb", "Fev");
        dataForm = dataForm.replaceAll("Apr", "Abr");
        dataForm = dataForm.replaceAll("May", "Mai");
        dataForm = dataForm.replaceAll("Aug", "Ago");
        dataForm = dataForm.replaceAll("Sep", "Set");
        dataForm = dataForm.replaceAll("Oct", "Out");
        dataForm = dataForm.replaceAll("Dec", "Dez");

        dataForm = dataForm.replaceAll("Sun", "Dom");
        dataForm = dataForm.replaceAll("Mon", "Seg");
        dataForm = dataForm.replaceAll("Tue", "Ter");
        dataForm = dataForm.replaceAll("Wed", "Qua");
        dataForm = dataForm.replaceAll("Thur", "Qui");
        dataForm = dataForm.replaceAll("Fri", "Sex");
        dataForm = dataForm.replaceAll("Sat", "Sáb");
      }

      content["hora"] = null;
      content["dataForm"] = dataForm;

      content["dia"] = day;
      content["mes"] = mot;
      content["ano"] = yea;

      if (title != null && boolen != null) {
        content["title"] = title;
        content["bool"] = boolen;

        content["tipo"] = tipo;
        content["agendada"] = agendada;
        content["dtInativacao"] = dtInativacao;

        content["conclusao"] = conclusao;
        content["repeticao"] = repeticao;
        content["dataRepetidao"] = dataRepetidao;
        content["titleFormatado"] = titleFormatado;
        content["dataAgenda"] = dataAgenda;
        content["diasAgendados"] = diasAgendados;
        content["idChanel"] = idChanel;
      }

      return content;
    } else {
      Map<String, dynamic> content = Map();

      content["hora"] = null;
      content["dataForm"] = null;

      if (title != null && boolen != null) {
        content["title"] = title;
        content["bool"] = boolen;

        content["tipo"] = tipo;
        content["agendada"] = agendada;
        content["dtInativacao"] = dtInativacao;

        content["conclusao"] = conclusao;
        content["repeticao"] = repeticao;
        content["dataRepetidao"] = dataRepetidao;
        content["titleFormatado"] = titleFormatado;
        content["dataAgenda"] = dataAgenda;
        content["diasAgendados"] = diasAgendados;
        content["idChanel"] = idChanel;
      }

      return content;
    }
  }

  hora() {
    if (picked != null && picked != TimeOfDay.now()) {
      String retorno = picked.toString().split("TimeOfDay(")[1].split(")")[0];

      return retorno;
    }
  }

  DataHora(
      {this.context,
      this.picked,
      this.index,
      this.boolen,
      this.title,
      this.conclusao,
      this.dataRepetidao,
      this.dtInativacao,
      this.agendada,
      this.repeticao,
      this.tipo,
      this.titleFormatado,
      this.dataAgenda,
      this.diasAgendados,
      this.idChanel});
}

class AgendarData {
  dynamic picked;
  dynamic context;
  bool tipo;

  String dataAgendamento() {
    if (picked != null) {
      Map<String, dynamic> content = Map();

      String dataNoForm;
      String dataForm;

      int day;
      int mot;
      int yea;

      dataNoForm =
          picked.toString().split(" ").removeAt(0).replaceAll("-", "/");
      yea = int.parse(dataNoForm.split("/").toList()[0].toString());
      mot = int.parse(dataNoForm.split("/").toList()[1].toString());
      day = int.parse(dataNoForm.split("/").toList()[2].toString());

      dataForm = formatDate(DateTime(yea, mot, day), [D, ', ', d, ' ', M]);

      for (int i = 0; i < 12; i++) {
        dataForm = dataForm.replaceAll("Feb", "Fev");
        dataForm = dataForm.replaceAll("Apr", "Abr");
        dataForm = dataForm.replaceAll("May", "Mai");
        dataForm = dataForm.replaceAll("Aug", "Ago");
        dataForm = dataForm.replaceAll("Sep", "Set");
        dataForm = dataForm.replaceAll("Oct", "Out");
        dataForm = dataForm.replaceAll("Dec", "Dez");

        dataForm = dataForm.replaceAll("Sun", "Dom");
        dataForm = dataForm.replaceAll("Mon", "Seg");
        dataForm = dataForm.replaceAll("Tue", "Ter");
        dataForm = dataForm.replaceAll("Wed", "Qua");
        dataForm = dataForm.replaceAll("Thur", "Qui");
        dataForm = dataForm.replaceAll("Fri", "Sex");
        dataForm = dataForm.replaceAll("Sat", "Sáb");
      }

      return "Repetir até: " + dataForm + ".";
    }
    return "Definir data final desta tarefa.";
  }

  AgendarData({
    this.context,
    this.picked,
    this.tipo,
  });
}
