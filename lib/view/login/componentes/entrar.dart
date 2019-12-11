import 'package:flutter/material.dart';
import 'package:personal_flow/view/novaTarefa/componentes/campoSimples.dart';
import 'package:personal_flow/view/novaTarefa/novaTarefa.dart';

bool _aperta = true;
double _tamanhoTela = 0;
double _altura = 0;

class Entrar extends StatefulWidget {
  Entrar({Key key}) : super(key: key);

  @override
  _EntrarState createState() => _EntrarState();
}

class _EntrarState extends State<Entrar> {
  @override
  Widget build(BuildContext context) {
    setState((){
      _tamanhoTela = MediaQuery.of(context).size.width;
      _altura = MediaQuery.of(context).size.height;
      });

    return GestureDetector(
      onTap: ()=> setState(()=> _aperta = !_aperta),

      child: AnimatedContainer(
        curve: Curves.decelerate,
        duration: Duration(seconds: 1),
        width: _aperta ? _tamanhoTela * 0.15 : _tamanhoTela * 0.15,
        height: _aperta ? _tamanhoTela * 0.15 : _tamanhoTela * 0.15,
        decoration: BoxDecoration(
            color: _aperta ? Colors.amber : Colors.amber,
            borderRadius: BorderRadius.circular(
                _aperta ? _tamanhoTela * 0.3 : _tamanhoTela)),
        child:AnimatedCrossFade(
          crossFadeState: _aperta ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          duration: Duration(seconds: 1),
          firstChild: Center(child: Text("porra")),
          secondChild: Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
