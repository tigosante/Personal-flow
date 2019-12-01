import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:expandable/expandable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:personal_flow/app/shared/tasks_functions.dart';
import 'package:personal_flow/app/shared/notifications_helper.dart';
import 'package:personal_flow/app/screens/home/components/card_struct.dart';

FlutterLocalNotificationsPlugin notifications =
    new FlutterLocalNotificationsPlugin();

class CardContentUnica extends StatefulWidget {
  CardContentUnica(
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

  _CardContentUnicaState createState() => _CardContentUnicaState();
}

class _CardContentUnicaState extends State<CardContentUnica> {
  int index;
  List toDoList;
  double sizeScreen;
  dynamic fontButton;
  Color corConcluir;
  Map<String, dynamic> listData = Map();

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
      fontButton = widget.fontButton;
      sizeScreen = widget.sizeScreen;
      toDoList = toDoList = widget.texto;
    });

    return buildBody(context, index);
  }

  Widget buildBody(context, index) {
    TextEditingController controllerText =
        TextEditingController(text: toDoList[widget.valor]["title"]);

    return Padding(
      padding: EdgeInsets.only(
          top: toDoList[widget.valor] != null
              ? toDoList[widget.valor]["dataForm"] != null
                  ? sizeScreen * 0.01
                  : 0
              : 0),
      child: ExpandablePanel(
        header: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
              child: ListTile(
                title: Text(toDoList[widget.valor]["title"]),
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
                        child: toDoList[widget.valor]["dataForm"] == null
                            ? Text("Data e hora")
                            : Text(toDoList[widget.valor]["dataForm"] + ","),
                      ),
                      onTap: () async {
                        List<String> backup = [];

                        final DateTime picked = await showDatePicker(
                          context: context,
                          firstDate: new DateTime(2000),
                          lastDate: new DateTime(2030),
                          initialDate: new DateTime.now(),
                        );

                        backup.add(toDoList[widget.valor]["dataForm"]);
                        backup.add(toDoList[widget.valor]["hora"]);
                        backup.add(toDoList[widget.valor]["dia"]);
                        backup.add(toDoList[widget.valor]["mes"]);
                        backup.add(toDoList[widget.valor]["ano"]);

                        setState(() {
                          DataHora dataHora = DataHora(
                            picked: picked,
                            title: toDoList[widget.valor]["title"],
                            boolen: toDoList[widget.valor]["bool"],
                            tipo: toDoList[widget.valor]["tipo"],
                            agendada: toDoList[widget.valor]["agendada"],
                            dtInativacao: toDoList[widget.valor]
                                ["dtInativacao"],
                            repeticao: toDoList[widget.valor]["repeticao"],
                            conclusao: toDoList[widget.valor]["conclusao"],
                            titleFormatado: toDoList[widget.valor]
                                ["titleFormatado"],
                            dataRepetidao: toDoList[widget.valor]
                                ["dataRepetidao"],
                            dataAgenda: toDoList[widget.valor]["dataAgenda"],
                            diasAgendados: toDoList[widget.valor]
                                ["diasAgendados"],
                            idChanel: toDoList[widget.valor]["idChanel"],
                          );
                          toDoList[widget.valor] = dataHora.calendario();

                            if (backup[0] !=
                                toDoList[widget.valor]["dataForm"]) {
                              Notificacao notificacao = Notificacao(
                                  tarefa: toDoList[widget.valor],
                                  notifications: notifications,
                                  idChanel: toDoList[widget.valor]
                                      ["idChanel"],
                                  agendadas: toDoList[widget.valor]["agendada"]
                                      ? toDoList[widget.valor]["diasAgendados"]
                                      : [false]);

                              notificacao.filtro();
                          }
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
                        child: toDoList[widget.valor] != null
                            ? toDoList[widget.valor]["dataForm"] != null
                                ? toDoList[widget.valor]["hora"] == null
                                    ? Text("hora")
                                    : Text(toDoList[widget.valor]["hora"]
                                        .toString())
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
                          Notificacao notificacao = Notificacao(
                              tarefa: toDoList[widget.valor],
                              notifications: notifications,
                              idChanel: toDoList[widget.valor]["idChanel"],
                              agendadas: toDoList[widget.valor]["agendada"]
                                  ? toDoList[widget.valor]["diasAgendados"]
                                  : [false]);

                          notificacao.filtro();

                          saveData();
                        });
                      },
                    ),
                    toDoList[widget.valor]["dataForm"] != null
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
                                toDoList[widget.valor]["hora"] = null;
                                toDoList[widget.valor]["dataForm"] = null;

                                Notificacao notificacao = Notificacao(
                                    tarefa: toDoList[widget.valor],
                                    notifications: notifications,
                                    idChanel: toDoList[widget.valor]
                                        ["idChanel"],
                                    agendadas: toDoList[widget.valor]
                                            ["agendada"]
                                        ? toDoList[widget.valor]
                                            ["diasAgendados"]
                                        : [false]);

                                notificacao.filtro();
                              });
                            },
                          )
                        : Container(
                            color: Colors.transparent,
                          )
                  ],
                ),
                onTap: () {
                  modal(context, index, sizeScreen);
                },
              ),
            ),
            toDoList[widget.valor]["bool"]
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
          ],
        ),
        expanded: AgendarCards(
          posicao: widget.valor,
        ),
      ),
    );
  }

  modal(context, index, sizeScreen) {
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

  Future<File> getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }
}
