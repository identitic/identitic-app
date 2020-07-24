import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:identitic/models/messages/message.dart';
import 'package:identitic/models/messages/room.dart';
import 'package:identitic/services/exceptions.dart';
import 'package:identitic/utils/constants.dart';

class MessagesService {
  Future<List<Message>> fetchMessages(int idUser) async {
    List<Message> messages;

    const Map<String, String> jsonHeaders = <String, String>{
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    };

    try {
      final http.Response response = await http.get(
        '${apiBaseUrl}chat/getMessagesById/$idUser',
        headers: jsonHeaders,
      );
      switch (response.statusCode) {
        case 200:
          {
            final Iterable<dynamic> list = json.decode(response.body)['data'];
            messages = list.map((e) => Message.fromJson(e)).toList();
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
    return messages;
  }

  Future<List<Room>> fetchRooms(int idUser) async {
    List<Room> rooms;

    const Map<String, String> jsonHeaders = <String, String>{
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    };

    try {
      final http.Response response = await http.get(
        '${apiBaseUrl}chat/getRoomsById/$idUser',
        headers: jsonHeaders,
      );
      switch (response.statusCode) {
        case 200:
          {
            final Iterable<dynamic> list = json.decode(response.body)['data'];
            rooms = list.map((e) => Room.fromJson(e)).toList();
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
    return rooms;
  }
}
