import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:identitic/models/notification.dart';
import 'package:identitic/services/notifications_service.dart';

class PushNotificationsProvider {
  PushNotificationsProvider() {
    _initNotifications();
  }

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  List<PNotification> _notifications = [PNotification(body: 'Nuevo evento', title: 'Matemática')];

  List<PNotification> get notifications => _notifications;

  NotificationsService _notificationsService = NotificationsService();


  Future<List<PNotification>> fetchNotifications() async {
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
      _notifications.add(PNotification(title: message['title'], body: message['body']));
    }, onLaunch: (Map<String, dynamic> message) async {
      print("===== On Launch =====");
      print(message);
      _notifications.add(PNotification(title: message['title'], body: message['body']));
    }, onResume: (Map<String, dynamic> message) async {
      print("===== On Resume =====");
      print(message);
      _notifications.add(PNotification(title: message['title'], body: message['body']));
    });
  }
}
