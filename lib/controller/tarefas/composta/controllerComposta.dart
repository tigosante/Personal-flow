import 'package:flutter/material.dart';


Widget geradorCorpo(quantidade, componente){
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: geradorLista(quantidade, componente)
  );
}

List<Widget> geradorLista(quantidade, componente){
  return List<Widget>.generate(quantidade, (_)=> componente);
}

class CheckBoxComposta{
  bool _estado = false;

  bool get estadoGet => _estado;
  set estadoSet(estadoGet) => _estado = !estadoGet;

  mudarEstado(){
    return _estado ? Icon(Icons.check_circle, color: Colors.teal,) : Icon(Icons.check_circle_outline, color: Colors.red,);
  }
}