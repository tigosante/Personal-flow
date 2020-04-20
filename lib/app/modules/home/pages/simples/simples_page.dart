import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:personalflow/app/model/simples/model.dart';
import 'package:personalflow/app/modules/componentes/card_tarefa/simples/tarefa_simples.dart';
import 'package:personalflow/app/modules/home/pages/simples/simples_controller.dart';

class SimplesPage extends StatelessWidget {
  final controller = Modular.get<SimplesController>();

  @override
  Widget build(BuildContext context) {
    double tamanhoTela = MediaQuery.of(context).size.width;

    return Center(
        child: Container(
            width: tamanhoTela * 0.95,
            child: Observer(builder: (_) {
              dynamic snapshot = controller.tarefaSimples;

              if (snapshot.hasError)
                return Center(
                    child: RaisedButton(
                        child: Text("Carregar novamente!"),
                        onPressed: controller.getList));

              if (snapshot.data == null)
                return Center(child: CircularProgressIndicator());

              List<ModelTarefaSimples> tarefas = snapshot.data;

              return ListView.builder(
                  padding: EdgeInsets.only(
                    top: tamanhoTela * 0.03,
                    bottom: tamanhoTela * 0.2,
                  ),
                  itemCount: tarefas.length,
                  itemBuilder: (BuildContext _, int index) {
                    return TarefaSimples(
                        title: tarefas[index].title,
                        check: tarefas[index].check);
                  });
            })));
  }
}
