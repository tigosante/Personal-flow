import 'package:flutter/material.dart';

import 'package:flushbar/flushbar.dart';
import 'package:expandable/expandable.dart';

import 'package:personal_flow/app/shared/tree.dart';
import 'package:personal_flow/app/shared/tasks_functions.dart';
import 'package:personal_flow/app/shared/notifications_helper.dart';

// Variáveis gerais.
Color corTarefa = Colors.grey;

bool tipoTarefa = true;
bool acaoDialog = false;
bool agendarUnica = false;

String agendaUnica = "Definir data final desta tarefa.";
String dataAgendada;
String tipoTarefaDrop = "Tipo de tarefa";
String infoTipoTarefa = "Escolha um tipo de tarefa que deseja criar.";
String dataAgendaDialog = "";

dynamic toDoList;
dynamic notifications;
dynamic toDoListDialog;

List<bool> valor = [];
List<bool> outrasCheck = [];
List<bool> agendarValor = [false, false, false, false, false, false, false];
List<bool> diasAgendados = [false, false, false, false, false, false, false];

class NewTask extends StatefulWidget {
  NewTask({
    Key key,
    @required this.toDoList,
    this.notifications,
  }) : super(key: key);

  List toDoList;
  dynamic notifications;
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  Map<String, dynamic> dataList = Map();
  Map<String, dynamic> dataUnica = Map();

  TextEditingController controllerTitulo = TextEditingController();
  List<TextEditingController> controllerSub = [TextEditingController()];
  TextEditingController controllerUnica = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List toDoList = widget.toDoList;
    TasksProp tasksProp = TasksProp(contextScreen: context);
    double sizeScreen = tasksProp.outScreen_Size;

