import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:personalflow/app/modules/componentes/barra_pesquisa/barra_pesquisa.dart';
import 'package:personalflow/app/modules/componentes/card_tarefa/composta/tarefa_composta.dart';
import 'package:personalflow/app/modules/componentes/card_tarefa/simples/tarefa_simples.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Modular.get<HomeController>();

  @override
  Widget build(BuildContext context) {
    double tamanhoTela = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: <Widget>[
          BarraPesquisa(),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(
                top: tamanhoTela * 0.03,
                bottom: tamanhoTela * 0.2,
              ),
              itemCount: 7,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                    padding: EdgeInsets.only(
                        left: tamanhoTela * 0.01,
                        right: tamanhoTela * 0.01,
                        bottom: tamanhoTela * 0.01),
                    child: index % 2 == 0 ? TarefaComposta() : TarefaSimples());
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          elevation: 10,
          label: Text("Adiconar tarefa", style: TextStyle(color: Colors.white)),
          icon: Icon(Icons.playlist_add_check, color: Colors.white),
          backgroundColor: Colors.purple[900],
          onPressed: controller.navigationNewTask),
    );
  }
}
