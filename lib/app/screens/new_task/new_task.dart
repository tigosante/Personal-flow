import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:personal_flow/app/shared/tasks_functions.dart';
import 'package:personal_flow/app/shared/tree.dart';

class NewTask extends StatefulWidget {
  NewTask({Key key, @required this.toDoList}) : super(key: key);

  List toDoList;
  _NewTaskState createState() => _NewTaskState();
}

String tipo_tarefa_drop = "Tipo de tarefa";
String info_tipo_tarefa = "Escolha um tipo de tarefa.";
bool tipo_tarefa = true;
bool acao_dialog = false;
dynamic tarefa_dialog;
dynamic toDoList_dialog;

class _NewTaskState extends State<NewTask> {
  Map<String, dynamic> data_list = Map();
  Map<String, dynamic> data_unica = Map();

  TextEditingController controller_titulo = TextEditingController();
  List<TextEditingController> controller_sub = [TextEditingController()];
  TextEditingController controller_unica = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List toDoList = widget.toDoList;
    TasksProp tasksProp = TasksProp(context_screen: context);
    double size_screen = tasksProp.outScreenSize;

    setState(() {
      toDoList_dialog = widget.toDoList;
    });

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text("Nova Tarefa", style: TextStyle(color: Colors.grey),),
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Colors.grey
        ),
      ),
      body: Column(
        children: <Widget>[
          buildDropDown(size_screen),
          tipo_tarefa
              ? Expanded(child: buildTarefaComposta(context, size_screen))
              : Expanded(child: buildTarefaUnica(context, size_screen)),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        elevation: 0,
        backgroundColor: Colors.blue,
        onPressed: () {
          setState(() {
            if (tipo_tarefa) {
              List retorno = addToDo();

              if (retorno[0]) {
                if (retorno[2]) {
                  dialog_composta(size_screen, context, retorno);
                } else {
                  widget.toDoList.insert(0, retorno[3]);
                  Navigator.pop(context, widget.toDoList);
                }
              } else {
                Navigator.pop(context, null);
              }
            } else {
              List retorno = addToDoUnica(context, size_screen);
              if (retorno[0]) {
                if (retorno[2]) {
                  dialog_func(size_screen, context, retorno);
                } else {
                  widget.toDoList.insert(0, retorno[3]);
                  Navigator.pop(context, widget.toDoList);
                }
              } else if (!retorno[0]) {
                Navigator.pop(context, null);
              }
            }
          });
        },
        icon: Icon(
          Icons.add,
        ),
        label: Text(
          "Adicionar",
          style: TextStyle(fontFamily: 'Orkney-bold'),
        ),
      ),
    );
  }

  Widget buildDropDown(size_screen) {
    return Column(
      children: <Widget>[
        Divider(
          height: size_screen * 0.03,
          color: Colors.transparent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: size_screen * 0.5,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(left: size_screen * 0.07),
                  child: Text(
                    info_tipo_tarefa,
                  ),
                ),
              ),
            ),
            Container(
              width: size_screen * 0.5,
              child: Center(
                child: DropdownButton<String>(
                  elevation: 1,
                  value: tipo_tarefa_drop,
                  iconEnabledColor: Colors.grey,
                  iconDisabledColor: Colors.grey,
                  underline: Container(
                    height: 0,
                  ),
                  items: <String>[
                    "Tipo de tarefa",
                    "Simples",
                    "Composta",
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                      ),
                    );
                  }).toList(),
                  onChanged: (String newValue) {
                    setState(() {
                      tipo_tarefa_drop = newValue;
                      tipo_tarefa = tipo_tarefa_drop == "Tipo de tarefa" ||
                              tipo_tarefa_drop == "Composta"
                          ? true
                          : false;
                      info_tipo_tarefa = tipo_tarefa_drop == "Tipo de tarefa"
                          ? "Escolha um tipo de tarefa."
                          : tipo_tarefa_drop == "Simples"
                              ? "Você pode criar apenas uma terefa."
                              : "Você pode criar um grupo com várias subtarefas.";

                      controller_unica = TextEditingController();
                      controller_titulo = TextEditingController();
                      controller_sub = [TextEditingController()];
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildTarefaUnica(context, size_screen) {
    return Padding(
      padding:
          EdgeInsets.only(left: size_screen * 0.06, right: size_screen * 0.06, top: size_screen * 0.05),
      child: Column(
        children: <Widget>[
          Divider(
            color: Colors.transparent,
            height: size_screen * 0.05,
          ),
          Container(
            padding: EdgeInsets.all(size_screen * 0.01),
            decoration: BoxDecoration(
              border:
                  Border.all(color: Colors.grey, width: size_screen * 0.0005),
              borderRadius:
                  BorderRadius.all(Radius.circular(size_screen * 0.02)),
            ),
            child: ListTile(
              title: TextField(
                controller: controller_unica,
                decoration: InputDecoration(
                  hintText: "Tarefa",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
                maxLines: 8,
                minLines: 1,
              ),
              subtitle: dataHoraUnica(context, size_screen),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTarefaComposta(context, size_screen) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
              top: size_screen * 0.08,
              left: size_screen * 0.06,
              right: size_screen * 0.06,
              bottom: size_screen * 0.02),
          child: Container(
            decoration: BoxDecoration(
              border:
                  Border.all(color: Colors.grey, width: size_screen * 0.0005),
              borderRadius:
                  BorderRadius.all(Radius.circular(size_screen * 0.02)),
            ),
            child: ListTile(
              title: TextField(
                controller: controller_titulo,
                decoration: InputDecoration(
                  labelText: "Título",
                  border: InputBorder.none,
                  labelStyle: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(
                    left: size_screen * 0.06,
                    right: size_screen * 0.06,
                    bottom: size_screen * 0.3,
                  ),
                  itemCount: controller_sub.length,
                  itemBuilder: (BuildContext context, int index) =>
                      buildDetailsBody(context, index, size_screen),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget buildDetailsBody(context, index, size_screen) {
    return Padding(
      padding: EdgeInsets.only(bottom: size_screen * 0.02),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: size_screen * 0.0005),
          borderRadius: BorderRadius.all(Radius.circular(size_screen * 0.02)),
        ),
        child: ListTile(
          title: TextField(
            controller: controller_sub[index],
            decoration: InputDecoration(
              hintText: "Tarefa",
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
            ),
            maxLines: 8,
            minLines: 1,
          ),
          subtitle: dataHora(context, size_screen, index),
          trailing:
              controller_sub[index] == controller_sub[controller_sub.length - 1]
                  ? IconButton(
                      color: Colors.blue[600],
                      icon: Icon(
                        Icons.add_circle_outline,
                      ),
                      onPressed: () {
                        setState(() {
                          controller_sub.add(TextEditingController());
                        });
                      },
                    )
                  : IconButton(
                      color: Colors.red[600],
                      icon: Icon(
                        Icons.remove_circle,
                      ),
                      onPressed: () {
                        setState(() {
                          List toDoNovo = [];
                          Map<String, dynamic> toDo = Map();
                          Map<String, dynamic> toNovo = Map();

                          controller_sub.removeAt(index);
                          data_list["$index"] = null;

                          toDo = Map.from(data_list);

                          for (int i = 0; i <= toDo.length; i++) {
                            if (toDo["$i"] != null) {
                              toDoNovo.add(toDo["$i"]);
                            }
                          }

                          for (int i = 0; i < toDoNovo.length; i++) {
                            toNovo["$i"] = toDoNovo[i];
                          }

                          data_list = toNovo;
                        });
                      },
                    ),
        ),
      ),
    );
  }

  Widget dataHoraUnica(context, size_screen) {
    return Row(
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
            child: data_unica == null || data_unica["data_form"] == null
                ? Text("Data e hora")
                : Text(data_unica["data_form"] + ","),
          ),
          onTap: () async {
            final DateTime picked = await showDatePicker(
              context: context,
              firstDate: new DateTime(2000),
              lastDate: new DateTime(2030),
              initialDate: new DateTime.now(),
            );
            setState(() {
              DataHora dataHora = DataHora(picked: picked);
              data_unica = dataHora.calendario();
              data_unica["hora"] =
                  data_unica["data_form"] == null ? null : data_unica["hora"];
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
            child: data_unica["data_form"] != null
                ? data_unica["hora"] == null
                    ? Text("hora")
                    : Text(data_unica["hora"])
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
              String retorno = dataHora.hora();
              if (retorno != null) {
                data_unica["hora"] = retorno;
              } else {
                data_unica["hora"] = null;
              }
            });
          },
        ),
        data_unica["data_form"] != null
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
                    data_unica["hora"] = null;
                    data_unica["data_form"] = null;
                  });
                },
              )
            : Container(
                color: Colors.transparent,
              )
      ],
    );
  }

  Widget dataHora(context, size_screen, index) {
    return Row(
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
            child: data_list["$index"] == null ||
                    data_list["$index"]["data_form"] == null
                ? Text("Data e hora")
                : Text(data_list["$index"]["data_form"].toString() + ","),
          ),
          onTap: () async {
            final DateTime picked = await showDatePicker(
              context: context,
              firstDate: new DateTime(2000),
              lastDate: new DateTime(2030),
              initialDate: new DateTime.now(),
            );
            setState(() {
              DataHora dataHora = DataHora(picked: picked);
              data_list["$index"] = dataHora.calendario();
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
              child: data_list["$index"] != null
                  ? data_list["$index"]["data_form"] != null
                      ? data_list["$index"]["hora"] == null
                          ? Text("hora")
                          : Text(data_list["$index"]["hora"])
                      : Container(
                          color: Colors.transparent,
                        )
                  : Container(
                      color: Colors.transparent,
                    )),
          onTap: () async {
            final TimeOfDay picked = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
            setState(() {
              DataHora dataHora = DataHora(picked: picked);
              String retorno = dataHora.hora().toString();
              if (retorno != "null") {
                data_list["$index"]["hora"] = retorno;
              } else {
                data_list["$index"]["hora"] = null;
              }
            });
          },
        ),
        data_list["$index"] != null
            ? data_list["$index"]["data_form"] != null
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
                        data_list["$index"]["hora"] = null;
                        data_list["$index"]["data_form"] = null;
                      });
                    },
                  )
                : Container(
                    color: Colors.transparent,
                  )
            : Container(
                color: Colors.transparent,
              )
      ],
    );
  }

  addToDoUnica(context, size_screen) {
    if (controller_unica.text.trim() != "") {
      Map<String, dynamic> newToDo = Map();
      Tratamentos tratamentos = Tratamentos(
          tarefa: controller_unica.text.trim(),
          toDoList: widget.toDoList,
          data: data_unica["data_form"]);

      newToDo["title"] = controller_unica.text.trim();
      newToDo["bool"] = false;

      newToDo["data_form"] =
          data_unica["data_form"] != null ? data_unica["data_form"] : null;
      newToDo["hora"] = data_unica["hora"] != null ? data_unica["hora"] : null;

      newToDo["tipo"] = "simples";
      newToDo["programada"] = false;
      newToDo["dt_inativacao"] = null;

      int coclusao = 0;
      int repeticao = 1;

      coclusao += tratamentos.conclusao();
      repeticao += tratamentos.repeticao_tarefa();

      newToDo["conclusao"] = coclusao;
      newToDo["repeticao"] = repeticao;
      newToDo["data_repeticao"] = tratamentos.data_repeticao();
      newToDo["title_formatado"] = tratamentos.formatar_titulo();

      Tree tree = Tree(tarefa: newToDo);

      List lista_retorno = tree.decisao();

      lista_retorno.insert(0, true);
      lista_retorno.add(newToDo);

      return lista_retorno;
    } else {
      List lista_retorno = [false];
      return lista_retorno;
    }
  }

  dialog_func(size_screen, context, lista_retorno) {
    showDialog(
        context: context,
        builder: (BuildContext cont) {
          return Corpo_simples(
              size_screen: size_screen, lista_retorno: lista_retorno);
        });
  }

  dialog_composta(size_screen, context, lista_retorno) {
    showDialog(
        context: context,
        builder: (BuildContext cont) {
          return Corpo_Composta(
              size_screen: size_screen, lista_retorno: lista_retorno);
        });
  }

  addToDo() {
    if (controller_titulo.text.trim() != "") {
      Map<String, dynamic> newToDo = Map();
      Map<String, dynamic> details = Map();
      int qnt_tarefas = 0;

      Composta trefa = Composta(tarefa: controller_titulo.text.trim());

      newToDo["title"] = controller_titulo.text.trim();
      newToDo["bool"] = false;

      newToDo["tipo"] = "composta";
      newToDo["conclusao"] = 0;
      newToDo["programada"] = false;
      newToDo["dt_inativacao"] = null;
      newToDo["title_formatado"] = trefa.formatar_titulo();

      for (int i = 0; i < controller_sub.length; i++) {
        if (controller_sub[i].text.trim() != "") {
          Map<String, dynamic> content = Map();

          content["hora"] =
              data_list["$i"] != null ? data_list["$i"]["hora"] : null;
          content["data_form"] =
              data_list["$i"] != null ? data_list["$i"]["data_form"] : null;

          content["title"] = controller_sub[i].text.trim();
          content["bool"] = false;

          content["dt_inativacao"] = null;
          content["repeticao"] = 1;
          content["conclusao"] = 0;
          content["tipo"] = "subtarefa";
          content["title_formatado"] =
              trefa.formatar_sub_titulo(content["title"]);

          details["$i"] = content;

          qnt_tarefas++;
        }
      }

      if (qnt_tarefas == 0) {
        return [false];
      }

      newToDo["details"] = details;

      Composta repete = Composta(toDoList: widget.toDoList, newToDo: newToDo);

      int repeticao = 0;
      List porcentagem_repete = [];
      repeticao = repete.repeticao_titulo_tarefa();
      porcentagem_repete = repete.repeticao_sub_tarefa();

      newToDo = porcentagem_repete[1];
      newToDo["porcentagem"] = porcentagem_repete[0];

      Composta concluir = Composta(toDoList: widget.toDoList, newToDo: newToDo);
      newToDo["conclusao_grupo"] = concluir.conclsuao();

      newToDo["repeticao"] = repeticao;
      newToDo["data_grupo"] = concluir.data_grupo();
      newToDo["data_repetica"] =
          newToDo["data_grupo"] ? concluir.data_repetica() : false;

      Tree tree = Tree(tarefa: newToDo);
      List retorno = tree.decisao();

      retorno.insert(0, true);
      retorno.add(newToDo);
      retorno.add(porcentagem_repete[2]);

      return retorno;
    } else {
      return [false];
    }
  }
}

