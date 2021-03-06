import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:identitic/src/models/inattendance.dart';
import 'package:identitic/src/services/exceptions.dart';
import 'package:identitic/src/utils/constants.dart';

class InattendancesService {
  Future<List<Inattendance>> fetchInattendances() async {
    List<Inattendance> inattendances;

    const Map<String, String> jsonHeaders = <String, String>{
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    };

    try {
      final http.Response response = await http.get(
        '${apiBaseUrl}student/attendance/1',
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
    const Map<String, String> jsonHeaders = <String, String>{
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjQ0NTk0NzIzLCJoaWVyYXJjaHkiOiJhZG0iLCJjbGFzc05hbWUiOm51bGwsInNjaG9vbCI6MSwic2hvb2xOYW1lIjoiVUJBIiwiaWF0IjoxNTg5NzU1MzQxLCJleHAiOjE1OTEwNTEzNDF9.DBHeC-QgnyR1FSkAGwEVPQPVQnfuC2hY4ZXrCEalMUM'
    };

    Map<String, dynamic> params = {
          "absenses": [
            for (int i = 1; i < inattendances.length; i++)
              <String, dynamic>{
                'users_id_user': inattendances[i].idUser,
                'date': DateTime.now().toString(),
                'status': inattendances[i].value
              }
            ],
    };

    try {
      final http.Response response = await http.post(
        '{$apiBaseUrl}teacher/uploadabsenses',
        headers: jsonHeaders,
        body: json.encode(params)
      );
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
