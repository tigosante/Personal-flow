import 'package:cloud_firestore/cloud_firestore.dart';

class ModelTarefaSimples {
  final DocumentReference reference;
  String title;
  bool check;

  ModelTarefaSimples({
    this.title,
    this.check,
    this.reference,
  });

  factory ModelTarefaSimples.fromDocument(DocumentSnapshot doc) {
    return ModelTarefaSimples(
        title: doc["title"], check: doc["check"], reference: doc.reference);
  }
}
