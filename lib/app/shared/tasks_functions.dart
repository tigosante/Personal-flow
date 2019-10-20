import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;

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
            Icons.check_circle, color: Colors.teal[200],
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
            Icons.panorama_fish_eye, color: Colors.blue[600],
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

// class DataHora{
//   dynamic toDoList;
//   dynamic data_list;
//   dynamic data_atual;
//   dynamic context;

//   // calendario() async {
//   //   final List<DateTime> picked = await DateRagePicker.showDatePicker(
//   //     context: context,
//   //     firstDate: new DateTime(2000),
//   //     lastDate: new DateTime(2030),
//   //     initialFirstDate: new DateTime.now(),
//   //     initialLastDate: (new DateTime.now()).add(new Duration(days: 4)),
//   //   );

//   //   if (picked != null && picked.length <= 2) {
//   //     // Map<String, dynamic> newToDo = Map();
//   //     Map<String, dynamic> content = Map();
//   //     Map<String, dynamic> details = Map();

//   //     String dt_start;
//   //     String dt_end;
//   //     String dt_inicial;
//   //     String dt_final;

//   //     int day_st;
//   //     int mot_st;
//   //     int yea_st;
//   //     int day_ed;
//   //     int mot_ed;
//   //     int yea_ed;
      

//   //     dt_start  =  picked[0].toString().split(" ").removeAt(0).replaceAll("-", "/");
//   //     yea_st    =  int.parse(dt_start.split("/").toList()[0].toString());
//   //     mot_st    =  int.parse(dt_start.split("/").toList()[1].toString());
//   //     day_st    =  int.parse(dt_start.split("/").toList()[2].toString());

//   //     dt_end  =  picked[1].toString().split(" ").removeAt(0).replaceAll("-", "/");
//   //     yea_ed  =  int.parse(dt_end.split("/").toList()[0].toString().trim());
//   //     mot_ed  =  int.parse(dt_end.split("/").toList()[1].toString().trim());
//   //     day_ed  =  int.parse(dt_end.split("/").toList()[2].toString().trim());

//   //     dt_inicial  =  formatDate(DateTime(yea_st, mot_st, day_st), [D, ', ', d, ' ', M]);
//   //     dt_final    =  formatDate(DateTime(yea_st, mot_ed, day_ed), [D, ', ', d, ' ', M]);

//   //     for(int i = 0; i<12; i++){
//   //       dt_inicial = dt_inicial.replaceAll("Feb", "Fev");
//   //       dt_inicial = dt_inicial.replaceAll("Apr", "Abr");
//   //       dt_inicial = dt_inicial.replaceAll("May", "Mai");
//   //       dt_inicial = dt_inicial.replaceAll("Aug", "Ago");
//   //       dt_inicial = dt_inicial.replaceAll("Sep", "Set");
//   //       dt_inicial = dt_inicial.replaceAll("Oct", "Out");
//   //       dt_inicial = dt_inicial.replaceAll("Dec", "Dez");
        
//   //       dt_inicial = dt_inicial.replaceAll("Sun", "Dom");
//   //       dt_inicial = dt_inicial.replaceAll("Mon", "Seg");
//   //       dt_inicial = dt_inicial.replaceAll("Tue", "Ter");
//   //       dt_inicial = dt_inicial.replaceAll("Wed", "Qua");
//   //       dt_inicial = dt_inicial.replaceAll("Thur", "Qui");
//   //       dt_inicial = dt_inicial.replaceAll("Fri", "Sex");
//   //       dt_inicial = dt_inicial.replaceAll("Sat", "Sáb");


//   //       dt_final = dt_final.replaceAll("Feb", "Fev");
//   //       dt_final = dt_final.replaceAll("Apr", "Abr");
//   //       dt_final = dt_final.replaceAll("May", "Mai");
//   //       dt_final = dt_final.replaceAll("Aug", "Ago");
//   //       dt_final = dt_final.replaceAll("Sep", "Set");
//   //       dt_final = dt_final.replaceAll("Oct", "Out");
//   //       dt_final = dt_final.replaceAll("Dec", "Dez");
        
//   //       dt_final = dt_final.replaceAll("Sun", "Dom");
//   //       dt_final = dt_final.replaceAll("Mon", "Seg");
//   //       dt_final = dt_final.replaceAll("Tue", "Ter");
//   //       dt_final = dt_final.replaceAll("Wed", "Qua");
//   //       dt_final = dt_final.replaceAll("Thur", "Qui");
//   //       dt_final = dt_final.replaceAll("Fri", "Sex");
//   //       dt_final = dt_final.replaceAll("Sat", "Sáb");
//   //     }

//   //     content["dt_start"] = dt_start;
//   //     content["dt_end"] = dt_end;

//   //     content["dt_inicial"] = dt_inicial;
//   //     content["dt_final"] = dt_final;

//   //     // content["title"] = toDoList[0]["details"]["0"]["title"];
//   //     content["bool"] = false;

//   //     // details["$index"] = content;

//   //     // newToDo["title"] = toDoList[0]["title"];
//   //     // newToDo["details"] = details;
//   //     // newToDo["ok"] = false;

//   //     // toDoList.insert(0, newToDo);

//   //     print(toDoList);
//   //   }
//   // }

//   DataHora({this.context, this.data_atual, this.data_list, this.toDoList,});
// }