List<bool> valor = [];
bool check_titulo = false;

class Corpo_Composta extends StatefulWidget {
  Corpo_Composta({Key key, this.size_screen, this.lista_retorno})
      : super(key: key);

  double size_screen;
  List lista_retorno;

  _Corpo_CompostaState createState() => _Corpo_CompostaState();
}

class _Corpo_CompostaState extends State<Corpo_Composta> {
  @override
  Widget build(BuildContext context) {
    List lista_retorno = widget.lista_retorno;
    double size_screen = widget.size_screen;

    dynamic toDoList = lista_retorno[3];
    dynamic outras = lista_retorno[4];
    dynamic backup = toDoList;

    Map<String, dynamic> data_unica = Map();

    TextEditingController controller =
        TextEditingController(text: toDoList["title"]);

    if (valor.length < toDoList["details"].length) {
      setState(() {
        for (int i = 0; i < toDoList["details"].length; i++) {
          valor.add(false);
        }
      });
    }

    return AlertDialog(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(size_screen * 0.04),
      ),
      title: ListTile(
        title: Text(
          "Parece que você já criou essa tarefa anteriormente!\n",
        ),
        subtitle: Text("Que tal deixá-la programada?"),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      maxLines: 8,
                      minLines: 1,
                    ),
                  ),
                  Checkbox(
                    value: check_titulo,
                    onChanged: (bool value) {
                      setState(() {
                        check_titulo = !check_titulo;

                        if (check_titulo) {
                          for (int i = 0; i < valor.length; i++) {
                            valor[i] = true;
                          }
                        } else {
                          for (int i = 0; i < valor.length; i++) {
                            valor[i] = false;
                          }
                        }
                      });
                    },
                  )
                ],
              ),
            ),
            Divider(
              color: Colors.grey,
              height: 0,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children:
                  List<Widget>.generate(toDoList["details"].length, (index) {
                TextEditingController controller = TextEditingController(
                    text: toDoList["details"]["$index"]["title"]);

                setState(() {
                  data_unica["hora"] = toDoList["details"]["$index"]["hora"];
                  data_unica["data_form"] =
                      toDoList["details"]["$index"]["data_form"];
                });

                List backup = [];

                setState(() {
                  for (int i = 0; i < outras.length; i++) {
                    if (toDoList["details"]["$index"]["title_formatado"] !=
                        outras[i]["title_formatado"]) {
                      backup.add(outras[i]);
                    }
                  }
                  outras = backup;
                });

                return Column(
                  children: <Widget>[
                    ListTile(
                        title: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Expanded(
                              child: TextField(
                                controller: controller,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                                maxLines: 8,
                                minLines: 1,
                              ),
                            ),
                          ],
                        ),
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
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(size_screen * 0.02)),
                                ),
                                child: toDoList["details"]["$index"]
                                            ["data_form"] ==
                                        null
                                    ? Text("Data e hora")
                                    : Text(toDoList["details"]["$index"]
                                            ["data_form"] +
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
                                  DataHora dataHora = DataHora(picked: picked);
                                  data_unica = dataHora.calendario();
                                  toDoList["details"]["$index"]["data_form"] =
                                      data_unica["data_form"];

                                  toDoList["details"]["$index"]["hora"] = null;
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
                                child: toDoList["details"]["$index"]
                                            ["data_form"] !=
                                        null
                                    ? toDoList["details"]["$index"]["hora"] ==
                                            null
                                        ? Text("hora")
                                        : Text(toDoList["details"]["$index"]
                                            ["hora"])
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
                                  String retorno = dataHora.hora();
                                  if (retorno != null) {
                                    toDoList["details"]["$index"]["hora"] =
                                        retorno;
                                  } else {
                                    toDoList["details"]["$index"]["hora"] =
                                        null;
                                  }
                                });
                              },
                            ),
                            toDoList["details"]["$index"]["data_form"] != null
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
                                        toDoList["details"]["$index"]["hora"] =
                                            null;
                                        toDoList["details"]["$index"]
                                            ["data_form"] = null;
                                      });
                                    },
                                  )
                                : Container(
                                    color: Colors.transparent,
                                  )
                          ],
                        ),
                        trailing: Checkbox(
                          value: valor[index],
                          onChanged: (bool press) {
                            setState(() {
                              valor[index] = !valor[index];
                              check_titulo = false;
                              if (valor.length == 1 && valor[index]) {
                                check_titulo = true;
                              } else {
                                int todos = 0;
                                for (int i = 0; i < valor.length; i++) {
                                  todos += valor[i] ? 1 : 0;
                                }

                                if (todos == valor.length) {
                                  check_titulo = true;
                                }
                              }
                            });
                          },
                        )),
                  ],
                );
              }).toList(),
            ),
            outras.length > 0
                ? Outras_tarefas(
                    size_screen: size_screen,
                    outras: outras,
                  )
                : Container(color: Colors.transparent)
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(
            "Sair",
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () {
            setState(() {
              acao_dialog = false;
              toDoList_dialog.insert(0, backup);
            });
            Navigator.pop(context);
            Navigator.pop(context, toDoList_dialog);
          },
        ),
        FlatButton(
          child: Text(
            "Adiconar",
          ),
          onPressed: () {
            setState(() {
              acao_dialog = true;
              tarefa_dialog = toDoList;
              toDoList_dialog.insert(0, toDoList);
            });
            Navigator.pop(context);
            Navigator.pop(context, toDoList_dialog);
          },
        ),
      ],
    );
  }
}