    setState(() {
      toDoList = widget.toDoList;
      notifications = widget.notifications;
      toDoListDialog = widget.toDoList;
    });

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Nova Tarefa",
          style: TextStyle(
            color: Colors.blue,
          ),
        ),
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.blue),
      ),
      body: Column(
        children: <Widget>[
          buildDropDown(sizeScreen),
          Agendar(sizeScreen: sizeScreen),
          tipoTarefa
              ? Expanded(child: buildTarefaComposta(context, sizeScreen))
              : Expanded(child: buildTarefaUnica(context, sizeScreen)),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.white,
        onPressed: () {
          setState(() {
            if (tipoTarefa) {
              List retorno = addToDo();

              if (retorno[0]) {
                if (retorno[2]) {
                  dialogComposta(sizeScreen, context, retorno);
                } else {
                  widget.toDoList.insert(0, retorno[3]);
                  Navigator.pop(context, widget.toDoList);
                }
              } else {
                Navigator.pop(context, null);
              }
            } else {
              List retorno = addToDoUnica(context, sizeScreen);
              if (retorno[0]) {
                if (retorno[2]) {
                  dialogFunc(sizeScreen, context, retorno);
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
          color: Colors.blue,
        ),
        label: Text(
          "Adicionar",
          style: TextStyle(fontFamily: 'Orkney-bold', color: Colors.blue),
        ),
      ),
    );
  }

  Widget buildDropDown(sizeScreen) {
    return Padding(
      padding: EdgeInsets.only(
        top: sizeScreen * 0.01,
        left: sizeScreen * 0.06,
        right: sizeScreen * 0.06,
      ),
      child: Container(
        padding: EdgeInsets.only(
          top: sizeScreen * 0.02,
          bottom: sizeScreen * 0.02,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue, width: sizeScreen * 0.0008),
          borderRadius: BorderRadius.all(Radius.circular(sizeScreen * 0.02)),
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: sizeScreen * 0.35,
                  child: Center(
                    child: DropdownButton<String>(
                      elevation: 1,
                      value: tipoTarefaDrop,
                      iconEnabledColor: Colors.blue,
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
                          tipoTarefaDrop = newValue;
                          tipoTarefa = tipoTarefaDrop == "Tipo de tarefa" ||
                                  tipoTarefaDrop == "Composta"
                              ? true
                              : false;
                          infoTipoTarefa = tipoTarefaDrop ==
                                  "Tipo de tarefa"
                              ? "Escolha um tipo de tarefa que deseja criar."
                              : tipoTarefaDrop == "Simples"
                                  ? "Você pode criar apenas uma tarefa."
                                  : "Grupo com várias subtarefas.";

                          controllerUnica = TextEditingController();
                          controllerTitulo = TextEditingController();
                          controllerSub = [TextEditingController()];
                          agendaUnica = "Definir data final desta tarefa.";
                          diasAgendados = [
                            false,
                            false,
                            false,
                            false,
                            false,
                            false,
                            false
                          ];
                          corTarefa = Colors.grey;
                          agendarUnica = false;
                        });
                      },
                    ),
                  ),
                ),
                Text(
                  "|  ",
                  style: TextStyle(color: Colors.blue),
                ),
                Container(
                  width: sizeScreen * 0.4,
                  child: Center(
                    child: Text(
                      infoTipoTarefa,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTarefaUnica(context, sizeScreen) {
    return Padding(
      padding: EdgeInsets.only(
        left: sizeScreen * 0.06,
        right: sizeScreen * 0.06,
      ),
      child: Column(
        children: <Widget>[
          Divider(
            color: Colors.transparent,
            height: sizeScreen * 0.05,
          ),
          Container(
            padding: EdgeInsets.all(sizeScreen * 0.01),
            decoration: BoxDecoration(
              border:
                  Border.all(color: Colors.blue, width: sizeScreen * 0.0008),
              borderRadius:
                  BorderRadius.all(Radius.circular(sizeScreen * 0.02)),
            ),
            child: ListTile(
              title: TextField(
                controller: controllerUnica,
                decoration: InputDecoration(
                  hintText: "Tarefa",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
                maxLines: 8,
                minLines: 1,
              ),
              subtitle: dataHoraUnica(context, sizeScreen),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTarefaComposta(context, sizeScreen) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
              top: sizeScreen * 0.02,
              left: sizeScreen * 0.06,
              right: sizeScreen * 0.06,
              bottom: sizeScreen * 0.02),
          child: Container(
            decoration: BoxDecoration(
              border:
                  Border.all(color: Colors.blue, width: sizeScreen * 0.0008),
              borderRadius:
                  BorderRadius.all(Radius.circular(sizeScreen * 0.02)),
            ),
            child: ListTile(
              title: TextField(
                controller: controllerTitulo,
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
                    left: sizeScreen * 0.06,
                    right: sizeScreen * 0.06,
                    bottom: sizeScreen * 0.3,
                  ),
                  itemCount: controllerSub.length,
                  itemBuilder: (BuildContext context, int index) =>
                      buildDetailsBody(context, index, sizeScreen),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget buildDetailsBody(context, index, sizeScreen) {
    return Padding(
      padding: EdgeInsets.only(bottom: sizeScreen * 0.02),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue, width: sizeScreen * 0.0008),
          borderRadius: BorderRadius.all(Radius.circular(sizeScreen * 0.02)),
        ),
        child: ListTile(
          title: TextField(
            controller: controllerSub[index],
            decoration: InputDecoration(
              hintText: "Tarefa",
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
            ),
            maxLines: 8,
            minLines: 1,
          ),
          subtitle: dataHora(context, sizeScreen, index),
          trailing:
              controllerSub[index] == controllerSub[controllerSub.length - 1]
                  ? IconButton(
                      color: Colors.blue[600],
                      icon: Icon(
                        Icons.add_circle_outline,
                      ),
                      onPressed: () {
                        setState(() {
                          controllerSub.add(TextEditingController());
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

                          controllerSub.removeAt(index);
                          dataList["$index"] = null;

                          toDo = Map.from(dataList);

                          for (int i = 0; i <= toDo.length; i++) {
                            if (toDo["$i"] != null) {
                              toDoNovo.add(toDo["$i"]);
                            }
                          }

                          for (int i = 0; i < toDoNovo.length; i++) {
                            toNovo["$i"] = toDoNovo[i];
                          }

                          dataList = toNovo;
                        });
                      },
                    ),
        ),
      ),
    );
  }

  Widget dataHoraUnica(context, sizeScreen) {
    return Row(
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
            child: dataUnica == null || dataUnica["dataForm"] == null
                ? Text("Data e hora")
                : Text(dataUnica["dataForm"] + ","),
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
              dataUnica = dataHora.calendario();
              dataUnica["hora"] =
                  dataUnica["dataForm"] == null ? null : dataUnica["hora"];
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
            child: dataUnica["dataForm"] != null
                ? dataUnica["hora"] == null
                    ? Text("hora")
                    : Text(dataUnica["hora"])
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
                dataUnica["hora"] = retorno;
              } else {
                dataUnica["hora"] = null;
              }
            });
          },
        ),
        dataUnica["dataForm"] != null
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
                    dataUnica["hora"] = null;
                    dataUnica["dataForm"] = null;
                  });
                },
              )
            : Container(
                color: Colors.transparent,
              )
      ],
    );
  }

  Widget dataHora(context, sizeScreen, index) {
    return Row(
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
            child: dataList["$index"] == null ||
                    dataList["$index"]["dataForm"] == null
                ? Text("Data e hora")
                : Text(dataList["$index"]["dataForm"].toString() + ","),
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
              dataList["$index"] = dataHora.calendario();
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
              child: dataList["$index"] != null
                  ? dataList["$index"]["dataForm"] != null
                      ? dataList["$index"]["hora"] == null
                          ? Text("hora")
                          : Text(dataList["$index"]["hora"])
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
                dataList["$index"]["hora"] = retorno;
              } else {
                dataList["$index"]["hora"] = null;
              }
            });
          },
        ),
        dataList["$index"] != null
            ? dataList["$index"]["dataForm"] != null
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
                        dataList["$index"]["hora"] = null;
                        dataList["$index"]["dataForm"] = null;
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

  addToDoUnica(context, sizeScreen) {
    if (controllerUnica.text.trim() != "") {
      Map<String, dynamic> newToDo = Map();
      Tratamentos tratamentos = Tratamentos(
          tarefa: controllerUnica.text.trim(),
          toDoList: widget.toDoList,
          data: dataUnica["dataForm"]);

      newToDo["title"] = controllerUnica.text.trim();
      newToDo["bool"] = false;

      newToDo["dataForm"] =
          dataUnica["dataForm"] != null ? dataUnica["dataForm"] : null;
      newToDo["hora"] = dataUnica["hora"] != null ? dataUnica["hora"] : null;

      newToDo["dia"] = dataUnica["dia"] != null ? dataUnica["dia"] : null;
      newToDo["mes"] = dataUnica["mes"] != null ? dataUnica["mes"] : null;
      newToDo["ano"] = dataUnica["ano"] != null ? dataUnica["ano"] : null;

      newToDo["tipo"] = "simples";
      newToDo["agendada"] = false;
      newToDo["dtInativacao"] = null;

      int coclusao = 0;
      int repeticao = 1;

      coclusao += tratamentos.conclusao();
      repeticao += tratamentos.repeticaoTarefa();

      newToDo["conclusao"] = coclusao;
      newToDo["repeticao"] = repeticao;
      newToDo["dataRepetidao"] = tratamentos.dataRepetidao();
      newToDo["titleFormatado"] = tratamentos.formatarTitulo();

      newToDo["dataAgenda"] = dataAgendada;
      newToDo["diasAgendados"] = agendarValor;

      if (diasAgendados.length != null) {
        for (int i = 0; i < diasAgendados.length; i++) {
          if (diasAgendados[i]) {
            newToDo["agendada"] = true;
          }
        }
      }
      newToDo["idChanel"] = (widget.toDoList.length + 1) * 10;

      Tree tree = Tree(tarefa: newToDo);

      List listaRetorno = tree.decisao();

      if (newToDo["dataForm"] != null) {
        Notificacao notificacao = Notificacao(
            tarefa: newToDo,
            notifications: widget.notifications,
            idChanel: newToDo["idChanel"],
            agendadas: newToDo["agendada"] ? diasAgendados : [false]);

        notificacao.filtro();
      }

      listaRetorno.insert(0, true);
      listaRetorno.add(newToDo);

      return listaRetorno;
    } else {
      List listaRetorno = [false];
      return listaRetorno;
    }
  }

  dialogFunc(sizeScreen, context, listaRetorno) {
    showDialog(
        context: context,
        builder: (BuildContext cont) {
          return CorpoSimples(
              sizeScreen: sizeScreen, listaRetorno: listaRetorno);
        });
  }

  dialogComposta(sizeScreen, context, listaRetorno) {
    showDialog(
        context: context,
        builder: (BuildContext cont) {
          return CorpoComposta(
              sizeScreen: sizeScreen, listaRetorno: listaRetorno);
        });
  }

  addToDo() {
    if (controllerTitulo.text.trim() != "") {
      int qntTarefas = 0;
      int data = 0;

      Map<String, dynamic> newToDo = Map();
      Map<String, dynamic> details = Map();

      Composta trefa = Composta(tarefa: controllerTitulo.text.trim());

      newToDo["title"] = controllerTitulo.text.trim();
      newToDo["bool"] = false;

      newToDo["tipo"] = "composta";
      newToDo["conclusao"] = 0;
      newToDo["agendada"] = false;
      newToDo["dtInativacao"] = null;
      newToDo["titleFormatado"] = trefa.formatarTitulo();

      for (int i = 0; i < controllerSub.length; i++) {
        if (controllerSub[i].text.trim() != "") {
          Map<String, dynamic> content = Map();
          data = dataList["$i"] != null ? 1 : 0;

          content["dia"] =
              dataList["$i"] != null ? dataList["$i"]["dia"] : null;

          content["mes"] =
              dataList["$i"] != null ? dataList["$i"]["mes"] : null;

          content["ano"] =
              dataList["$i"] != null ? dataList["$i"]["ano"] : null;

          content["hora"] =
              dataList["$i"] != null ? dataList["$i"]["hora"] : null;

          content["dataForm"] =
              dataList["$i"] != null ? dataList["$i"]["dataForm"] : null;

          content["title"] = controllerSub[i].text.trim();
          content["bool"] = false;

          content["dtInativacao"] = null;
          content["repeticao"] = 1;
          content["conclusao"] = 0;
          content["tipo"] = "subtarefa";
          content["titleFormatado"] =
              trefa.formatarSubTitulo(content["title"]);

          details["$i"] = content;

          qntTarefas++;
        }
      }

      if (qntTarefas == 0) {
        return [false];
      }

      newToDo["details"] = details;

      Composta repete = Composta(toDoList: widget.toDoList, newToDo: newToDo);

      int repeticao = 0;
      List porcentagemRepete = [];
      repeticao = repete.repeticaoTituloTarefa();
      porcentagemRepete = repete.repeticaoSubTarefa();

      newToDo = porcentagemRepete[1];
      newToDo["porcentagem"] = porcentagemRepete[0];

      Composta concluir = Composta(toDoList: widget.toDoList, newToDo: newToDo);
      newToDo["conclusaoGrupo"] = concluir.conclusao();

      newToDo["repeticao"] = repeticao;
      newToDo["dataGrupo"] = concluir.dataGrupo();
      newToDo["dataRepetida"] =
          newToDo["dataGrupo"] ? concluir.dataRepetida() : false;

      if (diasAgendados != null) {
        for (int i = 0; i < diasAgendados.length; i++) {
          if (diasAgendados[i]) {
            newToDo["agendada"] = true;
          }
        }
      }

      newToDo["dataAgenda"] = dataAgendada;

      newToDo["diasAgendados"] = agendarValor;

      newToDo["idChanel"] = (widget.toDoList.length + 1) * 100;

      Tree tree = Tree(tarefa: newToDo);
      List retorno = tree.decisao();

      if (data > 0) {
        Notificacao notificacao = Notificacao(
            tarefa: newToDo,
            notifications: widget.notifications,
            idChanel: newToDo["idChanel"],
            agendadas: newToDo["agendada"] ? diasAgendados : [false]);

        notificacao.filtro();
      }

      retorno.insert(0, true);
      retorno.add(newToDo);
      retorno.add(porcentagemRepete[2]);

      return retorno;
    } else {
      return [false];
    }
  }
}

