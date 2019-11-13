import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Tree {
  dynamic tarefa;

  String tipo;
  bool programada;

  String data_unica;
  int repeticao_unica;
  int conclusao_unica;
  int data_repeticao_unica;

  double conclusao_grupo;
  double tarefa_grupo;
  bool data_grupo;
  bool repeticao_grupo;
  bool data_repeticao_grupo;

  dynamic decisao() {
    List lista_retorno = [];
    // if (programada) {
    //   print("programada".toUpperCase());
    // } else {
      switch (tarefa["tipo"]) {
        // Início sub-árvore SIMPLES
        case "simples":
          if (tarefa["repeticao"] >= 3) {
            if (tarefa["conclusao"] >= 2) {
              if (tarefa["data_form"] != null) {
                if (tarefa["data_repeticao"] > 1) {
                  lista_retorno.add("data repete");
                  lista_retorno.add(true);
                  
                  return lista_retorno;
                } else {
                  lista_retorno.add("ultima data");
                  lista_retorno.add(true);
                  
                  return lista_retorno;
                }
              } else {
                lista_retorno.add("sem data");
                lista_retorno.add(true);
                
                return lista_retorno;
              }
            } else {
              lista_retorno.add("conclusao");
              lista_retorno.add(false);
              
              return lista_retorno;
            }
          } else {
            lista_retorno.add("repeticao");
            lista_retorno.add(false);

            return lista_retorno;
          }
          break;
        // Fim sub-árvore SIMPLES

        // Início sub-árvore COMPOSTA
        case "composta":
          if (tarefa["repeticao"] > 0) {
            if (tarefa["porcentagem"]) {
              if (tarefa["conclusao_grupo"]) {
                if (tarefa["data_grupo"]) {
                  if (data_repeticao_grupo) {
                    lista_retorno.add("SUGERIR COM A DATA QUE SE REPETE");
                    lista_retorno.add(true);

                    return lista_retorno;
                  } else {
                    lista_retorno.add("SUGERIR COM A ÚLTIMA DATA");
                    lista_retorno.add(true);

                    return lista_retorno;
                  }
                } else {
                  lista_retorno.add("SUGERIR SEM DATA");
                  lista_retorno.add(true);

                  return lista_retorno;
                }
              } else {
                lista_retorno.add("conclusao grupo");
                lista_retorno.add(false);

                return lista_retorno;
              }
            } else {
              lista_retorno.add("tarefa grupo");
              lista_retorno.add(false);

              return lista_retorno;
            }
          } else {
            lista_retorno.add("repetição grupo");
            lista_retorno.add(false);

            return lista_retorno;
          }
        // Fim sub-árvore COMPOSTA
      }
    // }
  }

  Tree({this.tarefa,});
}

class Tratamentos {
  String tarefa;
  String data;
  dynamic toDoList;

  String formatar_titulo() {
    String tarefa_tratada = tarefa.toUpperCase().trim();
    List<String> aux = tarefa_tratada.split("");

    tarefa_tratada = "";
    for (int i = 0; i < aux.length; i++) {
      tarefa_tratada += aux[i].contains(RegExp(r'[A-Z]')) ? aux[i] : "";
    }

    return tarefa_tratada;
  }

  int repeticao_tarefa(){
    int repeticoes = 0;
    String title = formatar_titulo();

    for(int i = 0; i<toDoList.length; i++){
      repeticoes += toDoList[i]["tipo"] == "simples" && toDoList[i]["title_formatado"] == title ? 1 : 0;
    }
    
    return repeticoes;
  }

  int conclusao(){
    int conclusoes = 0;
    String title = formatar_titulo();

    for(int i = 0; i<toDoList.length; i++){
      conclusoes += toDoList[i]["title_formatado"] == title ? toDoList[i]["conclusao"] : 0;
    }
    
    return conclusoes;
  }

  int data_repeticao(){
    int datas = 0;
    String title = formatar_titulo();

    for(int i = 0; i<toDoList.length; i++){
      datas += toDoList[i]["title_formatado"] == title ? toDoList[i]["data_form"] != null && toDoList[i]["data_form"] == data ? 1 : 0 : 0;
    }
    
    return datas;
  }

  Tratamentos({this.tarefa, this.toDoList, this.data});
}

class Composta{
  dynamic newToDo;
  dynamic toDoList;
  String tarefa;

  String formatar_titulo() {
    String tarefa_tratada = tarefa.toUpperCase().trim();
    List<String> aux = tarefa_tratada.split("");

    tarefa_tratada = "";
    for (int i = 0; i < aux.length; i++) {
      tarefa_tratada += aux[i].contains(RegExp(r'[A-Z]')) ? aux[i] : "";
    }

    return tarefa_tratada;
  }

  String formatar_sub_titulo(sub_tituro) {
    String sub_tituro_tartado = sub_tituro.toUpperCase().trim();
    List<String> aux = sub_tituro_tartado.split("");

    for(int i = 0; i < aux.length; i++){
      sub_tituro_tartado = "";
      for (int i = 0; i < aux.length; i++) {
        sub_tituro_tartado += aux[i].contains(RegExp(r'[A-Z]')) ? aux[i] : "";
      }
    }

    return sub_tituro_tartado;
  }

  int repeticao_titulo_tarefa(){
    int repete = 0;

    for(int i = 0; i<toDoList.length; i++){
      repete += toDoList[i]["title_formatado"] == newToDo["title_formatado"] && toDoList[i]["tipo"] == "composta" ? 1 : 0;
    }
    
    return repete;
  }

  List repeticao_sub_tarefa(){

    for(int i = 0; i < newToDo["details"].length; i++){
      newToDo["details"]["$i"]["title_formatado"] = formatar_sub_titulo(newToDo["details"]["$i"]["title"]);

      for(int j = 0; j < toDoList.length; j++){
        for(int k = 0; k < toDoList[j]["details"].length; k++){
          newToDo["details"]["$i"]["repeticao"] += toDoList[j]["tipo"] == "composta" ? toDoList[j]["details"]["$k"]["title"] == newToDo["details"]["$i"]["title_formatado"] ? 1 : 0 : 0;
        }
      }
    }
    List retorno = [];
    retorno.add(porcentagem(newToDo));
    retorno.add(newToDo);

    return retorno;
  }

  bool porcentagem(newToDo){
    double repete = 0;

    for(int i =0; i<newToDo["details"].length; i++){
      repete += newToDo["details"]["$i"]["repeticao"];
    }

    return newToDo["details"].length * 0.7 <= repete;

  }

  bool conclsuao(){
    int repete_conclusao = 0;
    for(int i = 0; i<newToDo["details"].length; i++){
      for(int j = 0; j<toDoList.length; j++){
        for(int k = 0; k<toDoList[j]["details"].length; k++){
          if(toDoList[j]["tipo"] == "composta"){
            if(toDoList[j]["details"]["$k"]["title"] == newToDo["details"]["$i"]["title_formatado"]){
              repete_conclusao += toDoList[j]["details"]["$k"]["conclusao"] != 0 ? 1 : 0;
            }
          }
        }
      }
    }

    return newToDo["details"].length * 0.7 <= repete_conclusao;
  }

  bool data_grupo(){
    for(int i = 0; i < newToDo["details"].length; i++){
      if(newToDo["details"]["$i"]["data_form"] != null){
        return true;
      }
    }

    return false;
  }
  // dynamic data_repetica(){
    
  // }



  Composta({this.toDoList, this.tarefa, this.newToDo});
}
