import 'dart:convert';
import 'dart:io';

import 'package:expandable/expandable.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:personal_flow/app/screens/home/components/card_content.dart';
import 'package:personal_flow/app/screens/home/components/card_content_unica.dart';
import 'package:personal_flow/app/screens/new_task/new_task.dart';
import 'package:personal_flow/app/shared/tasks_functions.dart';

class CardStruct extends StatefulWidget {
  CardStruct({Key key}) : super(key: key);

  @override
  _CardStructState createState() => new _CardStructState();
}

Widget appBarTitle = Text(
  "Personal Flow",
  style: TextStyle(
    color: Colors.blue,
    fontFamily: 'orkey-bold',
    fontSize: size_screen * 0.05,
  ),
);
Icon actionIcon = Icon(
  Icons.search,
  color: Colors.blue,
);

double size_screen = 0;
String font_button;

int arquivo = 0;

class _CardStructState extends State<CardStruct> {
  List toDoList = [];
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

  @override
  initState() {
    super.initState();
    readyData().then((data) {
      setState(() {
        toDoList = jsonDecode(data);
      });
    });

    _IsSearching = false;
    for (int index; index<toDoList.length; index++){
      arquivo += toDoList[index]["dt_inativacao"] == null ? 1 : 0;
    }
  }

  @override
  Widget build(context) {
    GeneratioCards genaratioCards = GeneratioCards(context_screen: context);
    setState(() {
      size_screen = MediaQuery.of(context).size.width;
      font_button = genaratioCards.outFontButton;
    });

    return Scaffold(
      appBar: buildBar(context),
      body: Column(
        children: <Widget>[
          Expanded(
            child: arquivo < 1
                ? Center(
                    child: Image.asset(
                    "assets/no_tasks.png",
                    height: size_screen * 0.5,
                    width: size_screen * 0.5,
                  ))
                : _IsSearching
                    ? buildpesquisa()
                    : ListView.builder(
                        padding: EdgeInsets.only(
                          top: size_screen * 0.04,
                        ),
                        itemCount: toDoList.length,
                        itemBuilder: (BuildContext context, int index) =>
                            toDoList[index]["tipo"] == "simples"
                                ? toDoList[index]["dt_inativacao"] == null ? buildCardUnica(
                                    context, font_button, toDoList, index) : Container(color: Colors.transparent,)
                                : toDoList[index]["dt_inativacao"] == null ? buildCardGrupo(
                                    context, index, font_button, toDoList) : Container(color: Colors.transparent,),
                      ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        elevation: 5,
        clipBehavior: Clip.antiAlias,
        backgroundColor: Colors.white,
        label: Text(
          "adicionar",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: 'orkey-bold'),
        ),
        icon: Icon(
          Icons.add,
          color: Colors.black,
        ),
        onPressed: () async {
          var retorno = await Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => NewTask(toDoList: toDoList),
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
              border: Border.all(color: Colors.grey),
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
                color: Colors.red,
                icon: Icons.delete,
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
              border: Border.all(color: Colors.grey),
              borderRadius:
                  BorderRadius.all(Radius.circular(size_screen * 0.04))),
          child: Slidable(
            actionPane: SlidableDrawerActionPane(),
            child: Container(
              child: Column(
                children: <Widget>[
                  ExpandablePanel(
                    tapHeaderToExpand: true,
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
                color: Colors.red,
                icon: Icons.delete,
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
                        hintText: "Título",
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
                            toDoList[index]["title"] = controller_text.text;
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
                ? buildCardUnica(context, font_button, toDoList, index)
                : buildCardGrupo(context, index, font_button, toDoList),
      );
    } else {
      List<Map<String, dynamic>> toDo = List();
      for (int index = 0; index < toDoList.length; index++) {
        String titulo = toDoList[index]["title"];
        if (titulo.toLowerCase().contains(_searchText.toLowerCase())) {
          toDo.add(toDoList[index]);
          break;
        }
        if(toDoList[index]["tipo"] == "composta"){
          for (int j = 0; j < toDoList[index]["details"].length; j++) {
            print(toDoList[index]["details"]["$j"].toString());
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