class Agendar extends StatefulWidget {
  Agendar({Key key, this.sizeScreen}) : super(key: key);

  double sizeScreen;
  @override
  _AgendarState createState() => _AgendarState();
}

class _AgendarState extends State<Agendar> {
  @override
  Widget build(BuildContext context) {
    double sizeScreen = 0;
    setState(() {
      sizeScreen = widget.sizeScreen;
    });

    return Padding(
      padding: EdgeInsets.only(
          left: sizeScreen * 0.06,
          right: sizeScreen * 0.06,
          top: sizeScreen * 0.02),
      child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, width: sizeScreen * 0.0008),
            borderRadius: BorderRadius.all(Radius.circular(sizeScreen * 0.02)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text("Agendar"),
                subtitle: Text(
                  "Escolha os dias que a tarefa repete-se.",
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.blue, width: sizeScreen * 0.0008),
                  borderRadius:
                      BorderRadius.all(Radius.circular(sizeScreen * 0.02)),
                ),
                child: ListTile(
                  title: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List<Widget>.generate(7, (dia) {
                        List<String> dias = [
                          "Dom",
                          "Seg",
                          "Ter",
                          "Qua",
                          "Qui",
                          "Sex",
                          "Sáb",
                        ];
                        return InkWell(
                          child: Container(
                            padding: EdgeInsets.all(sizeScreen * 0.008),
                            child: Text(
                              dias[dia],
                              style: TextStyle(
                                  color: diasAgendados[dia]
                                      ? Colors.blue
                                      : Colors.grey),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              diasAgendados[dia] = !diasAgendados[dia];

                              if (diasAgendados[dia]) {
                                agendarUnica = true;
                                agendarValor = diasAgendados;
                              }
                              int contador = 0;

                              for (int i = 0; i < diasAgendados.length; i++) {
                                if (!diasAgendados[i]) {
                                  contador++;
                                }
                              }

                              if (contador == diasAgendados.length) {
                                agendarUnica = false;
                                agendarValor = diasAgendados;
                                agendaUnica =
                                    "Definir data final desta tarefa.";
                                corTarefa = Colors.grey;
                              }
                            });
                          },
                        );
                      })),
                  subtitle: Padding(
                    padding: EdgeInsets.only(top: sizeScreen * 0.025),
                    child: InkWell(
                      child: Container(
                          padding: EdgeInsets.all(sizeScreen * 0.008),
                          child: Text(
                            agendaUnica,
                            style: TextStyle(color: corTarefa),
                          )),
                      onTap: () async {
                        bool verificar = false;
                        for (int i = 0; i < diasAgendados.length; i++) {
                          if (diasAgendados[i]) {
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
                            agendarUnica = picked == null;
                            agendaUnica = agendamento.dataAgendamento();
                            dataAgendada = agendaUnica;

                            corTarefa =
                                agendarUnica ? Colors.grey : Colors.blue;
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
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

class AgendarDialog extends StatefulWidget {
  AgendarDialog({Key key, this.sizeScreen}) : super(key: key);

  double sizeScreen;
  @override
  _AgendarDialogState createState() => _AgendarDialogState();
}

class _AgendarDialogState extends State<AgendarDialog> {
  @override
  Widget build(BuildContext context) {
    double sizeScreen = 0;
    setState(() {
      sizeScreen = widget.sizeScreen;
    });

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: sizeScreen * 0.0008),
        borderRadius: BorderRadius.all(Radius.circular(sizeScreen * 0.02)),
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
                        List<String> dias = [
                          "Dom",
                          "Seg",
                          "Ter",
                          "Qua",
                          "Qui",
                          "Sex",
                          "Sáb",
                        ];
                        setState(() {
                          if (!(diasAgendados == 7)) {
                            agendarUnica = false;
                            for (int i = 0; i < dias.length; i++) {
                              diasAgendados.add(false);
                            }
                          }
                        });
                        return InkWell(
                          child: Container(
                            padding: EdgeInsets.all(sizeScreen * 0.008),
                            child: Text(
                              dias[dia],
                              style: TextStyle(
                                  color: diasAgendados[dia]
                                      ? Colors.blue
                                      : Colors.grey),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              diasAgendados[dia] = !diasAgendados[dia];

                              if (diasAgendados[dia]) {
                                agendarUnica = true;
                                agendarValor = diasAgendados;
                              }

                              int contador = 0;

                              for (int i = 0; i < diasAgendados.length; i++) {
                                if (!diasAgendados[i]) {
                                  contador++;
                                }
                              }

                              if (contador == diasAgendados.length) {
                                agendarUnica = false;
                                agendarValor = diasAgendados;
                                agendaUnica =
                                    "Definir data final desta tarefa.";
                                corTarefa = Colors.grey;
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
                  padding: EdgeInsets.only(
                    top: sizeScreen * 0.008,
                    left: sizeScreen * 0.01,
                    right: sizeScreen * 0.008,
                    bottom: sizeScreen * 0.008,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        agendaUnica,
                        style: TextStyle(color: corTarefa),
                      ),
                    ],
                  )),
              onTap: () async {
                bool verificar = false;
                for (int i = 0; i < diasAgendados.length; i++) {
                  if (diasAgendados[i]) {
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
                    agendarUnica = picked == null;
                    agendaUnica = agendamento.dataAgendamento();
                    dataAgendaDialog = agendaUnica;

                    corTarefa = agendarUnica ? Colors.grey : Colors.blue;
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

class CorpoComposta extends StatefulWidget {
  CorpoComposta({Key key, this.sizeScreen, this.listaRetorno})
      : super(key: key);

  double sizeScreen;
  List listaRetorno;

  _CorpoCompostaState createState() => _CorpoCompostaState();
}

class _CorpoCompostaState extends State<CorpoComposta> {
  @override
  Widget build(BuildContext context) {
    List listaRetorno = widget.listaRetorno;
    double sizeScreen = widget.sizeScreen;

    dynamic toDoList = listaRetorno[3];
    dynamic outras = listaRetorno[4];
    dynamic backup = toDoList;

    Map<String, dynamic> dataUnica = Map();

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
        borderRadius: BorderRadius.circular(sizeScreen * 0.04),
      ),
      title: ListTile(
        title: Text(
          "Parece que você já criou essa tarefa anteriormente!\n",
        ),
        subtitle: Text("Que tal deixá-la agendada?"),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            AgendarDialog(
              sizeScreen: sizeScreen,
            ),
            Divider(
              color: Colors.transparent,
            ),
            ListTile(
              title: TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                maxLines: 8,
                minLines: 1,
              ),
            ),
            Divider(
              color: Colors.grey,
              height: 0,
              indent: sizeScreen * 0.04,
              endIndent: sizeScreen * 0.08,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children:
                  List<Widget>.generate(toDoList["details"].length, (index) {
                TextEditingController controller = TextEditingController(
                    text: toDoList["details"]["$index"]["title"]);

                setState(() {
                  dataUnica["hora"] = toDoList["details"]["$index"]["hora"];
                  dataUnica["dataForm"] =
                      toDoList["details"]["$index"]["dataForm"];
                });

                List backup = [];

                setState(() {
                  if (outras.length != null) {
                    for (int i = 0; i < outras.length; i++) {
                      if (toDoList["details"]["$index"]["titleFormatado"] !=
                          outras[i]["titleFormatado"]) {
                        backup.add(outras[i]);
                        outras = backup;
                      }
                    }
                  }
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
                                top: sizeScreen * 0.015,
                                right: sizeScreen * 0.015,
                                bottom: sizeScreen * 0.015,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(sizeScreen * 0.02)),
                              ),
                              child: toDoList["details"]["$index"]
                                          ["dataForm"] ==
                                      null
                                  ? Text("Data e hora")
                                  : Text(toDoList["details"]["$index"]
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
                                DataHora dataHora = DataHora(picked: picked);
                                dataUnica = dataHora.calendario();
                                toDoList["details"]["$index"]["dataForm"] =
                                    dataUnica["dataForm"];

                                toDoList["details"]["$index"]["dia"] =
                                    dataUnica["dia"];
                                toDoList["details"]["$index"]["mes"] =
                                    dataUnica["mes"];
                                toDoList["details"]["$index"]["ano"] =
                                    dataUnica["ano"];

                                toDoList["details"]["$index"]["hora"] = null;
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
                              child: toDoList["details"]["$index"]
                                          ["dataForm"] !=
                                      null
                                  ? toDoList["details"]["$index"]["hora"] ==
                                          null
                                      ? Text("hora")
                                      : Text(
                                          toDoList["details"]["$index"]["hora"])
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
                                  toDoList["details"]["$index"]["hora"] = null;
                                }
                              });
                            },
                          ),
                          toDoList["details"]["$index"]["dataForm"] != null
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
                                      toDoList["details"]["$index"]["hora"] =
                                          null;
                                      toDoList["details"]["$index"]
                                          ["dataForm"] = null;
                                    });
                                  },
                                )
                              : Container(
                                  color: Colors.transparent,
                                )
                        ],
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
            outras.length > 0
                ? OutrasTarefas(
                    sizeScreen: sizeScreen,
                    outras: outras,
                  )
                : Container(color: Colors.transparent)
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(
            "não agendar",
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () {
            setState(() {
              backup["dataAgenda"] = "";
              backup["diasAgendados"] = [
                false,
                false,
                false,
                false,
                false,
                false,
                false
              ];
              backup["agendada"] = false;
              toDoListDialog.insert(0, backup);
            });

            Notificacao notificacao = Notificacao(
                tarefa: backup,
                notifications: notifications,
                idChanel: backup["idChanel"],
                agendadas: [false]);

            notificacao.filtro();

            Navigator.pop(context);
            Navigator.pop(context, toDoListDialog);
          },
        ),
        FlatButton(
          child: Text(
            "Agendar",
          ),
          onPressed: () {
            setState(() {
              for (int i = 0; i < outras.length; i++) {
                if (outrasCheck[i]) {
                  outras[i]["bool"] = false;
                  toDoList["details"]["${toDoList["details"].length}"] =
                      outras[i];
                }
              }
              toDoList["dataAgenda"] = dataAgendaDialog;
              toDoList["diasAgendados"] = agendarValor;
              toDoList["agendada"] = true;

              Notificacao notificacao = Notificacao(
                  tarefa: toDoList,
                  notifications: notifications,
                  idChanel: toDoList["idChanel"],
                  agendadas: toDoList["diasAgendados"]);

              notificacao.filtro();

              toDoListDialog.insert(0, toDoList);
            });
            Navigator.pop(context);
            Navigator.pop(context, toDoListDialog);
          },
        ),
      ],
    );
  }
}

class OutrasTarefas extends StatefulWidget {
  OutrasTarefas({Key key, this.outras, this.sizeScreen}) : super(key: key);

  List outras;
  double sizeScreen;
  @override
  _OutrasTarefasState createState() => _OutrasTarefasState();
}

class _OutrasTarefasState extends State<OutrasTarefas> {
  @override
  Widget build(BuildContext context) {
    setState(() {
      for (int i = 0; i < widget.outras.length; i++) {
        outrasCheck.add(false);
      }
    });

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Divider(
          color: Colors.grey,
          height: 0,
          indent: widget.sizeScreen * 0.04,
          endIndent: widget.sizeScreen * 0.08,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ExpandablePanel(
              tapHeaderToExpand: true,
              header: Container(
                padding: EdgeInsets.only(
                    top: widget.sizeScreen * 0.04,
                    left: widget.sizeScreen * 0.02,
                    bottom: widget.sizeScreen * 0.04),
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
                              top: widget.sizeScreen * 0.015,
                              right: widget.sizeScreen * 0.015,
                              bottom: widget.sizeScreen * 0.015,
                            ),
                            child: widget.outras[item]["dataForm"] == null
                                ? Text("Data e hora")
                                : Text(widget.outras[item]["dataForm"] + ","),
                          ),
                          onTap: () async {
                            dynamic dataUnica;
                            final DateTime picked = await showDatePicker(
                              context: context,
                              firstDate: new DateTime(2000),
                              lastDate: new DateTime(2030),
                              initialDate: new DateTime.now(),
                            );
                            setState(() {
                              DataHora dataHora = DataHora(picked: picked);
                              dataUnica = dataHora.calendario();
                              widget.outras[item]["dataForm"] =
                                  dataUnica["dataForm"];

                              widget.outras[item]["dia"] = dataUnica["dia"];
                              widget.outras[item]["mes"] = dataUnica["mes"];
                              widget.outras[item]["ano"] = dataUnica["ano"];

                              widget.outras[item]["hora"] = null;
                            });
                          },
                        ),
                        InkWell(
                          child: Container(
                            padding: EdgeInsets.only(
                              top: widget.sizeScreen * 0.015,
                              right: widget.sizeScreen * 0.015,
                              bottom: widget.sizeScreen * 0.015,
                            ),
                            child: widget.outras[item]["dataForm"] != null
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
                        widget.outras[item]["dataForm"] != null
                            ? InkWell(
                                child: Container(
                                  padding: EdgeInsets.only(
                                    top: widget.sizeScreen * 0.015,
                                    right: widget.sizeScreen * 0.015,
                                    bottom: widget.sizeScreen * 0.015,
                                  ),
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.red,
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    widget.outras[item]["hora"] = null;
                                    widget.outras[item]["dataForm"] = null;
                                  });
                                },
                              )
                            : Container(
                                color: Colors.transparent,
                              )
                      ],
                    ),
                    trailing: Checkbox(
                      value: outrasCheck[item],
                      onChanged: (bool press) {
                        setState(() {
                          outrasCheck[item] = !outrasCheck[item];
                        });
                      },
                    ),
                  );
                }),
              ),
            )
          ],
        ),
      ],
    );
  }
}

