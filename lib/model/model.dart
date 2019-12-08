class SimplesModel {
  String titulo;
  String data;
  String hora;
  bool concluida;
  bool composta;
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
  String titulo;
  String data;
  String hora;
  bool concluida;
  bool composta;
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
  String titulo;
  String data;
  String hora;
  bool concluida;

  Subtarefa(
      {this.titulo = "",
      this.concluida = false,
      this.data      = "",
      this.hora      = ""});
}
