import 'dart:convert';
import 'dart:io';

import 'package:expandable/expandable.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:personal_flow/app/screens/home/components/card_content.dart';
import 'package:personal_flow/app/screens/home/components/header.dart';
import 'package:personal_flow/app/screens/new_task/new_task.dart';
import 'package:personal_flow/app/shared/tasks_functions.dart';

class CardStruct extends StatefulWidget {
  CardStruct({Key key}) : super(key: key);

  @override
  _CardStructState createState() => new _CardStructState();
}

class _CardStructState extends State<CardStruct> {
  List toDoList = [];
  dynamic conteudo = Container(color: Colors.white,);

  @override
  initState() {
    super.initState();
    readyData().then((data) {
      setState(() {
        toDoList = jsonDecode(data);
      });
    });
  }

  @override
  Widget build(context) {
    GeneratioCards genaratioCards = GeneratioCards(context_screen: context);
    double size_screem = genaratioCards.outScreenSize;
    String font_button = genaratioCards.outFontButton;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Header(),
          Expanded(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: toDoList.length < 1
                      ? Image.asset(
                          "assets/background.png",
                          height: size_screem * 0.5,
                          width: size_screem * 0.5,
                          color: Colors.grey[200],
                        )
                      : ListView.builder(
                          padding: EdgeInsets.only(
                            bottom: size_screem * 0.15,
                          ),
                          itemCount: toDoList.length,
                          itemBuilder: (BuildContext context, int index) =>
                              buildCardStruct(
                                  context, index, size_screem, font_button),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
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
        onPressed:() async {
          var retorno = await Navigator.push(
              context,
              MaterialPageRoute(
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

  Widget buildCardStruct(BuildContext context, index, size_screem, font_button) {
    Informacoes informacoes = Informacoes(toDoList: toDoList, index: index);
    String title = informacoes.outTitle;
    TextEditingController controller = TextEditingController(text: title);

    Buttons buttons =
        Buttons(toDoList: toDoList, index: index, context: context);
    Color corConcluir = buttons.cor_concluir();

    return Center(
      child: Card(
        elevation: 0,
        color: Colors.white,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(size_screem * 0.04),
        ),
        child: Container(
          width: size_screem * 0.85,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]),
              borderRadius:
                  BorderRadius.all(Radius.circular(size_screem * 0.04))),
          child: Slidable(
            actionPane: SlidableDrawerActionPane(),
            child: Container(
              child: Column(
                children: <Widget>[
                  ExpandablePanel(
                    tapHeaderToExpand: true,
                    header: Container(
                      padding: EdgeInsets.only(
                        top: size_screem * 0.005,
                        bottom: size_screem * 0.005,
                      ),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: TextField(
                              decoration: InputDecoration(
                                hintText: "Título",
                                border: InputBorder.none,
                              ),
                              controller: controller,
                            ),
                          ),
                        ],
                      ),
                    ),
                    expanded: CardContent(
                      valor: index,
                      texto: toDoList,
                      size_screem: size_screem,
                      font_button: font_button,
                      corConcluir: corConcluir,
                      index: index,
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              IconSlideAction(
                caption: "Arquivar",
                color: Colors.teal,
                icon: Icons.bookmark,
                onTap: () {},
              ),
            ],
            secondaryActions: <Widget>[
              IconSlideAction(
                caption: "Excluir",
                color: Colors.red,
                icon: Icons.delete,
                onTap: () {
                  setState(() {
                    int lastRemovedPos;
                    Map<String, dynamic> lastRemoved;

                    lastRemoved = Map.from(toDoList[index]);
                    lastRemovedPos = index;

                    toDoList.removeAt(index);

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
                            toDoList.insert(lastRemovedPos, lastRemoved);
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