List<bool> outras_check = [];

class Outras_tarefas extends StatefulWidget {
  Outras_tarefas({Key key, this.outras, this.size_screen}) : super(key: key);

  List outras;
  double size_screen;
  @override
  _Outras_tarefasState createState() => _Outras_tarefasState();
}

class _Outras_tarefasState extends State<Outras_tarefas> {
  @override
  Widget build(BuildContext context) {
    setState(() {
      for (int i = 00; i < widget.outras.length; i++) {
        outras_check.add(false);
      }
    });

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Divider(
          color: Colors.grey,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ExpandablePanel(
              tapHeaderToExpand: true,
              header: Container(
                padding: EdgeInsets.only(
                    top: widget.size_screen * 0.04,
                    left: widget.size_screen * 0.02,
                    bottom: widget.size_screen * 0.04),
                child: Text("Outras tarefas deste grupo"),
              ),
              expanded: Column(
                mainAxisSize: MainAxisSize.min,
                children: List<Widget>.generate(widget.outras.length, (item) {
                  return ListTile(
                    title: Text(widget.outras[item]["title"]),
                    subtitle: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        InkWell(
                          child: Container(
                            padding: EdgeInsets.only(
                              top: widget.size_screen * 0.015,
                              right: widget.size_screen * 0.015,
                              bottom: widget.size_screen * 0.015,
                            ),
                            child: widget.outras[item]["data_form"] == null
                                ? Text("Data e hora")
                                : Text(widget.outras[item]["data_form"] + ","),
                          ),
                          onTap: () async {
                            dynamic data_unica;
                            final DateTime picked = await showDatePicker(
                              context: context,
                              firstDate: new DateTime(2000),
                              lastDate: new DateTime(2030),
                              initialDate: new DateTime.now(),
                            );
                            setState(() {
                              DataHora dataHora = DataHora(picked: picked);
                              data_unica = dataHora.calendario();
                              widget.outras[item]["data_form"] =
                                  data_unica["data_form"];

                              widget.outras[item]["hora"] = null;
                            });
                          },
                        ),
                        InkWell(
                          child: Container(
                            padding: EdgeInsets.only(
                              top: widget.size_screen * 0.015,
                              right: widget.size_screen * 0.015,
                              bottom: widget.size_screen * 0.015,
                            ),
                            child: widget.outras[item]["data_form"] != null
                                ? widget.outras[item]["hora"] == null
                                    ? Text("hora")
                                    : Text(widget.outras[item]["hora"])
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
                              String retorno = dataHora.hora();
                              if (retorno != null) {
                                widget.outras[item]["hora"] = retorno;
                              } else {
                                widget.outras[item]["hora"] = null;
                              }
                            });
                          },
                        ),
                        widget.outras[item]["data_form"] != null
                            ? InkWell(
                                child: Container(
                                  padding: EdgeInsets.only(
                                    top: widget.size_screen * 0.015,
                                    right: widget.size_screen * 0.015,
                                    bottom: widget.size_screen * 0.015,
                                  ),
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.red,
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    widget.outras[item]["hora"] = null;
                                    widget.outras[item]["data_form"] = null;
                                  });
                                },
                              )
                            : Container(
                                color: Colors.transparent,
                              )
                      ],
                    ),
                    trailing: Checkbox(
                      value: outras_check[item],
                      onChanged: (bool press) {
                        setState(() {
                          outras_check[item] = !outras_check[item];
                        });
                      },
                    ),
                  );
                }),
              ),
            )
          ],
        ),
        Divider(
          color: Colors.grey,
        )
      ],
    );
  }
}

