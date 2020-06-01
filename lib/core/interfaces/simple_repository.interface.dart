import 'package:personalflow/core/models/simples_model.dart';

abstract class ISimpleRepository {
  Stream<List<ModelTarefaSimples>> getTarefas();
}
