import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:identitic/models/notification.dart';

class PushNotificationsProvider {
  PushNotificationsProvider() {
    _initNotifications();
  }

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  List<Notification> _notifications;

  List<Notification> get notifications => _notifications;

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
    }, onLaunch: (Map<String, dynamic> message) async {
      print("===== On Launch =====");
      print(message);
    }, onResume: (Map<String, dynamic> message) async {
      print("===== On Resume =====");
      print(message);
    });
  }
}
