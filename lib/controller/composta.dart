import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:personal_flow/view/home/componentes/composta/barraProgresso.dart';
import 'package:personal_flow/view/home/componentes/composta/subtarefa.dart';

int _maxValue = 0;
int _currentValue = 0;

Widget geradorCorpo(documentID) {
  final db = Firestore.instance;

  return StreamBuilder(
      stream: db
          .collection("tarefas")
          .document(documentID)
          .collection("subtarefa")
          .snapshots(),
      builder: (context, snapshot) {
        _maxValue = snapshot.data.documents.length;
        _currentValue = currentValue(snapshot.data.documents);
        return Column(
            mainAxisSize      : MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children          : List.generate(_maxValue, (int item) {
              dynamic subtarefa = snapshot.data.documents[item];
              return Subtarefa(
                  titulo   : subtarefa["titulo"],
                  data     : subtarefa["data"],
                  hora     : subtarefa["hora"],
                  concluida: subtarefa["concluida"]);
            }));
      });
}

int currentValue(dynamic itens){
  int valor = 0;
  for (var item in itens) {
    valor += item["concluida"] ? 1 : 0;
  }
  return valor;
}

Widget barraProgresso(Color cor) {
  return BarraProgresso(
    maxValue     : _maxValue,
    currentValue : _currentValue,
    progressColor: cor,
  );
}

Icon mudarEstado(_estado) {
  return _estado
      ? Icon(
          Icons.check_circle,
          color: Colors.indigo,
        )
      : Icon(
          Icons.panorama_fish_eye,
          color: Colors.indigo[300],
        );
}
