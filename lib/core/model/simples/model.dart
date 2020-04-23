import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

const String collectionSimples = "tarefasSimples";

class ModelTarefaSimples {
  final DocumentReference reference;
  int posicao;
  bool check;
  String title;
  String data;
  String hora;

  ModelTarefaSimples({
    this.title = "",
    this.check = false,
    this.posicao,
    this.reference,
    this.data,
    this.hora,
  });

  factory ModelTarefaSimples.fromDocument(DocumentSnapshot doc) {
    return ModelTarefaSimples(
      title: doc["title"],
      check: doc["check"],
      data: doc["data"],
      hora: doc["hora"],
      reference: doc.reference,
    );
  }

  Future delete() => reference.delete();
  void updateCheck() => reference.updateData({'check': !check});
  void updateTitulo(text) => reference.updateData({'title': text});

  bool addNovaTarefa(int qntTarefas) {
    bool validacao = title.trim() != "";
    if (validacao) {
      Firestore.instance
          .collection(collectionSimples)
          .add({"title": title, "check": check, "posicao": qntTarefas});
    }
    return validacao;
  }

  void saveData(DateTime data) {
    if (data != null) {
      reference.updateData({'data': _dataTratada(data)});
    }
  }

  void saveHora(TimeOfDay hora) {
    if (hora != null) {
      reference.updateData({'hora': _horaTratada(hora)});
    }
  }

  String _dataTratada(DateTime data) => data
      .toString()
      .split(" ")
      .toList()[0]
      .split("-")
      .toList()
      .reversed
      .join("-");

  String _horaTratada(TimeOfDay data) =>
      data.toString().split("TimeOfDay(")[1].split(")")[0];
}
