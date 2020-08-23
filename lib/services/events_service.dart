import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:identitic/models/class.dart';

import 'package:identitic/models/event.dart';
import 'package:identitic/models/user.dart';
import 'package:identitic/services/exceptions.dart';
import 'package:identitic/services/storage_service.dart';
import 'package:identitic/utils/constants.dart';

class EventsService {
  Future<List<Event>> fetchEvents() async {
    final String token =
        await StorageService.instance.getEncrypted(StorageKey.token, null);
    List<Event> events;

    final Map<String, String> jsonHeaders = <String, String>{
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    };

    try {
      final http.Response response = await http.get(
        '$apiBaseUrl/general/home',
        headers: jsonHeaders,
      );
      switch (response.statusCode) {
        case 200:
          {
            final Iterable<dynamic> list = json.decode(response.body)['data'];
            events = list.map((e) => Event.fromJson(e)).toList();
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
    }
    return events;
  }

  Future<List<Event>> fetchAllEvents(int idClass) async {
    final String token =
        await StorageService.instance.getEncrypted(StorageKey.token, null);
    List<Event> allEvents;

    final Map<String, String> jsonHeaders = <String, String>{
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    };

    try {
      final http.Response response = await http.get(
        '$apiBaseUrl/student/AllEvents/$idClass',
        headers: jsonHeaders,
      );
      switch (response.statusCode) {
        case 200:
          {
            final Iterable<dynamic> list = json.decode(response.body)['data'];
            allEvents = list.map((e) => Event.fromJson(e)).toList();
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
    }
    return allEvents;
  }

  Future<List<Event>> fetchAllEventsTeacher() async {
    final String token =
        await StorageService.instance.getEncrypted(StorageKey.token, null);
    List<Event> allEvents;

    final Map<String, String> jsonHeaders = <String, String>{
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    };

    try {
      final http.Response response = await http.get(
        '$apiBaseUrl/teacher/AllEvents',
        headers: jsonHeaders,
      );
      switch (response.statusCode) {
        case 200:
          {
            final Iterable<dynamic> list = json.decode(response.body)['data'];
            allEvents = list.map((e) => Event.fromJson(e)).toList();
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
    }
    return allEvents;
  }

  Future<void> postEvent(User user, Event event, Class classs) async {
    final String token =
        await StorageService.instance.getEncrypted(StorageKey.token, null);

    var params = {
      'id_class': classs.id,
      'id_user': user.id,
      'id_subject': classs.idSubject,
      'date': event.date,
      'title': event.title,
      'ds_event': event.description,
      'event_category_id_category': event.idCategory,
    };

    try {
      final http.Response response = await http.post(
          '$apiBaseUrl/teacher/postevent',
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: json.encode(params));
      switch (response.statusCode) {
        case 200:
          debugPrint(response.body);
          break;
        case 401:
          debugPrint(response.body);
          throw UnauthorizedException('UnauthorizedException: Voló todo');
        case 429:
          debugPrint(response.body);
          throw TooManyRequestsException('TooManyRequestsException: Voló todo');
      }
    } on SocketException {
      throw const SocketException('SocketException: Voló todo');
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
