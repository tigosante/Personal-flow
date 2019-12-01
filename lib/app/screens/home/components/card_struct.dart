import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flushbar/flushbar.dart';
import 'package:expandable/expandable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:personal_flow/app/shared/tasks_functions.dart';
import 'package:personal_flow/app/screens/new_task/new_task.dart';
import 'package:personal_flow/app/screens/home/components/card_content.dart';
import 'package:personal_flow/app/screens/home/components/card_content_unica.dart';

// Variáveis gerais.

Color cortarefa = Colors.grey;
double sizeScreen = 0;
String fontButton;

List toDoList = [];
List<String> dias = [
  "Dom",
  "Seg",
  "Ter",
  "Qua",
  "Qui",
  "Sex",
  "Sáb",
];


class CardStruct extends StatefulWidget {
  CardStruct({Key key}) : super(key: key);

  @override
  _CardStructState createState() => new _CardStructState();
}

class _CardStructState extends State<CardStruct> {

  FlutterLocalNotificationsPlugin notifications =
      new FlutterLocalNotificationsPlugin();

  @override
  initState() {
    super.initState();
    readyData().then((data) {
      setState(() {
        toDoList = jsonDecode(data);
      });
    });

    var android = new AndroidInitializationSettings('logo_app');

    var ios = new IOSInitializationSettings();

    var initSettings = new InitializationSettings(android, ios);

    notifications.initialize(initSettings, onSelectNotification: null);
  }

