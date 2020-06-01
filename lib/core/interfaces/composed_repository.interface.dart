import 'package:personalflow/core/models/composta_model.dart';

abstract class IComposedRepository {
  Stream<List<ModelTarefaComposta>> getTarefas();
}
