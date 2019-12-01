class Tree {
  dynamic tarefa;

  dynamic decisao() {
    List listaRetorno = [];
    if (tarefa["agendada"]) {
      listaRetorno.add("TAREFA AGENDADA");
      listaRetorno.add(false);

      return listaRetorno;
    } else {
      switch (tarefa["tipo"]) {
        // Início sub-árvore SIMPLES
        case "simples":
          if (tarefa["repeticao"] >= 3) {
            if (tarefa["conclusao"] >= 2) {
              if (tarefa["dataForm"] != null) {
                if (tarefa["dataRepetidao"] > 1) {
                  listaRetorno.add("data repete");
                  listaRetorno.add(true);

                  return listaRetorno;
                } else {
                  listaRetorno.add("ultima data");
                  listaRetorno.add(true);

                  return listaRetorno;
                }
              } else {
                listaRetorno.add("sem data");
                listaRetorno.add(true);

                return listaRetorno;
              }
            } else {
              listaRetorno.add("conclusao");
              listaRetorno.add(false);

              return listaRetorno;
            }
          } else {
            listaRetorno.add("repeticao");
            listaRetorno.add(false);

            return listaRetorno;
          }
          break;
        // Fim sub-árvore SIMPLES

        // Início sub-árvore COMPOSTA
        case "composta":
          if (tarefa["repeticao"] > 0) {
            if (tarefa["porcentagem"]) {
              if (tarefa["conclusaoGrupo"]) {
                if (tarefa["dataGrupo"]) {
                  if (tarefa["dataRepetida"]) {
                    listaRetorno.add("SUGERIR COM A DATA QUE SE REPETE");
                    listaRetorno.add(true);

                    return listaRetorno;
                  } else {
                    listaRetorno.add("SUGERIR COM A ÚLTIMA DATA");
                    listaRetorno.add(true);

                    return listaRetorno;
                  }
                } else {
                  listaRetorno.add("SUGERIR SEM DATA");
                  listaRetorno.add(true);

                  return listaRetorno;
                }
              } else {
                listaRetorno.add("conclusao grupo");
                listaRetorno.add(false);

                return listaRetorno;
              }
            } else {
              listaRetorno.add("tarefa grupo");
              listaRetorno.add(false);

              return listaRetorno;
            }
          } else {
            listaRetorno.add("repetição grupo");
            listaRetorno.add(false);

            return listaRetorno;
          }
        // Fim sub-árvore COMPOSTA
      }
    }
  }

  Tree({
    this.tarefa,
  });
}

class Tratamentos {
  String tarefa;
  String data;
  dynamic toDoList;

  String formatarTitulo() {
    String tarefaTratada = tarefa.toUpperCase().trim();
    List<String> aux = tarefaTratada.split("");

    tarefaTratada = "";
    for (int i = 0; i < aux.length; i++) {
      tarefaTratada += aux[i].contains(RegExp(r'[A-Z]')) ? aux[i] : "";
    }

    return tarefaTratada;
  }

  int repeticaoTarefa() {
    int repeticoes = 0;
    String title = formatarTitulo();

    for (int i = 0; i < toDoList.length; i++) {
      repeticoes += toDoList[i]["tipo"] == "simples" &&
              toDoList[i]["titleFormatado"] == title
          ? 1
          : 0;
    }

    return repeticoes;
  }

  int conclusao() {
    int conclusoes = 0;
    String title = formatarTitulo();

    for (int i = 0; i < toDoList.length; i++) {
      conclusoes += toDoList[i]["titleFormatado"] == title
          ? toDoList[i]["conclusao"]
          : 0;
    }

    return conclusoes;
  }

  int dataRepetidao() {
    int datas = 0;
    String title = formatarTitulo();

    for (int i = 0; i < toDoList.length; i++) {
      datas += toDoList[i]["titleFormatado"] == title
          ? toDoList[i]["dataForm"] != null && toDoList[i]["dataForm"] == data
              ? 1
              : 0
          : 0;
    }

    return datas;
  }

  Tratamentos({this.tarefa, this.toDoList, this.data});
}

class Composta {
  dynamic newToDo;
  dynamic toDoList;
  String tarefa;

  String formatarTitulo() {
    String tarefaTratada = tarefa.toUpperCase().trim();
    List<String> aux = tarefaTratada.split("");

    tarefaTratada = "";
    for (int i = 0; i < aux.length; i++) {
      tarefaTratada += aux[i].contains(RegExp(r'[A-Z]')) ? aux[i] : "";
    }

    return tarefaTratada;
  }

