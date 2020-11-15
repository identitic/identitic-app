import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:identitic/models/notification.dart';
import 'package:identitic/services/notifications_service.dart';

class NotificationsProvider {
  NotificationsProvider() {
    _initNotifications();
  }

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  List<PushNotification> _notifications = [];

  List<PushNotification> get notifications => _notifications;

  NotificationsService _notificationsService = NotificationsService();

  static Future<dynamic> backgroundMessageHandler(
      Map<String, dynamic> message) async {
    print(message);
  }

  Future<List<PushNotification>> fetchNotifications() async {
    _notifications = await _notificationsService.fetchNotifications();
    return _notifications;
  }

  _initNotifications() {
    _firebaseMessaging.requestNotificationPermissions();

    _firebaseMessaging.getToken().then((token) {
      print("===== FCM TOKEN =====");
      print(token);
    });

    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print("===== On Message =====");
          print(message);
          _notifications.add(PushNotification(
              title: message['notification']['title'],
              body: message['notification']
                  ['body'])); //Así es cuando es por firebase testing
          print(_notifications[1].body);
        },
        onBackgroundMessage: Platform.isIOS ? null : backgroundMessageHandler,
        onLaunch: (Map<String, dynamic> message) async {
          print("===== On Launch =====");
          print(message);
          _notifications.add(PushNotification(
              title: message['title'],
              body: message['body'],
              id: message['data']));
        },
        onResume: (Map<String, dynamic> message) async {
          print("===== On Resume =====");
          print(message);
          _notifications.add(
              PushNotification(title: message['title'], body: message['body']));
        });
  }
}
