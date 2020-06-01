import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personalflow/core/interfaces/composed_repository.interface.dart';
import 'package:personalflow/core/models/composta_model.dart';

class TarefaCompostaRepository implements IComposedRepository {
  final Firestore firestore;
  TarefaCompostaRepository(this.firestore);

  @override
  Stream<List<ModelTarefaComposta>> getTarefas() => firestore
      .collection(collectionComposta)
      .orderBy("posicao", descending: true)
      .snapshots()
      .map((QuerySnapshot query) => query.documents
          .map((doc) => ModelTarefaComposta.fromDocument(doc))
          .toList());
}
