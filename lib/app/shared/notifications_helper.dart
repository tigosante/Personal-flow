import 'package:flutter/material.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

String chenal = "";
String chenal_type = "";
int chenal_id = 0;

NotificationDetails get _ongoing {
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

Future dia_unico(FlutterLocalNotificationsPlugin notifications,
        {@required String title,
        @required String body,
        @required int id,
        Time notificationTime,
        @required Day dayNotification}) =>
    dia_unico_notificacao(notifications,
        title: title,
        body: body,
        id: id,
        type: _ongoing,
        time: notificationTime,
        day: dayNotification);

Future cancelar_unico(FlutterLocalNotificationsPlugin notifications,
        {@required int id}) =>
    cancelar_unico_notificacao(notifications, id: id);

Future cancelar_unico_notificacao(
  FlutterLocalNotificationsPlugin notifications, {
  @required int id,
}) =>
    notifications.cancel(id);

Future dia_unico_notificacao(
  FlutterLocalNotificationsPlugin notifications, {
  @required String title,
  @required String body,
  @required NotificationDetails type,
  @required int id,
  @required Day day,
  Time time,
}) =>
    notifications.showDailyAtTime(id, title, body, time, type);

Future dia_agendado(FlutterLocalNotificationsPlugin notifications,
        {@required String title,
        @required String body,
        @required int id,
        Time notificationTime,
        @required Day dayNotification}) =>
    dia_agendado_notificacao(notifications,
        title: title,
        body: body,
        id: id,
        type: _ongoing,
        time: notificationTime,
        day: dayNotification);

Future dia_agendado_notificacao(
  FlutterLocalNotificationsPlugin notifications, {
  @required String title,
  @required String body,
  @required NotificationDetails type,
  @required int id,
  @required Day day,
  Time time,
}) =>
    notifications.showWeeklyAtDayAndTime(id, title, body, day, time, type);
// notifications.periodicallyShow(0, title, body, RepeatInterval.EveryMinute,type);

class Notificacao {
  dynamic tarefa;
  dynamic notifications;
  int id_chanel;
  List agendadas;

  dynamic filtro() {
    if (tarefa["details"] == null) {
      chenal = tarefa["title"];
      chenal_id = id_chanel;
      chenal_type = "simples";
      
      cancelar_unico(notifications, id: id_chanel);

      if (tarefa["data_form"] != null) {
        if (tarefa["hora"] != null) {
          if (tarefa["agendada"]) {
          } else {

            dia_unico(notifications,
                title: tarefa["title"],
                body:
                    "Sua tarefa está chegando ao fim!\nConfere se você não esqueceu nada.",
                id: id_chanel,
                notificationTime: Time(
                    int.parse(tarefa["hora"].split(":")[0].trim()),
                    int.parse(tarefa["hora"].split(":")[1].trim())),
                dayNotification:
                    Day(int.parse(tarefa["data_form"].split(" ")[1].trim())));
          }
        } else {

          dia_unico(notifications,
              title: tarefa["title"],
              body:
                  "Sua tarefa está chegando ao fim!\nConfere se você não esqueceu nada.",
              id: id_chanel,
              notificationTime: Time(6, 30),
              dayNotification:
                  Day(int.parse(tarefa["data_form"].split(" ")[1].trim())));
        }
      }
    }
  }

  // int trata_data(data){

  // }

  // dynamic

  Notificacao(
      {this.tarefa, this.notifications, this.id_chanel, this.agendadas});
}
