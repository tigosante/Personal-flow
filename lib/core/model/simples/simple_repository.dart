import 'package:personalflow/core/model/simples/simple_repository.interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'model.dart';

class TarefaSimplesRepository implements ISimpleRepository {
  final Firestore firestore;
  TarefaSimplesRepository(this.firestore);

  @override
  Stream<List<ModelTarefaSimples>> getTarefas() => firestore
      .collection(collectionSimples)
      .orderBy("posicao", descending: true)
      .snapshots()
      .map((query) => query.documents
          .map((doc) => ModelTarefaSimples.fromDocument(doc))
          .toList());
}
