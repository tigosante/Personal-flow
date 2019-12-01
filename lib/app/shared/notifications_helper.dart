import 'package:flutter/material.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Variáveis gerais
int chenalId = 0;
int progress = 0;
int maxProgress = 0;

String chenal = "";
String chenalType = "";

dynamic style = AndroidNotificationStyle.BigText;

List<String> tarefas = [];

InboxStyleInformation inboxStyleInformationComposta =
    InboxStyleInformation(tarefas);
InboxStyleInformation inboxStyleInformationSubtarefa =
    InboxStyleInformation(tarefas);

// Simples

// Formato das notificações únicas para android e ios
NotificationDetails get _ongoingUnico {
  final androidChannelSpecifics = AndroidNotificationDetails(
    chenal,
    "chanel $chenal$chenalId}",
    "notificações de tarefas da categoria $chenalType",
    importance: Importance.Max,
    priority: Priority.High,
    ongoing: false,
    autoCancel: true,
    style: AndroidNotificationStyle.BigText,
  );

  final iosChannelSpecifics = IOSNotificationDetails();
  return NotificationDetails(androidChannelSpecifics, iosChannelSpecifics);
}

// Notificação e tarefas com dia único
Future diaUnico(FlutterLocalNotificationsPlugin notifications,
        {String title, String body, int id, DateTime dateTimeNotification}) =>
    diaUnicoNotificacao(notifications,
        id: id,
        title: title,
        body: body,
        type: _ongoingUnico,
        dateTime: dateTimeNotification);

Future diaUnicoNotificacao(
  FlutterLocalNotificationsPlugin notifications, {
  int id,
  String title,
  String body,
  DateTime dateTime,
  NotificationDetails type,
}) =>
    notifications.schedule(id, title, body, dateTime, type);

// Cancelar nofiticações e tarefas
Future cancelar(FlutterLocalNotificationsPlugin notifications,
        {@required int id}) =>
    cancelarNotificacao(notifications, id: id);

Future cancelarNotificacao(
  FlutterLocalNotificationsPlugin notifications, {
  @required int id,
}) =>
    notifications.cancel(id);

// Notificações de tarefas agendadas
Future diaAgendado(FlutterLocalNotificationsPlugin notifications,
        {@required String title,
        @required String body,
        @required int id,
        Time notificationTime,
        Day dayNotification}) =>
    diaAgendadoNotificacao(notifications,
        title: title,
        body: body,
        id: id,
        type: _ongoingUnico,
        time: notificationTime,
        day: dayNotification);

Future diaAgendadoNotificacao(
  FlutterLocalNotificationsPlugin notifications, {
  @required String title,
  @required String body,
  @required NotificationDetails type,
  @required int id,
  Day day,
  Time time,
}) =>
    notifications.showWeeklyAtDayAndTime(id, title, body, day, time, type);

// Notificações de tarefas agendadas  para todos os dias
Future diaAgendadoTodos(FlutterLocalNotificationsPlugin notifications,
        {@required String title,
        @required String body,
        @required int id,
        Time notificationTime,
        Day dayNotification}) =>
    diaAgendadoTodosNotificacao(notifications,
        title: title,
        body: body,
        id: id,
        type: _ongoingUnico,
        time: notificationTime,
        day: dayNotification);

Future diaAgendadoTodosNotificacao(
  FlutterLocalNotificationsPlugin notifications, {
  @required String title,
  @required String body,
  @required NotificationDetails type,
  @required int id,
  Day day,
  Time time,
}) =>
    notifications.periodicallyShow(id, title, body, RepeatInterval.Daily, type);

// Composta

// Formato das notificações agendadas para android e ios
NotificationDetails get _ongoingComposta {
  final androidChannelSpecifics = AndroidNotificationDetails(
      chenal,
      "chanel $chenal$chenalId}",
      "notificações de tarefas da categoria $chenalType",
      importance: Importance.Max,
      priority: Priority.High,
      ongoing: false,
      autoCancel: true,
      styleInformation: inboxStyleInformationComposta,
      style: style,
      progress: progress,
      maxProgress: maxProgress,
      showProgress: true);

  final iosChannelSpecifics = IOSNotificationDetails();
  return NotificationDetails(androidChannelSpecifics, iosChannelSpecifics);
}

NotificationDetails get _ongoingSubtarefa {
  final androidChannelSpecifics = AndroidNotificationDetails(
      chenal,
      "chanel $chenal$chenalId}",
      "notificações de tarefas da categoria $chenalType",
      importance: Importance.Max,
      priority: Priority.High,
      ongoing: false,
      autoCancel: true,
      styleInformation: inboxStyleInformationSubtarefa,
      style: AndroidNotificationStyle.BigText);

  final iosChannelSpecifics = IOSNotificationDetails();
  return NotificationDetails(androidChannelSpecifics, iosChannelSpecifics);
}

Future subtarefa(FlutterLocalNotificationsPlugin notifications,
        {@required String title,
        @required String body,
        @required int id,
        @required DateTime dateTimeNotification}) =>
    subtarefaNotificacao(notifications,
        title: title,
        body: body,
        id: id,
        type: _ongoingSubtarefa,
        dateTime: dateTimeNotification);

Future subtarefaNotificacao(
  FlutterLocalNotificationsPlugin notifications, {
  @required String title,
  @required String body,
  @required NotificationDetails type,
  @required int id,
  DateTime dateTime,
}) =>
    notifications.schedule(id, title, body, dateTime, type);

