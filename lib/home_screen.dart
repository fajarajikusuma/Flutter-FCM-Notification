import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'local_notification_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    LocalNotificationService.initialize(context);

    /// TODO Terminated State
    /// 1. This method call when app in terminated state and you get a notification
    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );

          print(message.notification!.title);
          print(message.notification!.body);

          LocalNotificationService.createAndDisplayNotification(message);
        }
      },
    );

    /// TODO Foreground State
    /// 2. This method only call when App in foreground it mean app must be opened
    FirebaseMessaging.onMessage.listen((message) {
      print("FirebaseMessaging.onMessage.listen");
      if (message.notification != null) {
        print(message.notification!.title);
        print(message.notification!.body);
        LocalNotificationService.createAndDisplayNotification(message);
      }
    });

    /// TODO Background State
    /// 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("FirebaseMessaging.onMessageOpenedApp.listen");
      if (message.notification != null) {
        print(message.notification!.title);
        print(message.notification!.body);

        LocalNotificationService.createAndDisplayNotification(message);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Push Notification App"),
        centerTitle: true,
      ),
      body: Center(
        child: Text("Notification"),
      ),
    );
  }
}
