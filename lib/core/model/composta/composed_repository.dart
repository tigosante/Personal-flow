import 'package:cloud_firestore/cloud_firestore.dart';
import 'composed_repository.interface.dart';
import 'model.dart';

class TarefasRepository implements IComposedRepository {
  final Firestore firestore;
  TarefasRepository(this.firestore);

  @override
  Stream<List<ModelTarefaComposta>> getTarefas() => firestore
      .collection(collectionComposta)
      .orderBy("posicao", descending: true)
      .snapshots()
      .map((query) => query.documents
          .map((doc) => ModelTarefaComposta.fromDocument(doc))
          .toList());
}
