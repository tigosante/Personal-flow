import 'package:personalflow/app/model/simples/model.dart';

abstract class ISimpleRepository {
  Stream<List<ModelTarefaSimples>> getTarefas();
}
