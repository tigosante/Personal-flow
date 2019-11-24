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

Color cor_tarefa = Colors.grey;
double size_screen = 0;
String font_button;

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

Icon actionIcon = Icon(
  Icons.search,
  color: Colors.blue,
);

Widget appBarTitle = Text(
  "Personal Flow",
  style: TextStyle(
    color: Colors.blue,
    fontFamily: 'orkey-bold',
    fontSize: size_screen * 0.05,
  ),
);

class CardStruct extends StatefulWidget {
  CardStruct({Key key}) : super(key: key);

  @override
  _CardStructState createState() => new _CardStructState();
}

class _CardStructState extends State<CardStruct> {
  final TextEditingController _searchQuery = new TextEditingController();
  List<String> _list = List<String>();
  bool _IsSearching;
  String _searchText = "";
  int valor_pesquisa = 0;

  _CardStructState() {
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _IsSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _IsSearching = true;
          _searchText = _searchQuery.text;
        });
      }
    });
  }

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

    _IsSearching = false;
  }

  @override
  Widget build(context) {
    GeneratioCards genaratioCards = GeneratioCards(context_screen: context);
    setState(() {
      size_screen = MediaQuery.of(context).size.width;
      font_button = genaratioCards.outFontButton;
    });

    bool validar() {
      for (int i = 0; i < toDoList.length; i++) {
        if (toDoList[i]["dt_inativacao"] == null) {
          return false;
        }
      }
      return true;
    }

    return Scaffold(
      appBar: buildBar(context),
      body: Column(
        children: <Widget>[
          Expanded(
              child: validar()
                  ? Center(
                      child: Icon(
                        Icons.check,
                        size: size_screen * 0.4,
                        color: Colors.grey[300],
                      ),
                    )
                  : _IsSearching
                      ? buildpesquisa()
                      : ListView.builder(
                          padding: EdgeInsets.only(
                            top: size_screen * 0.04,
                          ),
                          itemCount: toDoList.length,
                          itemBuilder: (BuildContext context, int index) =>
                              toDoList[index]["tipo"] == "simples"
                                  ? toDoList[index]["dt_inativacao"] == null
                                      ? buildCardUnica(
                                          context, font_button, toDoList, index)
                                      : Container(
                                          color: Colors.transparent,
                                        )
                                  : toDoList[index]["dt_inativacao"] == null
                                      ? buildCardGrupo(
                                          context, index, font_button, toDoList)
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

  Widget buildCardUnica(BuildContext context, font_button, toDo, index) {
    return Center(
      child: Card(
        elevation: 0,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(size_screen * 0.04),
        ),
        child: Container(
          width: size_screen * 0.9,
          decoration: BoxDecoration(
              border:
                  Border.all(color: Colors.blue, width: size_screen * 0.0008),
              borderRadius:
                  BorderRadius.all(Radius.circular(size_screen * 0.04))),
          child: Slidable(
            actionPane: SlidableDrawerActionPane(),
            child: Container(
              child: CardContentUnica(
                valor: index,
                texto: toDo,
                size_screen: size_screen,
                font_button: font_button,
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

                    toDoList[index]["dt_inativacao"] = 111;

                    saveData();

                    Flushbar flushbar;
                    bool _wasButtonClicked;

                    flushbar = Flushbar<bool>(
                      animationDuration: Duration(milliseconds: 650),
                      message: "Tarefa removida",
                      borderRadius: size_screen * 0.05,
                      margin: EdgeInsets.only(
                        bottom: size_screen * 0.15,
                        left: size_screen * 0.1,
                        right: size_screen * 0.1,
                      ),
                      duration: Duration(seconds: 2),
                      mainButton: FlatButton(
                        child: Text(
                          "Desfazer",
                          style: TextStyle(color: Colors.amber),
                        ),
                        onPressed: () {
                          setState(() {
                            toDoList[index]["dt_inativacao"] = null;
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

  Widget buildCardGrupo(BuildContext context, index, font_button, toDo) {
    Buttons buttons =
        Buttons(toDoList: toDoList, index: index, context: context);
    Color corConcluir = buttons.cor_concluir();

    return Center(
      child: Card(
        elevation: 0,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(size_screen * 0.04),
        ),
        child: Container(
          width: size_screen * 0.9,
          decoration: BoxDecoration(
              border:
                  Border.all(color: Colors.blue, width: size_screen * 0.0008),
              borderRadius:
                  BorderRadius.all(Radius.circular(size_screen * 0.04))),
          child: Slidable(
            actionPane: SlidableDrawerActionPane(),
            child: Container(
              child: Column(
                children: <Widget>[
                  ExpandablePanel(
                    header: Container(
                        padding: EdgeInsets.only(
                          top: size_screen * 0.005,
                          bottom: size_screen * 0.005,
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
                      size_screen: size_screen,
                      font_button: font_button,
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

                    toDoList[index]["dt_inativacao"] = 111;

                    saveData();

                    Flushbar flushbar;
                    bool _wasButtonClicked;

                    flushbar = Flushbar<bool>(
                      animationDuration: Duration(milliseconds: 650),
                      message: "Tarefa removida",
                      borderRadius: size_screen * 0.05,
                      margin: EdgeInsets.only(
                        bottom: size_screen * 0.15,
                        left: size_screen * 0.1,
                        right: size_screen * 0.1,
                      ),
                      duration: Duration(seconds: 2),
                      mainButton: FlatButton(
                        child: Text(
                          "Desfazer",
                          style: TextStyle(color: Colors.amber),
                        ),
                        onPressed: () {
                          setState(() {
                            toDoList[index]["dt_inativacao"] = null;
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
    TextEditingController controller_text =
        TextEditingController(text: toDoList[index]["title"]);

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
                  "Editor de Título",
                  style: TextStyle(
                    fontSize: size_screen * 0.04,
                  ),
                ),
                Divider(
                  height: size_screen * 0.05,
                  color: Colors.transparent,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.blue, width: size_screen * 0.0008),
                        borderRadius: BorderRadius.all(
                            Radius.circular(size_screen * 0.02)),
                      ),
                      width: size_screen * 0.65,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: size_screen * 0.015,
                            right: size_screen * 0.015),
                        child: TextField(
                          controller: controller_text,
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
                        borderRadius: BorderRadius.circular(size_screen * 0.02),
                      ),
                      child: InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.blue,
                                width: size_screen * 0.0008),
                            borderRadius: BorderRadius.all(
                                Radius.circular(size_screen * 0.02)),
                          ),
                          padding: EdgeInsets.all(size_screen * 0.03),
                          child: Text(
                            "Salvar",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            if (controller_text.text.trim().isNotEmpty) {
                              toDoList[index]["title"] = controller_text.text;
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

  Widget buildBar(BuildContext context) {
    return new AppBar(
        title: appBarTitle,
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        actions: <Widget>[
          new IconButton(
            icon: actionIcon,
            onPressed: () {
              setState(() {
                if (actionIcon.icon == Icons.search) {
                  actionIcon = Icon(
                    Icons.close,
                    color: Colors.red,
                  );
                  appBarTitle = TextField(
                    controller: _searchQuery,
                    decoration: InputDecoration(
                        hintStyle: TextStyle(
                          color: Colors.blue,
                        ),
                        hintText: "Digite algo",
                        border: InputBorder.none),
                  );
                  _handleSearchStart();
                } else {
                  _handleSearchEnd();
                }
              });
            },
          ),
        ]);
  }

  dynamic buildpesquisa() {
    List<dynamic> toDoLi = toDoList;
    if (_searchText.isEmpty) {
      return ListView.builder(
        padding: EdgeInsets.only(
          top: size_screen * 0.04,
        ),
        itemCount: toDoLi.length,
        itemBuilder: (BuildContext context, int index) =>
            toDoList[index]["tipo"] == "simples"
                ? toDoList[index]["dt_inativacao"] == null
                    ? buildCardUnica(context, font_button, toDoList, index)
                    : Container(
                        color: Colors.transparent,
                      )
                : toDoList[index]["dt_inativacao"] == null
                    ? buildCardGrupo(context, index, font_button, toDoList)
                    : Container(
                        color: Colors.transparent,
                      ),
      );
    } else {
      List<Map<String, dynamic>> toDo = List();
      for (int index = 0; index < toDoList.length; index++) {
        String titulo = toDoList[index]["title"];
        if (titulo.toLowerCase().contains(_searchText.toLowerCase())) {
          toDo.add(toDoList[index]);
          break;
        }
        if (toDoList[index]["tipo"] == "composta") {
          for (int j = 0; j < toDoList[index]["details"].length; j++) {
            if (toDoList[index]["details"]["$j"]["title"]
                .toLowerCase()
                .contains(_searchText.toLowerCase())) {
              toDo.add(toDoList[index]);
              break;
            }
            if (toDoList[index]["details"]["$j"]["data_form"] != null) {
              if (toDoList[index]["details"]["$j"]["data_form"]
                  .toLowerCase()
                  .contains(_searchText.toLowerCase())) {
                toDo.add(toDoList[index]);
                break;
              }
            }
            if (toDoList[index]["details"]["$j"]["hora"] != null) {
              if (toDoList[index]["details"]["$j"]["hora"]
                  .toLowerCase()
                  .contains(_searchText.toLowerCase())) {
                toDo.add(toDoList[index]);
                break;
              }
            }
          }
        }
      }
      return ListView.builder(
        padding: EdgeInsets.only(
          top: size_screen * 0.04,
        ),
        itemCount: toDo.length,
        itemBuilder: (BuildContext context, int index) =>
            toDoList[index]["tipo"] == "simples"
                ? buildCardUnica(context, font_button, toDoList, index)
                : buildCardGrupo(context, index, font_button, toDoList),
      );
    }
  }

  void _handleSearchStart() {
    setState(() {
      _IsSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      actionIcon = new Icon(
        Icons.search,
        color: Colors.blue,
      );
      appBarTitle = new Text(
        "Personal Flow",
        style: TextStyle(
          color: Colors.blue,
          fontFamily: 'orkey-bold',
          fontSize: size_screen * 0.05,
        ),
      );
      _IsSearching = false;
      _searchQuery.clear();
    });
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
        i < toDoList[widget.posicao]["dias_agendados"].length;
        i++) {
      if (toDoList[widget.posicao]["dias_agendados"][i]) {
        toDoList[widget.posicao]["agendada"] = true;

        if (toDoList[widget.posicao]["data_agenda"] != null ||
            toDoList[widget.posicao]["data_agenda"] != "") {
          cor_tarefa = Colors.blue;
        }
        break;
      } else {
        toDoList[widget.posicao]["agendada"] = false;
        cor_tarefa = Colors.grey;
        if (1 == toDoList[widget.posicao]["dias_agendados"].length - 1) {
          toDoList[widget.posicao]["data_agenda"] =
              "Definir data final desta tarefa.";
        }
      }
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: size_screen * 0.0008),
        borderRadius: BorderRadius.all(Radius.circular(size_screen * 0.04)),
      ),
      child: Card(
        elevation: 0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: size_screen * 0.015,
                bottom: size_screen * 0.015,
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
                            padding: EdgeInsets.all(size_screen * 0.008),
                            child: Text(
                              dias[dia],
                              style: TextStyle(
                                  color: toDoList[widget.posicao]
                                          ["dias_agendados"][dia]
                                      ? Colors.blue
                                      : Colors.grey),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              toDoList[widget.posicao]["dias_agendados"][dia] =
                                  !toDoList[widget.posicao]["dias_agendados"]
                                      [dia];

                              if (toDoList[widget.posicao]["dias_agendados"]
                                  [dia]) {
                                toDoList[widget.posicao]["agendada"] = true;
                              }

                              int contador = 0;

                              for (int i = 0;
                                  i <
                                      toDoList[widget.posicao]["dias_agendados"]
                                          .length;
                                  i++) {
                                if (!toDoList[widget.posicao]["dias_agendados"]
                                    [i]) {
                                  contador++;
                                }
                              }

                              if (contador ==
                                  toDoList[widget.posicao]["dias_agendados"]
                                      .length) {
                                toDoList[widget.posicao]["agendada"] = false;
                                toDoList[widget.posicao]["data_agenda"] =
                                    "Definir data final desta tarefa.";
                                cor_tarefa = Colors.grey;
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
                  padding: EdgeInsets.all(size_screen * 0.008),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: size_screen * 0.03),
                        child: Text(
                          toDoList[widget.posicao]["agendada"]
                              ? toDoList[widget.posicao]["data_agenda"] !=
                                          null &&
                                      toDoList[widget.posicao]["data_agenda"] !=
                                          ""
                                  ? toDoList[widget.posicao]["data_agenda"]
                                  : "Definir data final desta tarefa."
                              : "Definir data final desta tarefa.",
                          style: TextStyle(color: cor_tarefa),
                        ),
                      ),
                    ],
                  )),
              onTap: () async {
                bool verificar = false;
                for (int i = 0;
                    i < toDoList[widget.posicao]["dias_agendados"].length;
                    i++) {
                  if (toDoList[widget.posicao]["dias_agendados"][i]) {
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
                    toDoList[widget.posicao]["data_agenda"] =
                        agendamento.data_agendamento();

                    cor_tarefa = toDoList[widget.posicao]["agendada"]
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
                    borderRadius: size_screen * 0.05,
                    margin: EdgeInsets.only(
                      bottom: size_screen * 0.15,
                      left: size_screen * 0.1,
                      right: size_screen * 0.1,
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
