import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

NotificationDetails get _ongoing{
  List<String> lines = new List<String>();

  lines.add('O marcelo é gay!');
  lines.add('É verdade esse bilhete.');

  InboxStyleInformation inboxStyleInformation = new InboxStyleInformation(lines, htmlFormatLines: true);

  final androidChannelSpecifics = AndroidNotificationDetails(
    "your channel id", 
    "your channel name", 
    "your chanel descripition",
    importance: Importance.Max,
    priority: Priority.High,
    ongoing: false,
    autoCancel: true,
    // color: Colors.pink,
    // showProgress: true,
    // maxProgress: 5,
    // progress: 2,
  );
    
  final iosChannelSpecifics = IOSNotificationDetails();
  return NotificationDetails(androidChannelSpecifics, iosChannelSpecifics);
}

Future showOngoingNotification(
  FlutterLocalNotificationsPlugin notifications,{
    @required String title,
    @required String body,
    @required int id = 0,
    @required Time notificationTime,
    @required Day dayNotification
  }
)=> _showNotifications(notifications, title: title, body: body, id: id, type: _ongoing, time: notificationTime, day: dayNotification);

Future _showNotifications(
  FlutterLocalNotificationsPlugin notifications, {
    @required String title,
    @required String body,
    @required NotificationDetails type,
    @required int id,
    @required Time time,
    @required Day day
  }) => 
  notifications.show(id, title, body, type);
  // notifications.showDailyAtTime(id, title, body, time,type);
  // notifications.showWeeklyAtDayAndTime(id, title, body, day,time,type);
  // notifications.periodicallyShow(0, title, body, RepeatInterval.EveryMinute,type);

