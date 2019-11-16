import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'notifications_helper.dart';

class NotificationWidget extends StatefulWidget {
  NotificationWidget({Key key, this.body, this.title, this.data}) : super(key: key);

  String title;
  String body;
  String data;


  _NotificationWidgetState createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  FlutterLocalNotificationsPlugin notifications =
      new FlutterLocalNotificationsPlugin();

  @override
  initState() {
    super.initState();

    var android = new AndroidInitializationSettings('ic_launcher');

    var ios = new IOSInitializationSettings();

    var initSettings = new InitializationSettings(android, ios);

    notifications.initialize(initSettings, onSelectNotification: printnoti());
  }

  dynamic printnoti(){
    print("foi");
  }

  @override
  Widget build(BuildContext context) {
    
    return RaisedButton(
      child: Text("Mostrar notificações"),
      onPressed: () => showOngoingNotification(notifications,
          title: widget.title + " - " + widget.data,
          body: "Sua tarefa está chegando ao fim!\nConfere se você não esqueceu de nada.",
          id: 0,
          notificationTime: Time(23, 03),
          dayNotification: Day(25)),
    );
  }
}
