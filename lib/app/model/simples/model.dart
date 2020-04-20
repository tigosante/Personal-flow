import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personalflow/app/controller/contr_simples.dart';

class ModelTarefaSimples {
  final DocumentReference reference;
  int posicao;
  String title;
  bool check;

  ModelTarefaSimples({
    this.title = "",
    this.check = false,
    this.posicao,
    this.reference,
  });

  factory ModelTarefaSimples.fromDocument(DocumentSnapshot doc) =>
      ModelTarefaSimples(
          title: doc["title"], check: doc["check"], reference: doc.reference);

  void updateCheck() => reference.updateData({'check': !check});
  Future delete() => reference.delete();
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
}
