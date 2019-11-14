import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:personal_flow/app/shared/tasks_functions.dart';

class CardContentUnica extends StatefulWidget {
  CardContentUnica(
      {Key key,
      this.valor,
      this.texto,
      this.size_screen,
      this.font_button,
      this.corConcluir,
      this.index})
      : super(key: key);

  int index;
  final int valor;
  final List texto;
  final double size_screen;
  dynamic font_button;
  Color corConcluir;

  _CardContentUnicaState createState() => _CardContentUnicaState();
}

class _CardContentUnicaState extends State<CardContentUnica> {
  int index;
  List toDoList;
  double size_screen;
  dynamic font_button;
  Color corConcluir;
  Map<String, dynamic> list_data = Map();

  @override
  Widget build(BuildContext context) {
    IconButton bt_calendar = IconButton(
        color: Colors.grey[600],
        icon: Icon(
          Icons.calendar_today,
        ),
        onPressed: () {});

    TextEditingController controller = TextEditingController();
    setState(() {
      index = widget.index;
      corConcluir = widget.corConcluir;
      font_button = widget.font_button;
      size_screen = widget.size_screen;
      toDoList = toDoList = widget.texto;
    });

    return buildBody(context, index);
  }

  Widget buildBody(context, index) {
    TextEditingController controllerText =
        TextEditingController(text: toDoList[widget.valor]["title"]);

    IconButton bt_calendar = IconButton(
      color: Colors.blue[600],
      icon: Icon(
        Icons.calendar_today,
      ),
      onPressed: () async {
        final DateTime picked = await showDatePicker(
          context: context,
          firstDate: new DateTime(2000),
          lastDate: new DateTime(2030),
          initialDate: new DateTime.now(),
        );
        setState(() {
          DataHora dataHora = DataHora(
            picked: picked,
            title: toDoList[widget.valor]["title"],
            boolen: toDoList[widget.valor]["bool"],
            tipo: toDoList[widget.valor]["tipo"],
            programada: toDoList[widget.valor]["programada"],
            dt_inativacao: toDoList[widget.valor]["dt_inativacao"],
            repeticao: toDoList[widget.valor]["repeticao"],
            conclusao: toDoList[widget.valor]["conclusao"],
            title_formatado: toDoList[widget.valor]["title_formatado"],
            data_repeticao: toDoList[widget.valor]["data_repeticao"],
          );
          toDoList[widget.valor] = dataHora.calendario();
        });
      },
    );

    return ListTile(
      title: Text(toDoList[widget.valor]["title"]),
      subtitle: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          InkWell(
            child: Container(
              padding: EdgeInsets.only(
                top: size_screen * 0.015,
                right: size_screen * 0.015,
                bottom: size_screen * 0.015,
              ),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.all(Radius.circular(size_screen * 0.02)),
              ),
              child: toDoList[widget.valor]["data_form"] == null
                  ? Text("Data e hora")
                  : Text(toDoList[widget.valor]["data_form"] + ","),
            ),
            onTap: () async {
              final DateTime picked = await showDatePicker(
                context: context,
                firstDate: new DateTime(2000),
                lastDate: new DateTime(2030),
                initialDate: new DateTime.now(),
              );
              setState(() {
                DataHora dataHora = DataHora(
                    picked: picked,
                    title: toDoList[widget.valor]["title"],
                    boolen: toDoList[widget.valor]["bool"]);
                toDoList[widget.valor] = dataHora.calendario();
              });
            },
          ),
          InkWell(
            child: Container(
              padding: EdgeInsets.only(
                top: size_screen * 0.015,
                right: size_screen * 0.015,
                bottom: size_screen * 0.015,
              ),
              child: toDoList[widget.valor] != null
                  ? toDoList[widget.valor]["data_form"] != null
                      ? toDoList[widget.valor]["hora"] == null
                          ? Text("hora")
                          : Text(toDoList[widget.valor]["hora"].toString())
                      : Container(
                          color: Colors.transparent,
                        )
                  : Container(
                      color: Colors.transparent,
                    ),
            ),
            onTap: () async {
              final TimeOfDay picked = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              setState(() {
                DataHora dataHora = DataHora(picked: picked);
                String retorno = dataHora.hora().toString();
                if (retorno != "null") {
                  toDoList[widget.valor]["hora"] = retorno;
                } else {
                  toDoList[widget.valor]["hora"] = null;
                }
                saveData();
              });
            },
          ),
          toDoList[widget.valor]["data_form"] != null
              ? InkWell(
                  child: Container(
                    padding: EdgeInsets.only(
                      top: size_screen * 0.015,
                      right: size_screen * 0.015,
                      bottom: size_screen * 0.015,
                    ),
                    child: Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      toDoList[widget.valor]["hora"] = null;
                      toDoList[widget.valor]["data_form"] = null;
                    });
                  },
                )
              : Container(
                  color: Colors.transparent,
                )
        ],
      ),
      trailing: toDoList[widget.valor]["bool"]
          ? IconButton(
              icon: Icon(
                Icons.check,
                color: Colors.teal,
              ),
              onPressed: () {
                setState(() {
                  toDoList[widget.valor]["conclusao"] = 0;
                  toDoList[widget.valor]["bool"] = false;
                  saveData();
                });
              },
            )
          : IconButton(
              icon: Icon(
                Icons.panorama_fish_eye,
                color: Colors.blue[600],
              ),
              onPressed: () {
                setState(() {
                  toDoList[widget.valor]["conclusao"] = 1;
                  toDoList[widget.valor]["bool"] = true;
                  saveData();
                });
              },
            ),
      onTap: () {
        modal(context, index, size_screen);
      },
    );
  }

  modal(context, index, size_screen) {
    TextEditingController controller_text =
        TextEditingController(text: toDoList[widget.valor]["title"]);

    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(size_screen * 0.04),
        ),
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Divider(
                  height: size_screen * 0.05,
                  color: Colors.transparent,
                ),
                Text(
                  "Editor de tarefa",
                  style: TextStyle(
                    fontSize: size_screen * 0.04,
                  ),
                ),
                Divider(
                  height: size_screen * 0.1,
                  color: Colors.transparent,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.all(
                          Radius.circular(size_screen * 0.02))),
                  width: size_screen * 0.8,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: size_screen * 0.015, right: size_screen * 0.015),
                    child: TextField(
                      controller: controller_text,
                      decoration: InputDecoration(
                        hintText: "título",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Divider(
                  height: size_screen * 0.05,
                  color: Colors.transparent,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    RaisedButton(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(size_screen * 0.02),
                      ),
                      child: Text(
                        "Salvar",
                      ),
                      onPressed: () {
                        setState(() {
                          if (controller_text.text.trim().isNotEmpty) {
                            toDoList[widget.valor]["title"] =
                                controller_text.text;
                            saveData();
                            Navigator.pop(context);
                          }
                        });
                      },
                    ),
                    SizedBox(
                      width: size_screen * 0.05,
                    )
                  ],
                ),
                Divider(
                  height: size_screen * 0.05,
                  color: Colors.transparent,
                ),
              ],
            ),
          );
        });
  }

  Future<File> saveData() async {
    String data = jsonEncode(toDoList);
    final file = await getFile();

    return file.writeAsString(data);
  }

  Future<File> getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }
}
