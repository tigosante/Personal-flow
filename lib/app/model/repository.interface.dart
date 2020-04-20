import 'package:personalflow/app/model/model.dart';

abstract class IRepository {
  Stream<List<ModelTarefaSimples>> getTarefas();
}
