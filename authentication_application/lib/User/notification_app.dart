import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationFunctionality extends StatefulWidget {
  const NotificationFunctionality({super.key});

  @override
  State<NotificationFunctionality> createState() => _NotificationFunctionalityState();
}

class _NotificationFunctionalityState extends State<NotificationFunctionality> {
  late FlutterLocalNotificationsPlugin localNotification;

  @override
  void initState() {
    super.initState();
    var androidInitialize = const AndroidInitializationSettings('ic_launcher');
    var iosInitialize = const DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    // Set up initialization settings for both platforms
    var initializationSettings = InitializationSettings(android: androidInitialize, iOS: iosInitialize);
    localNotification = FlutterLocalNotificationsPlugin();
    localNotification.initialize(initializationSettings);
  }

  Future _showNotification() async {
    var androidDetails = const AndroidNotificationDetails(
      "channelId", 
      "Local Notification",
      importance: Importance.high,
      priority: Priority.high,
    );

    var iosDetails = const DarwinNotificationDetails(
      presentAlert: true, 
      presentBadge: true, 
      presentSound: true,
    );

    var generalNotificationDetails = NotificationDetails(android: androidDetails, iOS: iosDetails);

    await localNotification.show(
      0, 
      "Notif title", 
      "The body of the Notification", 
      generalNotificationDetails
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Click a button to receive a notification"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showNotification,
        child: const Icon(Icons.notifications)
      )
    );
  }
}
