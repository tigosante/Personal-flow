import 'model.dart';

abstract class ISimpleRepository {
  Stream<List<ModelTarefaSimples>> getTarefas();
}
