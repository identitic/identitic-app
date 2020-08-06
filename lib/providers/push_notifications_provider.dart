import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsProvider {

  PushNotificationsProvider(){
    _initNotifications();
  }

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  _initNotifications(){
    _firebaseMessaging.requestNotificationPermissions();

    _firebaseMessaging.getToken().then((token) 
      {
        print("===== FCM TOKEN =====");
        print(token);
      });

    _firebaseMessaging.configure(

      onMessage: (info){
        print("===== On Message =====");
        print(info);
      },

      onLaunch: (info){
        print("===== On Launch =====");
        print(info);
      },

      onResume: (info){
        print("===== On Resume =====");
        print(info);
      }
    );

  }
  
}