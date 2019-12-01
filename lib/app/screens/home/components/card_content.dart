import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flushbar/flushbar.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:personal_flow/app/shared/notifications_helper.dart';

import 'package:personal_flow/app/shared/tree.dart';
import 'package:personal_flow/app/shared/tasks_functions.dart';
import 'package:personal_flow/app/screens/home/components/card_struct.dart';

FlutterLocalNotificationsPlugin notifications =
    new FlutterLocalNotificationsPlugin();

class CardContent extends StatefulWidget {
  CardContent(
      {Key key,
      this.valor,
      this.texto,
      this.sizeScreen,
      this.fontButton,
      this.corConcluir,
      this.index})
      : super(key: key);

  int index;
  final int valor;
  final List texto;
  final double sizeScreen;
  dynamic fontButton;
  Color corConcluir;

  _CardContentState createState() => _CardContentState();
}

class _CardContentState extends State<CardContent> {
  int index;
  List toDoList;
  double sizeScreen;
  dynamic fontButton;
  Color corConcluir;
  Map<String, dynamic> listData = Map();

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    setState(() {
      index = widget.index;
      corConcluir = widget.corConcluir;
      fontButton = widget.fontButton;
      sizeScreen = widget.sizeScreen;
      toDoList = toDoList = widget.texto;
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
              top: sizeScreen * 0.015,
              left: sizeScreen * 0.05,
              right: sizeScreen * 0.05,
              bottom: sizeScreen * 0.015),
          child: AgendarCards(
            posicao: widget.valor,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: sizeScreen * 0.01,
            right: sizeScreen * 0.01,
          ),
          child: ListTile(
            title: Text(
              "Progresso:",
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: sizeScreen * 0.03),
            child: categoryProgress(context),
          ),
        ),
        Column(
          children: <Widget>[
            Container(
              width: sizeScreen * 0.83,
              child: Column(
                children: <Widget>[
                  Column(
                      children: List<Widget>.generate(
                          toDoList[widget.valor]["details"].length,
                          (int index) => buildBody(context, index))),
                  Padding(
                    padding: EdgeInsets.only(
                      top: sizeScreen * 0.03,
                    ),
                    child: Container(
                      padding: EdgeInsets.only(
                        left: sizeScreen * 0.02,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.blue, width: sizeScreen * 0.0008),
                        borderRadius: BorderRadius.all(
                            Radius.circular(sizeScreen * 0.02)),
                      ),
                      child: ListTile(
                        title: TextField(
                          controller: controller,
                          maxLines: 8,
                          minLines: 1,
                          decoration: InputDecoration(
                            hintText: "Nova tarefa",
                            border: InputBorder.none,
                          ),
                        ),
                        subtitle: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            InkWell(
                              child: Container(
                                  padding: EdgeInsets.only(
                                    top: sizeScreen * 0.015,
                                    right: sizeScreen * 0.015,
                                    bottom: sizeScreen * 0.015,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(sizeScreen * 0.02)),
                                  ),
                                  child: listData != null
                                      ? listData["dataForm"] != null
                                          ? Text(listData["dataForm"]
                                                  .toString() +
                                              ",")
                                          : Text("Data e hora")
                                      : Text("Data e hora")),
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
                                  listData = dataHora.calendario();
                                });
                              },
                            ),
                            InkWell(
                              child: Container(
                                padding: EdgeInsets.only(
                                  top: sizeScreen * 0.015,
                                  right: sizeScreen * 0.015,
                                  bottom: sizeScreen * 0.015,
                                ),
                                child: listData != null
                                    ? listData["dataForm"] != null
                                        ? listData["hora"] != null
                                            ? Text(listData["hora"].toString())
                                            : Text("hora")
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
                                    listData["hora"] = retorno;
                                  } else {
                                    listData["hora"] = null;
                                  }
                                });
                              },
                            ),
                            listData["dataForm"] != null
                                ? InkWell(
                                    child: Container(
                                      padding: EdgeInsets.only(
                                        top: sizeScreen * 0.015,
                                        right: sizeScreen * 0.015,
                                        bottom: sizeScreen * 0.015,
                                      ),
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.red,
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        listData["hora"] = null;
                                        listData["dataForm"] = null;
                                      });
                                    },
                                  )
                                : Container(
                                    color: Colors.transparent,
                                  )
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.add_circle,
                            color: Colors.blue[600],
                          ),
                          onPressed: () {
                            setState(() {
                              if (controller.text.trim() != "") {
                                Map<String, dynamic> content = Map();
                                Composta trefa =
                                    Composta(tarefa: controller.text.trim());

                                content["title"] = controller.text.trim();
                                content["bool"] = false;
                                content["hora"] = null;
                                content["dataForm"] = null;

                                content["dtInativacao"] = null;
                                content["repeticao"] = 1;
                                content["conclusao"] = 0;
                                content["tipo"] = "subtarefa";
                                content["titleFormatado"] =
                                    trefa.formatarSubTitulo(content["title"]);

                                if (listData.length > 0) {
                                  content["hora"] = listData["hora"];
                                  content["dataForm"] = listData["dataForm"];
                                }

                                toDoList[widget.valor]["details"][
                                        "${toDoList[widget.valor]["details"].length}"] =
                                    content;
                                toDoList[widget.valor]["bool"] = false;

                                listData["hora"] = null;
                                listData["dataForm"] = null;

                                saveData();
                              }
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: sizeScreen * 0.04,
                right: sizeScreen * 0.01,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  RaisedButton(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(sizeScreen * 0.05),
                    ),
                    child: Text(
                      "Concluir",
                    ),
                    onPressed: () {
                      setState(() {
                        if (!toDoList[index]["bool"]) {
                          toDoList[index]["bool"] = true;
                          toDoList[index]["conclusao"] = 1;

                          List<bool> antigo = [];

                          for (int i = 0;
                              i < toDoList[index]["details"].length;
                              i++) {
                            antigo
                                .add(toDoList[index]["details"]["$i"]["bool"]);
                            toDoList[index]["details"]["$i"]["bool"] = true;
                            toDoList[index]["details"]["$i"]["conclusao"] = 1;
                          }

                          saveData();

                          Flushbar flushbar;
                          bool _wasButtonClicked;

                          flushbar = Flushbar<bool>(
                            animationDuration: Duration(milliseconds: 650),
                            message: "Tarefa concluída",
                            borderRadius: sizeScreen * 0.05,
                            margin: EdgeInsets.only(
                              bottom: sizeScreen * 0.15,
                              left: sizeScreen * 0.1,
                              right: sizeScreen * 0.1,
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
                                    toDoList[index]["details"]["$i"]
                                        ["conclusao"] = 0;
                                  }
                                  toDoList[index]["bool"] = false;
                                  toDoList[index]["conclusao"] = 0;

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
              height: sizeScreen * 0.02,
            ),
          ],
        ),
      ],
    );
  }

  Widget buildBody(context, index) {
    Informacoes informacoes =
        Informacoes(toDoList: toDoList, index: widget.valor, indexSub: index);
    String title_sub = informacoes.titleSub();
    bool boolSub = informacoes.boolSub();

    return toDoList[widget.valor]["details"]["$index"]["dtInativacao"] == null ? Card(
      elevation: 0,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue, width: sizeScreen * 0.0008),
          borderRadius: BorderRadius.all(Radius.circular(sizeScreen * 0.02)),
        ),
        child: Slidable(
          actionPane: SlidableDrawerActionPane(),
          child: ListTile(
            title: Text(toDoList[widget.valor]["details"]["$index"]["title"]),
            subtitle: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                InkWell(
                  child: Container(
                    padding: EdgeInsets.only(
                      top: sizeScreen * 0.015,
                      right: sizeScreen * 0.015,
                      bottom: sizeScreen * 0.015,
                    ),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.all(Radius.circular(sizeScreen * 0.02)),
                    ),
                    child: toDoList[widget.valor]["details"]["$index"]
                                ["dataForm"] ==
                            null
                        ? Text("Data e hora")
                        : Text(toDoList[widget.valor]["details"]["$index"]
                                ["dataForm"] +
                            ","),
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
                          title: toDoList[widget.valor]["details"]["$index"]
                              ["title"],
                          boolen: toDoList[widget.valor]["details"]["$index"]
                              ["bool"]);
                      toDoList[widget.valor]["details"]["$index"] =
                          dataHora.calendario();
                    });
                  },
                ),
                InkWell(
                  child: Container(
                    padding: EdgeInsets.only(
                      top: sizeScreen * 0.015,
                      right: sizeScreen * 0.015,
                      bottom: sizeScreen * 0.015,
                    ),
                    child: toDoList[widget.valor]["details"]["$index"] != null
                        ? toDoList[widget.valor]["details"]["$index"]
                                    ["dataForm"] !=
                                null
                            ? toDoList[widget.valor]["details"]["$index"]
                                        ["hora"] ==
                                    null
                                ? Text("hora")
                                : Text(toDoList[widget.valor]["details"]
                                        ["$index"]["hora"]
                                    .toString())
                            : Container(
                                color: Colors.transparent,
                              )
                        : Container(
                            color: Colors.transparent,
                          ),
                  ),
                  onTap: () async {
                    List<String> backup = [];

                    final TimeOfDay picked = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );

                    backup.add(toDoList[widget.valor]["details"]["$index"]
                        ["dataForm"]);
                    backup.add(
                        toDoList[widget.valor]["details"]["$index"]["hora"]);

                    setState(() {
                      DataHora dataHora = DataHora(picked: picked);
                      String retorno = dataHora.hora();
                      if (retorno != null) {
                        toDoList[widget.valor]["details"]["$index"]["hora"] =
                            retorno;
                      } else {
                        toDoList[widget.valor]["details"]["$index"]["hora"] =
                            null;
                      }

                      if (backup[0] != toDoList[widget.valor]["dataForm"]) {
                        Notificacao notificacao = Notificacao(
                            tarefa: toDoList[widget.valor],
                            notifications: notifications,
                            idChanel: toDoList[widget.valor]["idChanel"],
                            agendadas: toDoList[widget.valor]["agendada"]
                                ? toDoList[widget.valor]["diasAgendados"]
                                : [false]);

                        notificacao.filtro();
                      }
                    });
                  },
                ),
                toDoList[widget.valor]["details"]["$index"]["dataForm"] != null
                    ? InkWell(
                        child: Container(
                          padding: EdgeInsets.only(
                            top: sizeScreen * 0.015,
                            right: sizeScreen * 0.015,
                            bottom: sizeScreen * 0.015,
                          ),
                          child: Icon(
                            Icons.close,
                            color: Colors.red,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            toDoList[widget.valor]["details"]["$index"]
                                ["hora"] = null;
                            toDoList[widget.valor]["details"]["$index"]
                                ["dataForm"] = null;
                          });
                        },
                      )
                    : Container(
                        color: Colors.transparent,
                      )
              ],
            ),
            trailing: boolSub
                ? IconButton(
                    icon: Icon(
                      Icons.check,
                      color: Colors.teal,
                    ),
                    onPressed: () {
                      setState(() {
                        toDoList = informacoes.stateIconLead();
                        saveData();
                      });
                    },
                  )
                : IconButton(
                    icon: Icon(
                      Icons.panorama_fish_eye,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      setState(() {
                        toDoList = informacoes.stateIconTrai();
                        saveData();
                      });
                    },
                  ),
            onTap: () {
              modal(context, index, sizeScreen);
            },
          ),
          secondaryActions: <Widget>[
            IconSlideAction(
              caption: "Excluir",
              color: Colors.transparent,
              icon: Icons.delete,
              foregroundColor: Colors.red,
              onTap: () {
                setState(() {
                  int valor = 0;

                  toDoList[widget.valor]["details"]["$index"]["dtInativacao"] =
                      111;

                  saveData();

                  Flushbar flushbar;
                  bool _wasButtonClicked;

                  flushbar = Flushbar<bool>(
                    animationDuration: Duration(milliseconds: 650),
                    message: "Subtarefa removida",
                    borderRadius: sizeScreen * 0.05,
                    margin: EdgeInsets.only(
                      bottom: sizeScreen * 0.15,
                      left: sizeScreen * 0.1,
                      right: sizeScreen * 0.1,
                    ),
                    duration: Duration(seconds: 2),
                    mainButton: FlatButton(
                      child: Text(
                        "Desfazer",
                        style: TextStyle(color: Colors.amber),
                      ),
                      onPressed: () {
                        setState(() {
                          toDoList[widget.valor]["details"]["$index"]
                              ["dtInativacao"] = null;
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
      ),
    ) : Container(color: Colors.transparent,);
  }

  Widget dtHrNovo(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        InkWell(
          child: Container(
            margin: EdgeInsets.only(
              top: sizeScreen * 0.02,
              left: sizeScreen * 0.02,
              right: sizeScreen * 0.02,
              bottom: sizeScreen * 0.02,
            ),
            child: Text(
              listData["dataForm"] == null ? "Data" : listData["dataForm"],
              style: TextStyle(
                  color: Colors.blue[600],
                  fontSize: sizeScreen * 0.025,
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
              listData = dataHora.calendario();
            });
          },
        ),
        Text(
          "-",
          style: TextStyle(
              color: Colors.blue[600],
              fontSize: sizeScreen * 0.025,
              fontFamily: 'Orkney-bold'),
        ),
        listData["dataForm"] == null
            ? Text(
                "   Hora   ",
                style: TextStyle(
                    color: Colors.blue[600],
                    fontSize: sizeScreen * 0.025,
                    fontFamily: 'Orkney-bold'),
              )
            : InkWell(
                child: Container(
                  margin: EdgeInsets.only(
                    top: sizeScreen * 0.02,
                    left: sizeScreen * 0.02,
                    right: sizeScreen * 0.02,
                    bottom: sizeScreen * 0.02,
                  ),
                  child: Text(
                    listData["hora"] == null
                        ? "Hora"
                        : listData["hora"].toString(),
                    style: TextStyle(
                        color: Colors.blue[600],
                        fontSize: sizeScreen * 0.025,
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
                      listData["hora"] = retorno;
                    } else {
                      listData["hora"] = null;
                    }
                  });
                },
              )
      ],
    );
  }

  categoryProgress(BuildContext context) {
    return Container(
      height: sizeScreen * 0.025,
      width: sizeScreen * 0.8,
      child: FAProgressBar(
        maxValue: doneTitle(),
        currentValue: done(),
        progressColor: Colors.teal,
        backgroundColor: Colors.transparent,
      ),
    );
  }

  done() {
    int completos = 0;
    if (toDoList[widget.index]["details"].length < 1) {
      return toDoList[widget.index]["bool"] ? 1 : 0;
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

  doneTitle() {
    return toDoList[widget.index]["details"].length < 1
        ? 1
        : toDoList[widget.index]["details"].length;
  }

  modal(context, index, sizeScreen) {
    TextEditingController controllerText = TextEditingController(
        text: toDoList[widget.valor]["details"]["$index"]["title"]);

    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(sizeScreen * 0.04),
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
                  height: sizeScreen * 0.05,
                  color: Colors.transparent,
                ),
                Text(
                  "Editor de Subtarefas",
                  style: TextStyle(
                    fontSize: sizeScreen * 0.04,
                  ),
                ),
                Divider(
                  height: sizeScreen * 0.05,
                  color: Colors.transparent,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.blue, width: sizeScreen * 0.0008),
                        borderRadius: BorderRadius.all(
                            Radius.circular(sizeScreen * 0.02)),
                      ),
                      width: sizeScreen * 0.65,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: sizeScreen * 0.015,
                            right: sizeScreen * 0.015),
                        child: TextField(
                          controller: controllerText,
                          decoration: InputDecoration(
                            hintText: "Título",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    Card(
                      color: Colors.blue,
                      elevation: 0,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(sizeScreen * 0.02),
                      ),
                      child: InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.blue,
                                width: sizeScreen * 0.0008),
                            borderRadius: BorderRadius.all(
                                Radius.circular(sizeScreen * 0.02)),
                          ),
                          padding: EdgeInsets.all(sizeScreen * 0.03),
                          child: Text(
                            "Salvar",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            if (controllerText.text.trim().isNotEmpty) {
                              toDoList[widget.valor]["details"]["$index"]
                                  ["title"] = controllerText.text;
                              saveData();
                              Navigator.pop(context);
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: sizeScreen * 0.05,
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