  String formatarSubTitulo(subTituro) {
    String subTituroTartado = subTituro.toUpperCase().trim();
    List<String> aux = subTituroTartado.split("");

    for (int i = 0; i < aux.length; i++) {
      subTituroTartado = "";
      for (int i = 0; i < aux.length; i++) {
        subTituroTartado += aux[i].contains(RegExp(r'[A-Z]')) ? aux[i] : "";
      }
    }

    return subTituroTartado;
  }

  int repeticaoTituloTarefa() {
    int repete = 0;
    if (toDoList.length > 0) {
      for (int i = 0; i < toDoList.length; i++) {
        if (toDoList[i]["titleFormatado"] == "") {
          continue;
        } else {
          repete += toDoList[i]["titleFormatado"] == newToDo["titleFormatado"]
              ? toDoList[i]["tipo"] == "composta" ? 1 : 0
              : 0;
        }
      }
    }

    return repete;
  }

  List repeticaoSubTarefa() {
    int todo = toDoList.length;
    int sizeTodo = newToDo["details"].length;
    List outras = [];

    if (todo > 0) {
      for (int i = 0; i < todo; i++) {
        if (toDoList[i]["tipo"] == "composta") {
          for (int j = 0; j < todo; j++) {
            if (toDoList[j]["tipo"] != "simples") {
              if (toDoList[j]["details"] != null) {
                int todoDetails = toDoList[j]["details"].length;

                for (int k = 0; k < todoDetails; k++) {
                  for (int a = 0; a < sizeTodo; a++) {
                    newToDo["details"]["$a"]
                        ["titleFormatado"] = newToDo["details"]["$a"]
                                ["title"] !=
                            null
                        ? formatarSubTitulo(newToDo["details"]["$a"]["title"])
                        : "";

                    if (toDoList[j]["tipo"] == "composta") {
                      if (toDoList[j]["title"] == newToDo["title"]) {
                        if (toDoList[j]["details"]["$k"]["titleFormatado"] !=
                            null) {
                          if (toDoList[j]["details"]["$k"]["titleFormatado"] ==
                              newToDo["details"]["$a"]["titleFormatado"]) {
                            newToDo["details"]["$a"]["repeticao"] += 1;
                          } else {
                            newToDo["details"]["$a"]["repeticao"] += 0;
                            if (outras.contains(toDoList[j]["details"]["$k"])) {
                              continue;
                            } else {
                              outras.add(toDoList[j]["details"]["$k"]);
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }

    List retorno = [];
    retorno.add(porcentagem(newToDo));
    retorno.add(newToDo);
    retorno.add(outras);

    return retorno;
  }

  bool porcentagem(newToDo) {
    double repete = 0;

    for (int i = 0; i < newToDo["details"].length; i++) {
      repete += newToDo["details"]["$i"]["repeticao"];
    }

    return newToDo["details"].length * 0.7 <= repete;
  }

  bool conclusao() {
    int repeteConclusao = 0;
    if (toDoList.length > 0) {
      for (int i = 0; i < newToDo["details"].length; i++) {
        for (int j = 0; j < toDoList.length; j++) {
          if (toDoList[j]["tipo"] == "composta") {
            for (int k = 0; k < toDoList[j]["details"].length; k++) {
              if (toDoList[j]["details"]["$k"]["titleFormatado"] ==
                  newToDo["details"]["$i"]["titleFormatado"]) {
                repeteConclusao +=
                    toDoList[j]["details"]["$k"]["conclusao"] != 0 ? 1 : 0;
              }
            }
          }
        }
      }
    }

    return newToDo["details"].length * 0.7 <= repeteConclusao;
  }

  bool dataGrupo() {
    for (int i = 0; i < newToDo["details"].length; i++) {
      if (newToDo["details"]["$i"]["dataForm"] != null) {
        return true;
      }
    }

    return false;
  }

  dynamic dataRepetida() {
    if (toDoList.length > 0) {
      for (int i = 0; i < newToDo["details"].length; i++) {
        for (int j = 0; j < toDoList.length; j++) {
          if (toDoList[j]["tipo"] == "composta") {
            for (int k = 0; k < toDoList[j]["details"].length; k++) {
              if (toDoList[j]["details"]["$k"]["title"] ==
                  newToDo["details"]["$i"]["titleFormatado"]) {
                if (toDoList[j]["details"]["$k"]["dataForm"] ==
                    newToDo["details"]["$i"]["dataForm"]) {
                  return true;
                }
              }
            }
          }
        }
      }
    }

    return false;
  }

  Composta({this.toDoList, this.tarefa, this.newToDo});
}
