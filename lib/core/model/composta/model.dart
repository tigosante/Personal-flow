import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

const String collectionComposta = "tarefasComposta";

class ModelTarefaComposta {
  final DocumentReference reference;
  int posicao;
  bool check;
  String title;
  String data = "data";
  String hora = "hora";
  Subtarefa subtarefa;

  ModelTarefaComposta({
    this.title = "",
    this.check = false,
    this.posicao,
    this.reference,
    this.data,
    this.hora,
    this.subtarefa,
  });

  factory ModelTarefaComposta.fromDocument(DocumentSnapshot doc) =>
      ModelTarefaComposta(
          title: doc["title"],
          check: doc["check"],
          data: doc["data"],
          hora: doc["hora"],
          reference: doc.reference,
          subtarefa: Subtarefa.fromDocument(doc));

  Future delete() => reference.delete();
  void updateCheck() => reference.updateData({'check': !check});
  void updateTitulo(text) => reference.updateData({'title': text});

  bool addNovaTarefa(int qntTarefas) {
    bool validacao = title.trim() != "";
    if (validacao) {
      Firestore.instance.collection(collectionComposta).add({
        "title": title,
        "check": check,
        "data": data,
        "hora": hora,
        "posicao": qntTarefas,
      });
    }
    return validacao;
  }

  void saveData(DateTime data) {
    if (data != null) {
      reference.updateData({'data': dataTratada(data)});
    }
  }

  void saveHora(TimeOfDay hora) {
    if (hora != null) {
      reference.updateData({'hora': horaTratada(hora)});
    }
  }

  static String dataTratada(DateTime data) => data
      .toString()
      .split(" ")
      .toList()[0]
      .split("-")
      .toList()
      .reversed
      .join("/");

  static String horaTratada(TimeOfDay hora) =>
      hora.toString().split("TimeOfDay(")[1].split(")")[0];
}

class Subtarefa {
  final DocumentReference reference;
  int posicao;
  bool check;
  String title;
  String data = "data";
  String hora = "hora";

  Subtarefa({
    this.reference,
    this.posicao,
    this.check,
    this.title,
    this.data,
    this.hora,
  });

  factory Subtarefa.fromDocument(DocumentSnapshot doc) {
    return Subtarefa(
      title: doc["title"],
      check: doc["check"],
      data: doc["data"],
      hora: doc["hora"],
      reference: doc.reference,
    );
  }
}
