import 'package:date_format/date_format.dart';
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

class TasksProp {
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

  Buttons(
      {@required this.toDoList, @required this.index, @required this.context});
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
    return toDoList[index]["details"]["$index_sub"]["bool"];
  }

  stateIconLead() {
    if (toDoList[index]["details"].length <= 1) {
      toDoList[index]["details"]["$index_sub"]["bool"] = false;
      toDoList[index]["details"]["$index_sub"]["conclusao"] = 0;
      toDoList[index]["bool"] = false;
      toDoList[index]["conclusao"] = 0;
      print(toDoList[index]["details"]["$index_sub"]["conclusao"]);
    } else {
      toDoList[index]["details"]["$index_sub"]["bool"] = false;
      toDoList[index]["details"]["$index_sub"]["conclusao"] = 0;
      toDoList[index]["bool"] = false;
      toDoList[index]["conclusao"] = 0;
    }
    return toDoList;
  }

  stateIconTrai() {
    if (toDoList[index]["details"].length <= 1) {
      toDoList[index]["details"]["$index_sub"]["bool"] = true;
      toDoList[index]["details"]["$index_sub"]["conclusao"] = 1;
      toDoList[index]["bool"] = true;
      toDoList[index]["conclusao"] = 1;
      print(toDoList[index]["details"]["$index_sub"]["conclusao"]);
    } else {
      toDoList[index]["details"]["$index_sub"]["bool"] = true;
    }
    return toDoList;
  }

  Informacoes({@required this.toDoList, @required this.index, this.index_sub});
}

class DataHora {
  dynamic context;
  dynamic picked;
  String title;
  bool boolen;
  int index;

  String tipo;
  String programada;
  String dt_inativacao;
  String conclusao;
  String repeticao;
  String data_repeticao;
  String title_formatado;

  calendario() {
    if (picked != null) {
      Map<String, dynamic> content = Map();

      String data_no_form;
      String data_form;

      int day;
      int mot;
      int yea;

      data_no_form =
          picked.toString().split(" ").removeAt(0).replaceAll("-", "/");
      yea = int.parse(data_no_form.split("/").toList()[0].toString());
      mot = int.parse(data_no_form.split("/").toList()[1].toString());
      day = int.parse(data_no_form.split("/").toList()[2].toString());

      data_form = formatDate(DateTime(yea, mot, day), [D, ', ', d, ' ', M]);

      for (int i = 0; i < 12; i++) {
        data_form = data_form.replaceAll("Feb", "Fev");
        data_form = data_form.replaceAll("Apr", "Abr");
        data_form = data_form.replaceAll("May", "Mai");
        data_form = data_form.replaceAll("Aug", "Ago");
        data_form = data_form.replaceAll("Sep", "Set");
        data_form = data_form.replaceAll("Oct", "Out");
        data_form = data_form.replaceAll("Dec", "Dez");

        data_form = data_form.replaceAll("Sun", "Dom");
        data_form = data_form.replaceAll("Mon", "Seg");
        data_form = data_form.replaceAll("Tue", "Ter");
        data_form = data_form.replaceAll("Wed", "Qua");
        data_form = data_form.replaceAll("Thur", "Qui");
        data_form = data_form.replaceAll("Fri", "Sex");
        data_form = data_form.replaceAll("Sat", "Sáb");
      }

      content["hora"] = null;
      content["data_form"] = data_form;

      if (title != null && boolen != null) {
        content["title"] = title;
        content["bool"] = boolen;

        content["tipo"] = tipo;
        content["programada"] = programada;
        content["dt_inativacao"] = dt_inativacao;

        content["conclusao"] = conclusao;
        content["repeticao"] = repeticao;
        content["data_repeticao"] = data_repeticao;
        content["title_formatado"] = title_formatado;
      }

      return content;
    } else {
      Map<String, dynamic> content = Map();

      content["hora"] = null;
      content["data_form"] = null;

      if (title != null && boolen != null) {
        content["title"] = title;
        content["bool"] = boolen;

        content["tipo"] = tipo;
        content["programada"] = programada;
        content["dt_inativacao"] = dt_inativacao;

        content["conclusao"] = conclusao;
        content["repeticao"] = repeticao;
        content["data_repeticao"] = data_repeticao;
        content["title_formatado"] = title_formatado;
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
      this.data_repeticao,
      this.dt_inativacao,
      this.programada,
      this.repeticao,
      this.tipo,
      this.title_formatado});
}

class AgendarData {
  dynamic picked;
  dynamic context;
  bool tipo;

  String data_agendamento() {
    if (picked != null) {
      Map<String, dynamic> content = Map();

      String data_no_form;
      String data_form;

      int day;
      int mot;
      int yea;

      data_no_form =
          picked.toString().split(" ").removeAt(0).replaceAll("-", "/");
      yea = int.parse(data_no_form.split("/").toList()[0].toString());
      mot = int.parse(data_no_form.split("/").toList()[1].toString());
      day = int.parse(data_no_form.split("/").toList()[2].toString());

      data_form = formatDate(DateTime(yea, mot, day), [D, ', ', d, ' ', M]);

      for (int i = 0; i < 12; i++) {
        data_form = data_form.replaceAll("Feb", "Fev");
        data_form = data_form.replaceAll("Apr", "Abr");
        data_form = data_form.replaceAll("May", "Mai");
        data_form = data_form.replaceAll("Aug", "Ago");
        data_form = data_form.replaceAll("Sep", "Set");
        data_form = data_form.replaceAll("Oct", "Out");
        data_form = data_form.replaceAll("Dec", "Dez");

        data_form = data_form.replaceAll("Sun", "Dom");
        data_form = data_form.replaceAll("Mon", "Seg");
        data_form = data_form.replaceAll("Tue", "Ter");
        data_form = data_form.replaceAll("Wed", "Qua");
        data_form = data_form.replaceAll("Thur", "Qui");
        data_form = data_form.replaceAll("Fri", "Sex");
        data_form = data_form.replaceAll("Sat", "Sáb");
      }



      return "Repetir até: " + data_form + ".";
    }
    return "Clique para definir a data final desta tarefa.";
  }

  dynamic agendar(dias_agendados){
    
  }

  AgendarData({
    this.context,
    this.picked,
    this.tipo,
  });
}
