import 'dart:async';
/* import 'dart:convert'; */
/* import 'dart:io'; */

/* import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http; */

import 'package:identitic/models/notification.dart';

/* import 'package:identitic/services/exceptions.dart'; */
class NotificationsService {
  Future<List<PushNotification>> fetchNotifications() async {
    List<PushNotification> notifications = [
      PushNotification(body: 'Nuevo evento', title: 'Matemática')
    ];

    /* final Map<String, String> jsonHeaders = {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    }; */

    /* try {
      final http.Response response = await http.get(
        '$apiBaseUrl/general/notifications',
        headers: jsonHeaders,
      );
      debugPrint(response.body);
      switch (response.statusCode) {
        case 200:
          {
            final Iterable<dynamic> list = json.decode(response.body)['data'];
            notifications = list.map((e) => PNotification.fromJson(e)).toList();
            break;
          }
        case 401:
          throw UnauthorizedException('UnauthorizedException: Voló todo');
        case 429:
          throw TooManyRequestsException('TooManyRequestsException: Voló todo');
      }
    } on SocketException {
      throw const SocketException('SocketException: Voló todo');
    } catch (e) {
      throw Exception(e);
    } */
    return notifications;
  }
}
