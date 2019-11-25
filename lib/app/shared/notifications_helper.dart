import 'package:flutter/material.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Variáveis gerais
int chenal_id = 0;
int progress = 0;
int maxProgress = 0;

String chenal = "";
String chenal_type = "";

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
    "chanel $chenal$chenal_id}",
    "notificações de tarefas da categoria $chenal_type",
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
Future dia_unico(FlutterLocalNotificationsPlugin notifications,
        {@required String title,
        @required String body,
        @required int id,
        @required DateTime dateTimeNotification}) =>
    dia_unico_notificacao(notifications,
        title: title,
        body: body,
        id: id,
        type: _ongoingUnico,
        dateTime: dateTimeNotification);

Future dia_unico_notificacao(
  FlutterLocalNotificationsPlugin notifications, {
  @required String title,
  @required String body,
  @required NotificationDetails type,
  @required int id,
  DateTime dateTime,
  Time time,
}) =>
    notifications.schedule(id, title, body, dateTime, type);

// Cancelar nofiticações e tarefas
Future cancelar(FlutterLocalNotificationsPlugin notifications,
        {@required int id}) =>
    cancelar_notificacao(notifications, id: id);

Future cancelar_notificacao(
  FlutterLocalNotificationsPlugin notifications, {
  @required int id,
}) =>
    notifications.cancel(id);

// Notificações de tarefas agendadas
Future dia_agendado(FlutterLocalNotificationsPlugin notifications,
        {@required String title,
        @required String body,
        @required int id,
        Time notificationTime,
        Day dayNotification}) =>
    dia_agendado_notificacao(notifications,
        title: title,
        body: body,
        id: id,
        type: _ongoingUnico,
        time: notificationTime,
        day: dayNotification);

Future dia_agendado_notificacao(
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
Future dia_agendado_todos(FlutterLocalNotificationsPlugin notifications,
        {@required String title,
        @required String body,
        @required int id,
        Time notificationTime,
        Day dayNotification}) =>
    dia_agendado_todos_notificacao(notifications,
        title: title,
        body: body,
        id: id,
        type: _ongoingUnico,
        time: notificationTime,
        day: dayNotification);

Future dia_agendado_todos_notificacao(
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
      "chanel $chenal$chenal_id}",
      "notificações de tarefas da categoria $chenal_type",
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
      "chanel $chenal$chenal_id}",
      "notificações de tarefas da categoria $chenal_type",
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
    subtarefa_notificacao(notifications,
        title: title,
        body: body,
        id: id,
        type: _ongoingSubtarefa,
        dateTime: dateTimeNotification);

Future subtarefa_notificacao(
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
    composta_notificacao(notifications,
        title: title,
        body: body,
        id: id,
        type: _ongoingComposta,
        day: day,
        time: time);

Future composta_notificacao(
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
  int id_chanel;

  List agendadas;

  dynamic tarefa;
  dynamic notifications;

  filtro() {
    if (tarefa["details"] == null) {
      chenal = tarefa["title"];
      chenal_id = id_chanel;
      chenal_type = "simples";

      cancelar(notifications, id: id_chanel);

      if (tarefa["agendada"]) {
        int contador = 0;

        for (int i = 0; i < agendadas.length; i++) {
          contador += agendadas[i] ? 1 : 0;
        }

        if (contador == 7) {
          cancelar(notifications, id: id_chanel + contador);

          dia_agendado_todos(notifications,
              title: tarefa["title"],
              body:
                  "Olá, dá uma olhada nessEssa tarefa diária para ver se está tudo ok!",
              id: id_chanel + contador);
        } else {
          for (int i = 0; i < agendadas.length; i++) {
            cancelar(notifications, id: id_chanel + i);

            if (agendadas[i]) {
              dia_agendado(notifications,
                  title: tarefa["title"],
                  body:
                      "Olá, dá uma olhada nessEssa tarefa diária para ver se está tudo ok!",
                  id: id_chanel + i + 1,
                  notificationTime: Time(6, 30),
                  dayNotification: Day(i + 1));
            }
          }
        }
      }
      if (tarefa["data_form"] != null) {
        int ano = tarefa["ano"];
        int mes = tarefa["mes"];
        int dia = tarefa["dia"];

        int hora = tarefa["hora"] != null
            ? int.parse(tarefa["hora"].split(":")[0].trim())
            : 6;
        int minu = tarefa["hora"] != null
            ? int.parse(tarefa["hora"].split(":")[1].trim())
            : 30;

        dia_unico(notifications,
            title: tarefa["title"],
            body:
                "Essa tarefa termina hoje!\nConfere se você não esqueceu nada.",
            id: id_chanel,
            dateTimeNotification: DateTime(ano, mes, dia, hora, minu));
      }
    } else {
      bool data_subtarefa = false;

      tarefas.clear();

      for (int i = 0; i < tarefa["details"].length; i++) {
        data_subtarefa = tarefa["details"]["$i"]["dt_inativacao"] == null &&
                tarefa["details"]["$i"]["data_form"] != null
            ? true
            : data_subtarefa;
      }

      if (data_subtarefa) {
        inboxStyleInformationSubtarefa =
            InboxStyleInformation(tarefas, summaryText: tarefa["title"]);

        for (int i = 0; i < tarefa["details"].length; i++) {
          if (tarefa["details"]["$i"]["dt_inativacao"] == null &&
              tarefa["details"]["$i"]["data_form"] != null) {
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

            cancelar(notifications, id: id_chanel + i + 8);

            subtarefa(notifications,
                title: tarefa["details"]["$i"]["title"],
                body:
                    "Essa subtarefa termina hoje!\nConfere se você não esqueceu nada.",
                id: id_chanel + i + 8,
                dateTimeNotification: DateTime(ano, mes, dia, hora, minu));
          }
        }
      }
      if (tarefa["agendada"]) {
        for (int i = 0; i < 7; i++) {
          if (agendadas[i]) {
            cancelar(notifications, id: id_chanel + i + 1);
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
                id: id_chanel + i + 1,
                day: Day(i),
                time: Time(6, 30));
          }
        }
      }
    }
  }

  Notificacao(
      {this.tarefa, this.notifications, this.id_chanel, this.agendadas});
}
