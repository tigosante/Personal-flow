import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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

  static String dataTratada(DateTime data) {
    if (data != null) {
      return data
          .toString()
          .split(" ")
          .toList()[0]
          .split("-")
          .toList()
          .reversed
          .join("/");
    }
    return "";
  }

  static String horaTratada(TimeOfDay hora) {
    if (hora != null) {
      return hora.toString().split("TimeOfDay(")[1].split(")")[0];
    }
    return "";
  }
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
