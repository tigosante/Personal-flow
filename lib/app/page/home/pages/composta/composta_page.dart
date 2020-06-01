import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:personalflow/app/componentes/card_tarefa/composta/tarefa_composta.dart';

import 'composta_controller.dart';

class CompostaPage extends StatelessWidget {
  final controller = Modular.get<CompostaController>();

  @override
  Widget build(BuildContext context) {
    double tamanhoTela = MediaQuery.of(context).size.width;

    return Center(
        child: Container(
            width: tamanhoTela * 0.95,
            child: Observer(builder: (_) {
              dynamic snapshot = controller.tarefaComposta;

              if (snapshot.hasError)
                return Center(
                    child: RaisedButton(
                        child: Text("Carregar novamente!"),
                        onPressed: controller.getList));

              if (snapshot.data == null)
                return Center(child: CircularProgressIndicator());

              controller.qntTarefas = snapshot.data.length;

              return ListView.builder(
                  padding: EdgeInsets.only(
                      top: tamanhoTela * 0.03, bottom: tamanhoTela * 0.2),
                  itemCount: controller.qntTarefas,
                  itemBuilder: (BuildContext _, int index) =>
                      TarefaComposta(index: index));
            })));
  }
}
