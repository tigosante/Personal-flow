import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personalflow/app/controller/contr_simples.dart';

class ModelTarefaSimples {
  final DocumentReference reference;
  String title;
  bool check;

  ModelTarefaSimples({
    this.title = "",
    this.check = false,
    this.reference,
  });

  factory ModelTarefaSimples.fromDocument(DocumentSnapshot doc) =>
      ModelTarefaSimples(
          title: doc["title"], check: doc["check"], reference: doc.reference);

  void updateCheck() => reference.updateData({'check': !check});
  void updateTitulo(text) => reference.updateData({'title': text});

  void addNovaTarefa() => Firestore.instance
      .collection(collectionSimples)
      .add({"title": title, "check": check});
}
