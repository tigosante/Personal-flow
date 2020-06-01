import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:personalflow/core/models/modelDefault.dart';

const String collectionComposta = "tarefaComposta";

class ModelTarefaComposta {
  final DocumentReference reference;
  int posicao;
  int concluidas;
  bool check;
  String title;
  String data = "data";
  String hora = "hora";
  Stream<List<Subtarefa>> subtarefa;

  ModelTarefaComposta({
    this.title = "",
    this.check = false,
    this.posicao,
    this.concluidas,
    this.reference,
    this.data,
    this.hora,
    this.subtarefa,
  });

  factory ModelTarefaComposta.fromDocument(DocumentSnapshot doc) {
    return ModelTarefaComposta(
        title: doc["title"],
        check: doc["check"],
        data: doc["data"],
        hora: doc["hora"],
        concluidas: doc["concluidas"],
        reference: doc.reference,
        subtarefa: Firestore.instance
            .collection(collectionComposta)
            .document(doc.documentID)
            .collection("subtarefas")
            .orderBy("posicao", descending: false)
            .snapshots()
            .map((QuerySnapshot query) => query.documents
                .map((doc) => Subtarefa.fromDocument(doc))
                .toList()));
  }

  Future delete() => reference.delete();
  void updateCheck() => reference.updateData({'check': !check});
  void updateTitulo(text) => reference.updateData({'title': text});

  bool addNovaTarefa(int qntTarefas) {
    bool validacao = title.trim() != "";
    if (validacao)
      Firestore.instance.collection(collectionComposta).add({
        "title": title,
        "check": check,
        "data": data,
        "hora": hora,
        "posicao": qntTarefas,
        "concluidas": concluidas,
      });

    return validacao;
  }

  void saveData(DateTime data) =>
      reference.updateData({'data': ModelDefault.dataTratada(data)});

  void saveHora(TimeOfDay hora) =>
      reference.updateData({'hora': ModelDefault.horaTratada(hora)});
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
