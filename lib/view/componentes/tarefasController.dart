import 'package:personal_flow/model/model.dart';

class TarefasController {
  List tarefas = [];

  List<String> _titlulos = ["foi", "indo", "deu", "bom"];
  List<String> subtarefa = ["a", "b", "c"];

  popular() {
    for (int i = 0; i < _titlulos.length; i++) {
      if (i % 2 == 0) {
        tarefas.add(SimplesModel(
            titulo  : _titlulos[i],
            data    : "08/12/19",
            hora    : "00:00",
            agendada: [false, false, false, true, true, false, false]));
      } else {
        tarefas.add(CompostaModel(
            titulo    : _titlulos[i],
            data      : "08/12/19",
            hora      : "00:00",
            agendada  : [false, false, false, true, true, false, false],
            subtarefas: List<Subtarefa>.generate(
                subtarefa.length,
                (sub) => Subtarefa(
                      titulo: subtarefa[sub],
                      data  : "08/12/12",
                      hora  : "00:00",
                    ))));
      }
    }
  }
}
