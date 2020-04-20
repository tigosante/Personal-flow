import 'package:cloud_firestore/cloud_firestore.dart';

import 'model.dart';
import 'repository.interface.dart';

class TarefasRepository implements IRepository {
  final Firestore firestore;
  TarefasRepository(this.firestore);

  @override
  Stream<List<ModelTarefaSimples>> getTarefas() {
    return firestore.collection("tarefaSimples").snapshots().map((query) {
      return query.documents.map((doc) {
        return ModelTarefaSimples.fromDocument(doc);
      }).toList();
    });
  }
}
