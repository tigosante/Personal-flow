import 'model.dart';

abstract class IComposedRepository {
  Stream<List<ModelTarefaComposta>> getTarefas();
}