Future composta(
  FlutterLocalNotificationsPlugin notifications, {
  @required String title,
  @required String body,
  @required int id,
  @required Day day,
  @required Time time,
}) =>
    compostaNotificacao(notifications,
        title: title,
        body: body,
        id: id,
        type: _ongoingComposta,
        day: day,
        time: time);

Future compostaNotificacao(
  FlutterLocalNotificationsPlugin notifications, {
  @required String title,
  @required String body,
  @required NotificationDetails type,
  @required int id,
  @required Day day,
  @required Time time,
}) =>
    notifications.showWeeklyAtDayAndTime(id, title, body, day, time, type);

class Notificacao {
  int idChanel;

  List agendadas;

  dynamic tarefa;
  dynamic notifications;

  filtro() {
    if (tarefa["details"] == null) {
      chenal = tarefa["title"];
      chenalId = idChanel;
      chenalType = "simples";

      cancelar(notifications, id: idChanel);

      if (tarefa["agendada"]) {
        int contador = 0;

        for (int i = 0; i < agendadas.length; i++) {
          contador += agendadas[i] ? 1 : 0;
        }

        if (contador == 7) {
          cancelar(notifications, id: idChanel + contador);

          diaAgendadoTodos(notifications,
              title: tarefa["title"],
              body:
                  "Olá, dá uma olhada nessEssa tarefa diária para ver se está tudo ok!",
              id: idChanel + contador);
        } else {
          for (int i = 0; i < agendadas.length; i++) {
            cancelar(notifications, id: idChanel + i);

            if (agendadas[i]) {
              diaAgendado(notifications,
                  title: tarefa["title"],
                  body:
                      "Olá, dá uma olhada nessEssa tarefa diária para ver se está tudo ok!",
                  id: idChanel + i + 1,
                  notificationTime: Time(6, 30),
                  dayNotification: Day(i + 1));
            }
          }
        }
      }
      if (tarefa["dataForm"] != null) {
        int ano = tarefa["ano"];
        int mes = tarefa["mes"];
        int dia = tarefa["dia"];

        int hora = tarefa["hora"] != null
            ? int.parse(tarefa["hora"].split(":")[0].trim())
            : 6;
        int minu = tarefa["hora"] != null
            ? int.parse(tarefa["hora"].split(":")[1].trim())
            : 30;

        diaUnico(notifications,
            title: tarefa["title"],
            body:
                "Essa tarefa termina hoje!\nConfere se você não esqueceu nada.",
            id: idChanel,
            dateTimeNotification: DateTime(ano, mes, dia, hora, minu, 0, 0, 0));
      }
    } else {
      bool dataSubtarefa = false;

      tarefas.clear();

      for (int i = 0; i < tarefa["details"].length; i++) {
        dataSubtarefa = tarefa["details"]["$i"]["dtInativacao"] == null &&
                tarefa["details"]["$i"]["dataForm"] != null
            ? true
            : dataSubtarefa;
      }

      if (dataSubtarefa) {
        inboxStyleInformationSubtarefa =
            InboxStyleInformation(tarefas, summaryText: tarefa["title"]);

        for (int i = 0; i < tarefa["details"].length; i++) {
          if (tarefa["details"]["$i"]["dtInativacao"] == null &&
              tarefa["details"]["$i"]["dataForm"] != null) {

            int ano = tarefa["details"]["$i"]["ano"];
            int mes = tarefa["details"]["$i"]["mes"];
            int dia = tarefa["details"]["$i"]["dia"];

            int hora = tarefa["details"]["$i"]["hora"] != null
                ? int.parse(
                    tarefa["details"]["$i"]["hora"].split(":")[0].trim())
                : 6;
            int minu = tarefa["details"]["$i"]["hora"] != null
                ? int.parse(
                    tarefa["details"]["$i"]["hora"].split(":")[1].trim())
                : 30;

            cancelar(notifications, id: idChanel + i + 8);

            subtarefa(notifications,
                title: tarefa["details"]["$i"]["title"],
                body:
                    "Essa subtarefa termina hoje!\nConfere se você não esqueceu nada.",
                id: idChanel + i + 8,
                dateTimeNotification: DateTime(ano, mes, dia, hora, minu));
          }
        }
      }
      if (tarefa["agendada"]) {
        for (int i = 0; i < 7; i++) {
          if (agendadas[i]) {
            cancelar(notifications, id: idChanel + i + 1);
            for (int j = 0; j < tarefa["details"].length; j++) {
              if (tarefa["details"].length > 7) {
                if (i == 6) {
                  tarefas.add("...");
                  break;
                } else {
                  tarefas.add(tarefa["details"]["$j"]["title"]);
                }
              } else {
                tarefas.add(tarefa["details"]["$j"]["title"]);
              }
              progress += tarefa["details"]["$j"]["bool"] ? 1 : 0;
            }

            inboxStyleInformationComposta = InboxStyleInformation(tarefas,
                htmlFormatLines: true,
                contentTitle: tarefa["title"],
                summaryText: tarefa["title"]);
            style = AndroidNotificationStyle.Inbox;

            maxProgress = tarefa["details"].length;

            composta(notifications,
                title: "Confere se você não esqueceu nada.",
                body: "Progresso",
                id: idChanel + i + 1,
                day: Day(i),
                time: Time(6, 30));
          }
        }
      }
    }
  }

  Notificacao(
      {this.tarefa, this.notifications, this.idChanel, this.agendadas});
}
