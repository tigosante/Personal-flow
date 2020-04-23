import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:personalflow/app/app_controller.dart';

class ViewSimples {
  static ThemeData virificaTema() {
    String temaApp =
        Modular.get<AppController>().themeMode.toString().split(".")[1];
    String temaSystem = WidgetsBinding.instance.window.platformBrightness
        .toString()
        .split(".")[1];

    bool systemVal = temaSystem == "light";
    if (temaApp == "system") {
      return systemVal ? ThemeData.light() : ThemeData.dark();
    } else if (temaApp == "light") {
      return ThemeData.light();
    } else {
      return ThemeData.dark();
    }
  }

  static Future<DateTime> popUpData(BuildContext context) => showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
      builder: (BuildContext context, Widget child) =>
          Theme(data: virificaTema(), child: child));

  static Future<TimeOfDay> popUpHora(BuildContext context) => showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget child) => Directionality(
            textDirection: TextDirection.ltr,
            child: child,
          ));

  static Future returnDialogTarefa(
          BuildContext context, dynamic data, double tamanhoTela) =>
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("Editar título",
                  style: TextStyle(color: Colors.yellow[900])),
              content: Container(
                  padding: EdgeInsets.only(
                      top: tamanhoTela * 0.01,
                      left: tamanhoTela * 0.03,
                      right: tamanhoTela * 0.03,
                      bottom: tamanhoTela * 0.01),
                  decoration: BoxDecoration(
                      color: Colors.indigo.withOpacity(0.2),
                      borderRadius:
                          BorderRadius.all(Radius.circular(tamanhoTela * 0.05)),
                      border: Border.all(color: Colors.grey.withOpacity(0.3))),
                  child: TextField(
                    controller: TextEditingController(text: data.title),
                    decoration: InputDecoration(border: InputBorder.none),
                    onChanged: data.updateTitulo,
                  )),
              actions: <Widget>[
                FlatButton(
                    color: Colors.red.withOpacity(0.3),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(tamanhoTela * 0.05))),
                    child:
                        Text('Fechar', style: TextStyle(color: Colors.black)),
                    onPressed: () => Navigator.of(context).pop()),
              ],
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(tamanhoTela * 0.07))));
        },
      );
}
