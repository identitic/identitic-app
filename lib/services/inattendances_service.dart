import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:identitic/models/inattendance.dart';
import 'package:identitic/services/exceptions.dart';
import 'package:identitic/services/storage_service.dart';
import 'package:identitic/utils/constants.dart';

class InattendancesService {
  Future<List<Inattendance>> fetchInattendances(int idUser) async {
    final String token =
        await StorageService.instance.getEncrypted(StorageKey.token, null);
    List<Inattendance> inattendances;

    final Map<String, String> jsonHeaders = {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    };

    try {
      final http.Response response = await http.get(
        '$apiBaseUrl/student/attendance/$idUser',
        headers: jsonHeaders,
      );
      switch (response.statusCode) {
        case 200:
          {
            final Iterable<dynamic> list = json.decode(response.body)['data'];
            inattendances = list.map((e) => Inattendance.fromJson(e)).toList();
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
    return inattendances;
  }

  Future<void> postInattendances(List<Inattendance> inattendances) async {
    final String token =
        await StorageService.instance.getEncrypted(StorageKey.token, null);

    var jsonHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    Map<String, dynamic> params = {
      "absenses": [
        for (int i = 0; i < inattendances.length; i++)
          <String, dynamic>{
            'users_id_user': inattendances[i].idUser,
            'date': DateTime.now().toIso8601String().toString(),
            'status': inattendances[i].value,
          },
      ],
    };

    try {
      final http.Response response = await http.post(
          '$apiBaseUrl/teacher/uploadabsenses',
          headers: jsonHeaders,
          body: json.encode(params));
      debugPrint(json.encode(params));
      debugPrint(response.body);
      switch (response.statusCode) {
        case 200:
          break;
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
  }
}
