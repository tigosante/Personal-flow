import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personalflow/core/model/simples/simple_repository.interface.dart';

import 'model.dart';

class TarefasRepository implements ISimpleRepository {
  final Firestore firestore;
  TarefasRepository(this.firestore);

  @override
  Stream<List<ModelTarefaSimples>> getTarefas() {
    return firestore
        .collection(collectionSimples)
        .orderBy("posicao", descending: true)
        .snapshots()
        .map((query) {
      return query.documents.map((doc) {
        return ModelTarefaSimples.fromDocument(doc);
      }).toList();
    });
  }
}