class Corpo_simples extends StatefulWidget {
  Corpo_simples({Key key, this.size_screen, this.lista_retorno})
      : super(key: key);

  double size_screen;
  List lista_retorno;

  _Corpo_simplesState createState() => _Corpo_simplesState();
}

class _Corpo_simplesState extends State<Corpo_simples> {
  @override
  Widget build(BuildContext context) {
    List lista_retorno = widget.lista_retorno;
    double size_screen = widget.size_screen;
    Map<String, dynamic> data_unica = Map();

    dynamic tarefa = lista_retorno[3];
    dynamic backup = tarefa;
    TextEditingController controller =
        TextEditingController(text: tarefa["title"]);
    setState(() {
      data_unica["hora"] = tarefa["hora"];
      data_unica["data_form"] = tarefa["data_form"];
    });
    return AlertDialog(
      title: ListTile(
        title: Text(
          "Parece que você já criou essa tarefa algumas vezes!\n",
        ),
        subtitle: Text("Que tal deixá-la programada?"),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    maxLines: 8,
                    minLines: 1,
                  ),
                ),
              ],
            ),
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
                    child: tarefa["data_form"] == null
                        ? Text("Data e hora")
                        : Text(tarefa["data_form"] + ","),
                  ),
                  onTap: () async {
                    final DateTime picked = await showDatePicker(
                      context: context,
                      firstDate: new DateTime(2000),
                      lastDate: new DateTime(2030),
                      initialDate: new DateTime.now(),
                    );
                    setState(() {
                      DataHora dataHora = DataHora(picked: picked);
                      data_unica = dataHora.calendario();
                      tarefa["data_form"] = data_unica["data_form"];

                      tarefa["hora"] = null;
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
                    child: tarefa["data_form"] != null
                        ? tarefa["hora"] == null
                            ? Text("hora")
                            : Text(tarefa["hora"])
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
                      String retorno = dataHora.hora();
                      if (retorno != null) {
                        tarefa["hora"] = retorno;
                      } else {
                        tarefa["hora"] = null;
                      }
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(
            "Sair",
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () {
            setState(() {
              acao_dialog = false;
              toDoList_dialog.insert(0, backup);
            });
            Navigator.pop(context);
            Navigator.pop(context, toDoList_dialog);
          },
        ),
        FlatButton(
          child: Text(
            "Adiconar",
          ),
          onPressed: () {
            setState(() {
              acao_dialog = true;
              tarefa_dialog = tarefa;
              toDoList_dialog.insert(0, tarefa);
            });
            Navigator.pop(context);
            Navigator.pop(context, toDoList_dialog);
          },
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(size_screen * 0.04),
      ),
    );
  }
}
