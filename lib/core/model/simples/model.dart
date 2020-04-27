import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:personalflow/core/model/modelDefault.dart';

const String collectionSimples = "tarefasSimples";

class ModelTarefaSimples {
  final DocumentReference reference;
  int posicao;
  bool check;
  String title;
  String data = "data";
  String hora = "hora";

  ModelTarefaSimples({
    this.title = "",
    this.check = false,
    this.posicao,
    this.reference,
    this.data,
    this.hora,
  });

  factory ModelTarefaSimples.fromDocument(DocumentSnapshot doc) =>
      ModelTarefaSimples(
        title: doc["title"],
        check: doc["check"],
        data: doc["data"],
        hora: doc["hora"],
        reference: doc.reference,
      );

  Future delete() => reference.delete();
  void updateCheck() => reference.updateData({'check': !check});
  void updateTitulo(text) => reference.updateData({'title': text});

  bool addNovaTarefa(int qntTarefas) {
    bool validacao = title.trim() != "";
    if (validacao) {
      Firestore.instance.collection(collectionSimples).add({
        "title": title,
        "check": check,
        "data": data,
        "hora": hora,
        "posicao": qntTarefas,
      });
    }
    return validacao;
  }

  void saveData(DateTime data) =>
      reference.updateData({'data': ModelDefault.dataTratada(data)});

  void saveHora(TimeOfDay hora) =>
      reference.updateData({'hora': ModelDefault.horaTratada(hora)});
}
