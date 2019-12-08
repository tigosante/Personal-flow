import 'package:flutter/material.dart';
import 'package:personal_flow/view/home/componentes/agendar.dart';
import 'package:personal_flow/view/novaTarefa/componentes/campoSimples.dart';
import 'package:personal_flow/view/novaTarefa/componentes/camposComposta.dart';
import 'package:personal_flow/view/novaTarefa/componentes/escolhaTarefa.dart';
import 'package:personal_flow/view/novaTarefa/componentes/tipoTarefa.dart';

double _tamanhoTela = 0;
List<Widget> _tarefasCadastrar = [CamposComposta(),CampoSimples()];

class Corpo extends StatefulWidget {
  Corpo({Key key}): super(key: key);

  @override
  _CorpoState createState() => _CorpoState();
}

class _CorpoState extends State<Corpo> {
  @override
  Widget build(BuildContext context) {
    setState(() => _tamanhoTela = MediaQuery.of(context).size.width);

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          EscolhaTarefa(),
          TipoTarefa(),
          Padding(
            padding: EdgeInsets.only(top: _tamanhoTela * 0.05, bottom: _tamanhoTela * 0.03),
            child  : Agendar(cor: Colors.indigo),
          ),
          false ? CampoSimples() : CamposComposta()
        ],
      ),
    );
  }
}