  @override
  Widget build(context) {
    GeneratioCards genaratioCards = GeneratioCards(contextScreen: context);
    setState(() {
      sizeScreen = MediaQuery.of(context).size.width;
      fontButton = genaratioCards.outFontButton;
    });

    bool validar() {
      for (int i = 0; i < toDoList.length; i++) {
        if (toDoList[i]["dtInativacao"] == null) {
          return false;
        }
      }
      return true;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Personal Flow",
          style: TextStyle(
            color: Colors.blue,
            fontFamily: 'orkey-bold',
            fontSize: sizeScreen * 0.05,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: validar()
                  ? Center(
                      child: Icon(
                        Icons.check,
                        size: sizeScreen * 0.4,
                        color: Colors.grey[300],
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.only(
                        top: sizeScreen * 0.04,
                      ),
                      itemCount: toDoList.length,
                      itemBuilder: (BuildContext context, int index) =>
                          toDoList[index]["tipo"] == "simples"
                              ? toDoList[index]["dtInativacao"] == null
                                  ? buildCardUnica(
                                      context, fontButton, toDoList, index)
                                  : Container(
                                      color: Colors.transparent,
                                    )
                              : toDoList[index]["dtInativacao"] == null
                                  ? buildCardGrupo(
                                      context, index, fontButton, toDoList)
                                  : Container(
                                      color: Colors.transparent,
                                    ),
                    )),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        clipBehavior: Clip.antiAlias,
        backgroundColor: Colors.blue,
        label: Text(
          "Nova tarefa",
          style: TextStyle(color: Colors.white, fontFamily: 'Orkney-bold'),
        ),
        icon: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () async {
          var retorno = await Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => NewTask(
                  toDoList: toDoList,
                  notifications: notifications,
                ),
              ));
          if (retorno != null) {
            toDoList = retorno;
            saveData();
          }
        },
      ),
    );
  }

  Widget buildCardUnica(BuildContext context, fontButton, toDo, index) {
    return Center(
      child: Card(
        elevation: 0,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(sizeScreen * 0.04),
        ),
        child: Container(
          width: sizeScreen * 0.9,
          decoration: BoxDecoration(
              border:
                  Border.all(color: Colors.blue, width: sizeScreen * 0.0008),
              borderRadius:
                  BorderRadius.all(Radius.circular(sizeScreen * 0.04))),
          child: Slidable(
            actionPane: SlidableDrawerActionPane(),
            child: Container(
              child: CardContentUnica(
                valor: index,
                texto: toDo,
                sizeScreen: sizeScreen,
                fontButton: fontButton,
                index: index,
              ),
            ),
            secondaryActions: <Widget>[
              IconSlideAction(
                caption: "Excluir",
                color: Colors.transparent,
                icon: Icons.delete,
                foregroundColor: Colors.red,
                onTap: () {
                  setState(() {
                    int lastRemovedPos;
                    Map<String, dynamic> lastRemoved;

                    toDoList[index]["dtInativacao"] = 111;

                    saveData();

                    Flushbar flushbar;
                    bool _wasButtonClicked;

                    flushbar = Flushbar<bool>(
                      animationDuration: Duration(milliseconds: 650),
                      message: "Tarefa removida",
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
                            toDoList[index]["dtInativacao"] = null;
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
      ),
    );
  }

  Widget buildCardGrupo(BuildContext context, index, fontButton, toDo) {
    Buttons buttons =
        Buttons(toDoList: toDoList, index: index, context: context);
    Color corConcluir = buttons.corConcluir();

    return Center(
      child: Card(
        elevation: 0,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(sizeScreen * 0.04),
        ),
        child: Container(
          width: sizeScreen * 0.9,
          decoration: BoxDecoration(
              border:
                  Border.all(color: Colors.blue, width: sizeScreen * 0.0008),
              borderRadius:
                  BorderRadius.all(Radius.circular(sizeScreen * 0.04))),
          child: Slidable(
            actionPane: SlidableDrawerActionPane(),
            child: Container(
              child: Column(
                children: <Widget>[
                  ExpandablePanel(
                    header: Container(
                        padding: EdgeInsets.only(
                          top: sizeScreen * 0.005,
                          bottom: sizeScreen * 0.005,
                        ),
                        child: InkWell(
                            child: ListTile(
                              title: Text(toDo[index]["title"]),
                            ),
                            onTap: () {
                              modal(context, index);
                            })),
                    expanded: CardContent(
                      valor: index,
                      texto: toDo,
                      sizeScreen: sizeScreen,
                      fontButton: fontButton,
                      corConcluir: corConcluir,
                      index: index,
                    ),
                  ),
                ],
              ),
            ),
            secondaryActions: <Widget>[
              IconSlideAction(
                caption: "Excluir",
                color: Colors.transparent,
                icon: Icons.delete,
                foregroundColor: Colors.red,
                onTap: () {
                  setState(() {
                    int lastRemovedPos;
                    Map<String, dynamic> lastRemoved;

                    toDoList[index]["dtInativacao"] = 111;

                    saveData();

                    Flushbar flushbar;
                    bool _wasButtonClicked;

                    flushbar = Flushbar<bool>(
                      animationDuration: Duration(milliseconds: 650),
                      message: "Tarefa removida",
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
                            toDoList[index]["dtInativacao"] = null;
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
      ),
    );
  }

  modal(context, index) {
    TextEditingController controllerText =
        TextEditingController(text: toDoList[index]["title"]);

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
                  "Editor de Título",
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
                              toDoList[index]["title"] = controllerText.text;
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

  Future<String> readyData() async {
    try {
      final file = await getFile();

      return file.readAsString();
    } catch (e) {
      return null;
    }
  }

  Future<File> getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }
}

class AgendarCards extends StatefulWidget {
  AgendarCards({Key key, this.posicao, t}) : super(key: key);

  int posicao;

  @override
  _AgendarCardsState createState() => _AgendarCardsState();
}

class _AgendarCardsState extends State<AgendarCards> {
  @override
  Widget build(BuildContext context) {
    for (int i = 0;
        i < toDoList[widget.posicao]["diasAgendados"].length;
        i++) {
      if (toDoList[widget.posicao]["diasAgendados"][i]) {
        toDoList[widget.posicao]["agendada"] = true;

        if (toDoList[widget.posicao]["dataAgenda"] != null ||
            toDoList[widget.posicao]["dataAgenda"] != "") {
          cortarefa = Colors.blue;
        }
        break;
      } else {
        toDoList[widget.posicao]["agendada"] = false;
        cortarefa = Colors.grey;
        if (1 == toDoList[widget.posicao]["diasAgendados"].length - 1) {
          toDoList[widget.posicao]["dataAgenda"] =
              "Definir data final desta tarefa.";
        }
      }
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: sizeScreen * 0.0008),
        borderRadius: BorderRadius.all(Radius.circular(sizeScreen * 0.04)),
      ),
      child: Card(
        elevation: 0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: sizeScreen * 0.015,
                bottom: sizeScreen * 0.015,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List<Widget>.generate(7, (dia) {
                        return InkWell(
                          child: Container(
                            padding: EdgeInsets.all(sizeScreen * 0.008),
                            child: Text(
                              dias[dia],
                              style: TextStyle(
                                  color: toDoList[widget.posicao]
                                          ["diasAgendados"][dia]
                                      ? Colors.blue
                                      : Colors.grey),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              toDoList[widget.posicao]["diasAgendados"][dia] =
                                  !toDoList[widget.posicao]["diasAgendados"]
                                      [dia];

                              if (toDoList[widget.posicao]["diasAgendados"]
                                  [dia]) {
                                toDoList[widget.posicao]["agendada"] = true;
                              }

                              int contador = 0;

                              for (int i = 0;
                                  i <
                                      toDoList[widget.posicao]["diasAgendados"]
                                          .length;
                                  i++) {
                                if (!toDoList[widget.posicao]["diasAgendados"]
                                    [i]) {
                                  contador++;
                                }
                              }

                              if (contador ==
                                  toDoList[widget.posicao]["diasAgendados"]
                                      .length) {
                                toDoList[widget.posicao]["agendada"] = false;
                                toDoList[widget.posicao]["dataAgenda"] =
                                    "Definir data final desta tarefa.";
                                cortarefa = Colors.grey;
                              }
                            });
                          },
                        );
                      })),
                ],
              ),
            ),
            InkWell(
              child: Container(
                  padding: EdgeInsets.all(sizeScreen * 0.008),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: sizeScreen * 0.03),
                        child: Text(
                          toDoList[widget.posicao]["agendada"]
                              ? toDoList[widget.posicao]["dataAgenda"] !=
                                          null &&
                                      toDoList[widget.posicao]["dataAgenda"] !=
                                          ""
                                  ? toDoList[widget.posicao]["dataAgenda"]
                                  : "Definir data final desta tarefa."
                              : "Definir data final desta tarefa.",
                          style: TextStyle(color: cortarefa),
                        ),
                      ),
                    ],
                  )),
              onTap: () async {
                bool verificar = false;
                for (int i = 0;
                    i < toDoList[widget.posicao]["diasAgendados"].length;
                    i++) {
                  if (toDoList[widget.posicao]["diasAgendados"][i]) {
                    verificar = true;
                  }
                }
                if (verificar) {
                  final DateTime picked = await showDatePicker(
                    context: context,
                    firstDate: new DateTime(2000),
                    lastDate: new DateTime(2030),
                    initialDate: new DateTime.now(),
                  );
                  setState(() {
                    AgendarData agendamento = AgendarData(
                      picked: picked,
                    );
                    toDoList[widget.posicao]["agendada"] = picked == null;
                    toDoList[widget.posicao]["dataAgenda"] =
                        agendamento.dataAgendamento();

                    cortarefa = toDoList[widget.posicao]["agendada"]
                        ? Colors.grey
                        : Colors.blue;
                  });
                } else {
                  Flushbar flushbar;
                  bool _wasButtonClicked;

                  flushbar = Flushbar<bool>(
                    icon: Icon(
                      Icons.error_outline,
                      color: Colors.amber,
                    ),
                    animationDuration: Duration(milliseconds: 450),
                    message: "Escolha algum dia para agendar.",
                    borderRadius: sizeScreen * 0.05,
                    margin: EdgeInsets.only(
                      bottom: sizeScreen * 0.15,
                      left: sizeScreen * 0.1,
                      right: sizeScreen * 0.1,
                    ),
                    duration: Duration(seconds: 2),
                  )..show(context).then((result) {
                      setState(() {
                        _wasButtonClicked = result;
                      });
                    });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
