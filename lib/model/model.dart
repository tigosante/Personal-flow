import 'package:cloud_firestore/cloud_firestore.dart';

gravarBanco() {
  Firestore.instance
      .collection("simples")
      .document()
      .setData({"titulo": "indo", "data": "08/12/12", "hora": "00:00"});
}

receberBanco() async {
  QuerySnapshot snapshot = 
      await Firestore.instance.collection("simples").getDocuments();

  return snapshot;
}

class SimplesModel {
  String data;
  String hora;
  String titulo;
  bool composta;
  bool concluida;
  List<bool> agendada = [false, true, false, false, false, true, false];

  SimplesModel(
      {this.titulo = "",
      this.concluida = false,
      this.composta  = false,
      this.data      = "",
      this.hora      = "",
      this.agendada});
}

class CompostaModel {
  String data;
  String hora;
  String titulo;
  bool composta;
  bool concluida;
  List<bool> agendada = [false, true, false, false, false, true, false];

  List<Subtarefa> subtarefas = [Subtarefa()];

  CompostaModel(
      {this.titulo = "",
      this.concluida = false,
      this.composta  = true,
      this.data      = "",
      this.hora      = "",
      this.subtarefas,
      this.agendada});
}

class Subtarefa {
  String data;
  String hora;
  String titulo;
  bool concluida;

  Subtarefa(
      {this.titulo = "",
      this.concluida = false,
      this.data      = "",
      this.hora      = ""});
}
