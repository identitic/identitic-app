import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:identitic/models/notification.dart';
import 'package:identitic/services/notifications_service.dart';


class PushNotificationsProvider {
  PushNotificationsProvider() {
    _initNotifications();
  }

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  List<PushNotification> _notifications = [PushNotification(body: 'Nuevo evento', title: 'Matemática')];

  List<PushNotification> get notifications => _notifications;

  NotificationsService _notificationsService = NotificationsService();

  static Future<dynamic> backgroundMessageHandler(Map<String, dynamic> message) async {
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
      _notifications.add(PushNotification(title: message['title'], body: message['body']));
      print(_notifications);
    }, 
    onBackgroundMessage: Platform.isIOS ? null : backgroundMessageHandler,
    onLaunch: (Map<String, dynamic> message) async {
      print("===== On Launch =====");
      print(message);
      _notifications.add(PushNotification(title: message['title'], body: message['body'], id: message['data']));
    }, onResume: (Map<String, dynamic> message) async {
      print("===== On Resume =====");
      print(message);
      _notifications.add(PushNotification(title: message['title'], body: message['body']));
    });
  }
}
