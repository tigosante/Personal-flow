import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:local_notifications/local_notifications.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:personal_flow/app/shared/notifications.dart';
import 'package:personal_flow/app/shared/tasks_functions.dart';

class CardContent extends StatefulWidget {
  CardContent(
      {Key key,
      this.valor,
      this.texto,
      this.size_screem,
      this.font_button,
      this.corConcluir,
      this.index})
      : super(key: key);

  int index;
  final int valor;
  final List texto;
  final double size_screem;
  dynamic font_button;
  Color corConcluir;

  _CardContentState createState() => _CardContentState();
}

class _CardContentState extends State<CardContent> {
  int index;
  List toDoList;
  double size_screem;
  dynamic font_button;
  Color corConcluir;
  Map<String, dynamic> list_data = Map();

  @override
  Widget build(BuildContext context) {
    // Notifications notifications = Notifications();

    IconButton bt_calendar = IconButton(
        color: Colors.blue[600],
        icon: Icon(
          Icons.calendar_today,
        ),
        onPressed: () {});

    TextEditingController controller = TextEditingController();
    setState(() {
      index = widget.index;
      corConcluir = widget.corConcluir;
      font_button = widget.font_button;
      size_screem = widget.size_screem;
      toDoList = toDoList = widget.texto;
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: size_screem * 0.025),
          child: Text(
            "Tarefas concluídas:",
            style: TextStyle(
                fontSize: size_screem * 0.02,
                fontFamily: font_button,
                fontWeight: FontWeight.bold),
          ),
        ),
        categoryProgress(context),
        Divider(
          color: Colors.transparent,
          height: size_screem * 0.02,
        ),
        Column(
          children: <Widget>[
            Container(
              width: size_screem * 0.83,
              child: Column(
                children: <Widget>[
                  toDoList[widget.valor]["details"].length > 0
                      ? Column(
                          children: List<Widget>.generate(
                              toDoList[widget.valor]["details"].length,
                              (int index) => buildBody(context, index)))
                      : Container(
                          color: Colors.transparent,
                        ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: size_screem * 0.03,
                    ),
                    child: Container(
                      padding: EdgeInsets.only(
                        left: size_screem * 0.02,
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(size_screem * 0.02),
                            topRight: Radius.circular(size_screem * 0.02),
                            bottomLeft: Radius.circular(size_screem * 0.02),
                          )),
                      child: Row(children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller: controller,
                            maxLines: 8,
                            minLines: 1,
                            decoration: InputDecoration(
                              hintText: "Nova tarefa",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.add_circle,
                            color: Colors.blue[600],
                          ),
                          onPressed: () {
                            setState(() {
                              if (controller.text.trim() != "") {
                                Map<String, dynamic> content = Map();

                                content["title"] = controller.text.trim();
                                content["bool"] = false;
                                content["hora"] = null;
                                content["data_form"] = null;

                                if (list_data.length > 0) {
                                  content["hora"] = list_data["hora"];
                                  content["data_form"] = list_data["data_form"];
                                }

                                toDoList[widget.valor]["details"][
                                        "${toDoList[widget.valor]["details"].length}"] =
                                    content;
                                toDoList[widget.valor]["ok"] = false;

                                list_data["hora"] = null;
                                list_data["data_form"] = null;

                                saveData();
                              }
                            });
                          },
                        ),
                      ]),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(size_screem * 0.02),
                                bottomLeft: Radius.circular(size_screem * 0.02),
                                bottomRight:
                                    Radius.circular(size_screem * 0.02),
                              )),
                          child: dtHrNovo(context)),
                      list_data == null
                          ? bt_calendar
                          : list_data["data_form"] == null
                              ? bt_calendar
                              : IconButton(
                                  color: Colors.red[600],
                                  icon: Icon(
                                    Icons.close,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      list_data["data_form"] = null;
                                      list_data["hora"] = null;
                                    });
                                  },
                                )
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: size_screem * 0.04,
                right: size_screem * 0.01,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(size_screem * 0.05),
                    ),
                    child: Text(
                      "Priorizar",
                      style: TextStyle(
                          fontFamily: font_button,
                          fontSize: size_screem * 0.025),
                    ),
                    onPressed: () {},
                  ),
                  RaisedButton(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(size_screem * 0.05),
                    ),
                    child: Text(
                      "Concluir",
                      style: TextStyle(fontSize: size_screem * 0.025),
                    ),
                    onPressed: () {
                      setState(() {
                        if (!toDoList[index]["ok"]) {
                          toDoList[index]["ok"] = true;

                          List<bool> antigo = [];

                          for (int i = 0;
                              i < toDoList[index]["details"].length;
                              i++) {
                            antigo
                                .add(toDoList[index]["details"]["$i"]["bool"]);
                            toDoList[index]["details"]["$i"]["bool"] = true;
                          }

                          saveData();

                          Flushbar flushbar;
                          bool _wasButtonClicked;

                          flushbar = Flushbar<bool>(
                            animationDuration: Duration(milliseconds: 650),
                            message: "Tarefa concluída",
                            borderRadius: size_screem * 0.05,
                            margin: EdgeInsets.only(
                              bottom: size_screem * 0.15,
                              left: size_screem * 0.1,
                              right: size_screem * 0.1,
                            ),
                            duration: Duration(seconds: 2),
                            mainButton: FlatButton(
                              child: Text(
                                "Desfazer",
                                style: TextStyle(color: Colors.amber),
                              ),
                              onPressed: () {
                                setState(() {
                                  for (int i = 0;
                                      i < toDoList[index]["details"].length;
                                      i++) {
                                    toDoList[index]["details"]["$i"]["bool"] =
                                        antigo[i];
                                  }
                                  toDoList[index]["ok"] = false;

                                  saveData();

                                  flushbar.dismiss(true);
                                });
                              },
                            ),
                          )..show(context).then((result) {
                              setState(() {
                                _wasButtonClicked = result;
                              });
                            });
                        }
                      });
                    },
                  )
                ],
              ),
            ),
            Divider(
              color: Colors.transparent,
              height: size_screem * 0.02,
            ),
          ],
        ),
      ],
    );
  }

  Widget buildBody(context, index) {
    Informacoes informacoes =
        Informacoes(toDoList: toDoList, index: widget.valor, index_sub: index);
    String title_sub = informacoes.titleSub();
    bool boolSub = informacoes.boolSub();
    Icon leadIconSub = informacoes.leadIconSub();
    Icon traiIcon = informacoes.traiIcon();

    TextEditingController controllerText =
        TextEditingController(text: title_sub);

    IconButton bt_calendar = IconButton(
        color: Colors.blue[600],
        icon: Icon(
          Icons.calendar_today,
        ),
        onPressed: () {});

    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(size_screem * 0.03),
      ),
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: size_screem * 0.01),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(size_screem * 0.02),
                      topRight: Radius.circular(size_screem * 0.02),
                      bottomLeft: Radius.circular(size_screem * 0.02),
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    boolSub
                        ? IconButton(
                            icon: leadIconSub,
                            onPressed: () {
                              setState(() {
                                toDoList = informacoes.stateIconLead();
                                saveData();
                              });
                            },
                          )
                        : Container(
                            color: Colors.transparent,
                          ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: size_screem * 0.02,
                        ),
                        child: TextField(
                          maxLines: 8,
                          minLines: 1,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Tarefa",
                          ),
                          controller: controllerText,
                        ),
                      ),
                    ),
                    controllerText.text == title_sub
                        ? (boolSub
                            ? Container(
                                color: Colors.transparent,
                              )
                            : IconButton(
                                icon: traiIcon,
                                onPressed: () {
                                  setState(() {
                                    toDoList = informacoes.stateIconTrai();
                                    saveData();
                                  });
                                },
                              ))
                        : IconButton(
                            icon: Icon(Icons.save_alt),
                            onPressed: () {
                              setState(() {
                                toDoList[widget.valor]["details"]["$index"]
                                    ["title"] = controllerText.text;
                                toDoList = informacoes.stateIconLead();
                                saveData();
                              });
                            },
                          ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(size_screem * 0.02),
                        bottomLeft: Radius.circular(size_screem * 0.02),
                        bottomRight: Radius.circular(size_screem * 0.02),
                      )),
                  child: dtHr(context, index),
                ),
                toDoList[widget.valor]["details"]["$index"] == null
                    ? bt_calendar
                    : toDoList[widget.valor]["details"]["$index"]["data_form"] ==
                            null
                        ? bt_calendar
                        : IconButton(
                            color: Colors.red[600],
                            icon: Icon(
                              Icons.close,
                            ),
                            onPressed: () {
                              setState(() {
                                toDoList[widget.valor]["details"]["$index"]
                                    ["data_form"] = null;
                                toDoList[widget.valor]["details"]["$index"]
                                    ["hora"] = null;
                              });
                            },
                          )
              ],
            )
          ],
        ),
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: "Excluir",
            color: Colors.red,
            icon: Icons.delete,
            onTap: () {
              setState(() {
                int valor = 0;
                int lastRemovedPos;
                dynamic lastRemoved;
                Map<String, dynamic> toDo = Map();
                Map<String, dynamic> toDoAntigo = Map();
                Map<String, dynamic> toNovo = Map();
                List toDoNovo = [];

                lastRemoved = toDoList[widget.valor]["details"]["$index"];
                lastRemovedPos = index;

                toDo = Map.from(toDoList[widget.valor]["details"]);
                toDoAntigo = Map.from(toDoList[widget.valor]["details"]);

                toDo.remove("$lastRemovedPos");

                for (int i = 0; i <= toDo.length; i++) {
                  if (toDo["$i"] != null) {
                    toDoNovo.add(toDo["$i"]);

                    if (toDoList[widget.valor]["details"]["$i"]["bool"]) {
                      valor++;
                    }
                  }
                }

                if (valor == toDoNovo.length) {
                  toDoList[widget.valor]["ok"] = true;
                }

                for (int i = 0; i < toDoNovo.length; i++) {
                  toNovo["$i"] = toDoNovo[i];
                }

                toDoList[widget.valor]["details"] = toNovo;

                saveData();

                Flushbar flushbar;
                bool _wasButtonClicked;

                flushbar = Flushbar<bool>(
                  animationDuration: Duration(milliseconds: 650),
                  message: "Tarefa removida",
                  borderRadius: size_screem * 0.05,
                  margin: EdgeInsets.only(
                    bottom: size_screem * 0.15,
                    left: size_screem * 0.1,
                    right: size_screem * 0.1,
                  ),
                  duration: Duration(seconds: 2),
                  mainButton: FlatButton(
                    child: Text(
                      "Desfazer",
                      style: TextStyle(color: Colors.amber),
                    ),
                    onPressed: () {
                      setState(() {
                        toDoList[widget.valor]["details"] = toDoAntigo;
                        saveData();
                        flushbar.dismiss(true);
                      });
                    },
                  ),
                )..show(context).then((result) {
                    setState(() {
                      _wasButtonClicked = result;
                    });
                  });
              });
            },
          ),
        ],
      ),
    );
  }

  Widget dtHr(context, index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        InkWell(
          child: Container(
            margin: EdgeInsets.only(
              top: size_screem * 0.02,
              left: size_screem * 0.02,
              right: size_screem * 0.02,
              bottom: size_screem * 0.02,
            ),
            child: Text(
              toDoList[widget.valor]["details"]["$index"] == null
                  ? "Data"
                  : toDoList[widget.valor]["details"]["$index"]["data_form"] ==
                          null
                      ? "Data"
                      : toDoList[widget.valor]["details"]["$index"]
                          ["data_form"],
              style: TextStyle(
                  color: Colors.blue[600],
                  fontSize: size_screem * 0.025,
                  fontFamily: 'Orkney-bold'),
            ),
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
                  title: toDoList[widget.valor]["details"]["$index"]["title"],
                  boolen: toDoList[widget.valor]["details"]["$index"]["bool"]);
              toDoList[widget.valor]["details"]["$index"] =
                  dataHora.calendario();
              saveData();
            });
          },
        ),
        Text(
          "-",
          style: TextStyle(
              color: Colors.blue[600],
              fontSize: size_screem * 0.025,
              fontFamily: 'Orkney-bold'),
        ),
        toDoList[widget.valor]["details"]["$index"] == null
            ? Text(
                "   Hora   ",
                style: TextStyle(
                    color: Colors.blue[600],
                    fontSize: size_screem * 0.025,
                    fontFamily: 'Orkney-bold'),
              )
            : toDoList[widget.valor]["details"]["$index"]["data_form"] == null
                ? Text(
                    "   Hora   ",
                    style: TextStyle(
                        color: Colors.blue[600],
                        fontSize: size_screem * 0.025,
                        fontFamily: 'Orkney-bold'),
                  )
                : InkWell(
                    child: Container(
                      margin: EdgeInsets.only(
                        top: size_screem * 0.02,
                        left: size_screem * 0.02,
                        right: size_screem * 0.02,
                        bottom: size_screem * 0.02,
                      ),
                      child: Text(
                        toDoList[widget.valor]["details"]["$index"]["hora"] ==
                                    "" ||
                                toDoList[widget.valor]["details"]["$index"]
                                        ["hora"] ==
                                    null
                            ? "Hora"
                            : toDoList[widget.valor]["details"]["$index"]
                                    ["hora"]
                                .toString(),
                        style: TextStyle(
                            color: Colors.blue[600],
                            fontSize: size_screem * 0.025,
                            fontFamily: 'Orkney-bold'),
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
                          toDoList[widget.valor]["details"]["$index"]["hora"] =
                              retorno;
                        } else {
                          toDoList[widget.valor]["details"]["$index"]["hora"] =
                              null;
                        }
                        saveData();
                      });
                    },
                  )
      ],
    );
  }

  Widget dtHrNovo(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        InkWell(
          child: Container(
            margin: EdgeInsets.only(
              top: size_screem * 0.02,
              left: size_screem * 0.02,
              right: size_screem * 0.02,
              bottom: size_screem * 0.02,
            ),
            child: Text(
              list_data == null
                  ? "Data"
                  : list_data["data_form"] == null
                      ? "Data"
                      : list_data["data_form"],
              style: TextStyle(
                  color: Colors.blue[600],
                  fontSize: size_screem * 0.025,
                  fontFamily: 'Orkney-bold'),
            ),
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
              );
              list_data = dataHora.calendario();
            });
          },
        ),
        Text(
          "-",
          style: TextStyle(
              color: Colors.blue[600],
              fontSize: size_screem * 0.025,
              fontFamily: 'Orkney-bold'),
        ),
        list_data == null
            ? Text(
                "   Hora   ",
                style: TextStyle(
                    color: Colors.blue[600],
                    fontSize: size_screem * 0.025,
                    fontFamily: 'Orkney-bold'),
              )
            : list_data["data_form"] == null
                ? Text(
                    "   Hora   ",
                    style: TextStyle(
                        color: Colors.blue[600],
                        fontSize: size_screem * 0.025,
                        fontFamily: 'Orkney-bold'),
                  )
                : InkWell(
                    child: Container(
                      margin: EdgeInsets.only(
                        top: size_screem * 0.02,
                        left: size_screem * 0.02,
                        right: size_screem * 0.02,
                        bottom: size_screem * 0.02,
                      ),
                      child: Text(
                        list_data["hora"] == null
                            ? "Hora"
                            : list_data["hora"].toString(),
                        style: TextStyle(
                            color: Colors.blue[600],
                            fontSize: size_screem * 0.025,
                            fontFamily: 'Orkney-bold'),
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
                          list_data["hora"] = retorno;
                        } else {
                          list_data["hora"] = null;
                        }
                      });
                    },
                  )
      ],
    );
  }

  categoryProgress(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: size_screem * 0.035,
          width: size_screem * 0.85,
          child: FAProgressBar(
            displayText: "  ",
            maxValue: done_title(),
            currentValue: done(),
            progressColor: Colors.teal[200],
          ),
        ),
      ],
    );
  }

  done() {
    int completos = 0;
    if (toDoList[widget.index]["details"].length < 1) {
      return toDoList[widget.index]["ok"] ? 1 : 0;
    }

    for (int i = 0; i < toDoList[widget.index]["details"].length; i++) {
      if (toDoList[widget.index]["details"]["$i"]["bool"]) {
        completos++;
      }
    }
    return completos;
  }

  hora(index, context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null && picked != TimeOfDay.now()) {
      toDoList[widget.valor]["details"]["$index"]["hora"] = picked
          .toString()
          .split("TimeOfDay(")
          .toList()[1]
          .split(")")[0]
          .toString();
    }
  }

  done_title() {
    return toDoList[widget.index]["details"].length < 1
        ? 1
        : toDoList[widget.index]["details"].length;
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
