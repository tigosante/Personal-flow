import 'dart:convert';
import 'dart:io';

import 'package:expandable/expandable.dart';
import 'package:flushbar/flushbar.dart';
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

List<bool> dias_agendados = [];
bool agendar_unica = false;
String agenda_unica = "Clique para definir a data final desta tarefa.";
Color cor_tarefa = Colors.grey;

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

    setState(() {
      agenda_unica = toDoList[widget.valor]["agendada"]
          ? toDoList[widget.valor]["data_agenda"].toString()
          : agenda_unica;
      if (toDoList[widget.valor]["agendada"]) {
        dias_agendados = toDoList[widget.valor]["dias_agendados"];
      }
    });

    return Padding(
        padding: EdgeInsets.only(
            top: toDoList[widget.valor] != null
                ? toDoList[widget.valor]["data_form"] != null
                    ? size_screen * 0.01
                    : 0
                : 0),
        child: 
        // ExpandablePanel(
        //   header: 
          ListTile(
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
                                : Text(
                                    toDoList[widget.valor]["hora"].toString())
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
          ),
          // expanded: Container(
          //   decoration: BoxDecoration(
          //     border:
          //         Border.all(color: Colors.grey, width: size_screen * 0.0005),
          //     borderRadius:
          //         BorderRadius.all(Radius.circular(size_screen * 0.02)),
          //   ),
          //   child: Column(
          //     mainAxisSize: MainAxisSize.min,
          //     children: <Widget>[
          //       toDoList[widget.valor]["agendada"]
          //           ? ListTile(
          //               title: Text("Agendar"),
          //               subtitle: Text(
          //                 "Escolha os dias que a tarefa repete-se.",
          //               ),
          //             )
          //           : Container(
          //               color: Colors.transparent,
          //             ),
          //       Column(
          //         mainAxisSize: MainAxisSize.min,
          //         children: <Widget>[
          //           Container(
          //             decoration: BoxDecoration(
          //               border: Border.all(
          //                   color: Colors.grey, width: size_screen * 0.0003),
          //               borderRadius: BorderRadius.all(
          //                   Radius.circular(size_screen * 0.02)),
          //             ),
          //             child: Padding(
          //               padding: EdgeInsets.only(
          //                 top: size_screen * 0.015,
          //                 bottom: size_screen * 0.015,
          //               ),
          //               child: ListTile(
          //                 title: Row(
          //                     mainAxisSize: MainAxisSize.max,
          //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                     children: List<Widget>.generate(7, (dia) {
          //                       List<String> dias = [
          //                         "Seg",
          //                         "Ter",
          //                         "Qua",
          //                         "Qui",
          //                         "Sex",
          //                         "Sáb",
          //                         "Dom"
          //                       ];
          //                       setState(() {
          //                         if (dias_agendados.length != null) {
          //                           for (int i = 0; i < dias.length; i++) {
          //                             dias_agendados.add(false);
          //                             agendar_unica = false;
          //                           }
          //                         }
          //                       });
          //                       return InkWell(
          //                         child: dias_agendados != null
          //                             ? Container(
          //                                 padding: EdgeInsets.all(
          //                                     size_screen * 0.008),
          //                                 child: Text(
          //                                   dias[dia],
          //                                   style: TextStyle(
          //                                       color: dias_agendados[dia]
          //                                           ? Colors.blue
          //                                           : Colors.grey),
          //                                 ),
          //                               )
          //                             : Container(
          //                                 color: Colors.transparent,
          //                               ),
          //                         onTap: () {
          //                           setState(() {
          //                             dias_agendados[dia] =
          //                                 !dias_agendados[dia];

          //                             if (!dias_agendados[dia]) {
          //                               agenda_unica =
          //                                   "Clique para definir a data final desta tarefa.";
          //                               agendar_unica = false;
          //                               cor_tarefa = Colors.grey;
          //                             }

          //                             AgendarData agendamento = AgendarData();

          //                             agendamento.agendar(dias_agendados);
          //                           });
          //                         },
          //                       );
          //                     })),
          //                 subtitle: Padding(
          //                   padding: EdgeInsets.only(top: size_screen * 0.025),
          //                   child: InkWell(
          //                     child: Container(
          //                         padding: EdgeInsets.all(size_screen * 0.008),
          //                         child: Text(
          //                           agenda_unica,
          //                           style: TextStyle(color: cor_tarefa),
          //                         )),
          //                     onTap: () async {
          //                       if (dias_agendados != null) {
          //                         bool verificar = false;
          //                         for (int i = 0;
          //                             i < dias_agendados.length;
          //                             i++) {
          //                           if (dias_agendados[i]) {
          //                             verificar = true;
          //                           }
          //                         }
          //                         if (verificar) {
          //                           final DateTime picked =
          //                               await showDatePicker(
          //                             context: context,
          //                             firstDate: new DateTime(2000),
          //                             lastDate: new DateTime(2030),
          //                             initialDate: new DateTime.now(),
          //                           );
          //                           setState(() {
          //                             AgendarData agendamento = AgendarData(
          //                               picked: picked,
          //                             );
          //                             agendar_unica = picked == null;
          //                             agenda_unica =
          //                                 agendamento.data_agendamento();

          //                             cor_tarefa = agendar_unica
          //                                 ? Colors.grey
          //                                 : Colors.blue;

          //                             agendamento.agendar(dias_agendados);
          //                           });
          //                         } else {
          //                           Flushbar flushbar;
          //                           bool _wasButtonClicked;

          //                           flushbar = Flushbar<bool>(
          //                             animationDuration:
          //                                 Duration(milliseconds: 450),
          //                             message:
          //                                 "Escolha algum dia para agendar.",
          //                             borderRadius: size_screen * 0.05,
          //                             margin: EdgeInsets.only(
          //                               bottom: size_screen * 0.15,
          //                               left: size_screen * 0.1,
          //                               right: size_screen * 0.1,
          //                             ),
          //                             duration: Duration(seconds: 2),
          //                           )..show(context).then((result) {
          //                               setState(() {
          //                                 _wasButtonClicked = result;
          //                               });
          //                             });
          //                         }
          //                       }
          //                     },
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           )
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
        // )
        );
  }

  modal(context, index, size_screen) {
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
                        border:
                            Border.all(color: Colors.grey, width: size_screen * 0.0005),
                        borderRadius:
                            BorderRadius.all(Radius.circular(size_screen * 0.02)),
                      ),
                      width: size_screen * 0.65,
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
                            border:
                                Border.all(color: Colors.grey, width: size_screen * 0.0005),
                            borderRadius:
                                BorderRadius.all(Radius.circular(size_screen * 0.02)),
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

  Future<File> getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }
}
