import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:personalflow/app/componentes/card_tarefa/componentes/botoes.dart';
import 'package:personalflow/app/componentes/data_hora/composta/data_hora.dart';
import '../../../screens/home/pages/composta/composta_controller.dart';
import 'componentes/barra_progresso.dart';
import 'componentes/body.dart';

class TarefaComposta extends StatelessWidget {
  TarefaComposta({Key key, this.index}) : super(key: key);

  final int index;
  final controller = Modular.get<CompostaController>();

  @override
  Widget build(BuildContext context) {
    dynamic tarefaData = controller.tarefaComposta.data[index];
    double tamanhoTela = MediaQuery.of(context).size.width;

    return StreamBuilder(
        stream: tarefaData.subtarefa,
        builder: (_, AsyncSnapshot snapshot) {
          if (snapshot.hasError)
            return Center(
                child: FlatButton(
                    child: Text("Carregar novamente!"),
                    onPressed: controller.getList));

          if (snapshot.data == null)
            return Center(child: CircularProgressIndicator());

          return Card(
              elevation: 0,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(tamanhoTela * 0.05)),
              child: ExpansionTile(
                  title: Padding(
                      padding: EdgeInsets.only(
                          top: tamanhoTela * 0.03, left: tamanhoTela * 0.018),
                      child: Text(tarefaData.title,
                          style: TextStyle(
                              fontSize: tamanhoTela * 0.045,
                              fontWeight: FontWeight.bold))),
                  subtitle: Column(children: <Widget>[
                    Container(
                        width: tamanhoTela,
                        child: DataHoraComsposta(
                            dataHora: [tarefaData.data, tarefaData.hora])),
                    Padding(
                        padding: EdgeInsets.only(left: tamanhoTela * 0.02),
                        child: Container(
                            width: tamanhoTela,
                            height: tamanhoTela * 0.06,
                            child: BarraProgresso(
                                tamanhoTela: tamanhoTela,
                                data: snapshot.data,
                                max: snapshot.data.length))),
                  ]),
                  children: <Widget>[
                    BodyComposta(data: snapshot.data),
                    BotoesTarefa(tamanhoTela: tamanhoTela)
                  ]));
        });
  }
}