class CorpoSimples extends StatefulWidget {
  CorpoSimples({Key key, this.sizeScreen, this.listaRetorno})
      : super(key: key);

  double sizeScreen;
  List listaRetorno;

  _CorpoSimplesState createState() => _CorpoSimplesState();
}

class _CorpoSimplesState extends State<CorpoSimples> {
  @override
  Widget build(BuildContext context) {
    List listaRetorno = widget.listaRetorno;
    double sizeScreen = widget.sizeScreen;
    Map<String, dynamic> dataUnica = Map();

    dynamic tarefa = listaRetorno[3];
    dynamic backup = tarefa;
    TextEditingController controller =
        TextEditingController(text: tarefa["title"]);
    setState(() {
      dataUnica["hora"] = tarefa["hora"];
      dataUnica["dataForm"] = tarefa["dataForm"];
    });
    return AlertDialog(
      title: ListTile(
        title: Text(
          "Parece que você já criou essa tarefa algumas vezes!\n",
        ),
        subtitle: Text("Que tal deixá-la agendada?"),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AgendarDialog(
            sizeScreen: sizeScreen,
          ),
          Divider(
            color: Colors.transparent,
          ),
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
                      top: sizeScreen * 0.015,
                      right: sizeScreen * 0.015,
                      bottom: sizeScreen * 0.015,
                    ),
                    child: tarefa["dataForm"] == null
                        ? Text("Data e hora")
                        : Text(tarefa["dataForm"] + ","),
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
                      dataUnica = dataHora.calendario();
                      tarefa["dataForm"] = dataUnica["dataForm"];

                      tarefa["dia"] = dataUnica["dia"];
                      tarefa["mes"] = dataUnica["mes"];
                      tarefa["ano"] = dataUnica["ano"];

                      tarefa["hora"] = null;
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
                    child: tarefa["dataForm"] != null
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
            "não agendar",
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () {
            setState(() {
              backup["agendada"] = false;
              backup["dataAgenda"] = "";
              backup["diasAgendados"] = [
                false,
                false,
                false,
                false,
                false,
                false,
                false
              ];
              toDoListDialog.insert(0, backup);
            });

            if (backup["dataForm"] != null) {
              Notificacao notificacao = Notificacao(
                  tarefa: backup,
                  notifications: notifications,
                  idChanel: backup["idChanel"],
                  agendadas: [false]);

              notificacao.filtro();
            }

            Navigator.pop(context);
            Navigator.pop(context, toDoListDialog);
          },
        ),
        FlatButton(
          child: Text(
            "Agendar",
          ),
          onPressed: () {
            setState(() {
              for (int i = 0; i < diasAgendados.length; i++) {
                if (diasAgendados[i]) {
                  tarefa["agendada"] = true;
                  break;
                }
              }
              tarefa["diasAgendados"] = diasAgendados;
              tarefa["dataAgenda"] = dataAgendaDialog;
              toDoListDialog.insert(0, tarefa);
            });

            Notificacao notificacao = Notificacao(
                tarefa: tarefa,
                notifications: notifications,
                idChanel: tarefa["idChanel"],
                agendadas: tarefa["diasAgendados"]);

            notificacao.filtro();

            Navigator.pop(context);
            Navigator.pop(context, toDoListDialog);
          },
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(sizeScreen * 0.04),
      ),
    );
  }
}
