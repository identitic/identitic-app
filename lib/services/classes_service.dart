import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:identitic/models/class.dart';
import 'package:identitic/models/user.dart';
import 'package:identitic/services/exceptions.dart';
import 'package:identitic/utils/constants.dart';

//not in use

class ClassesService {
  Future<List<Class>> fetchClasses(User user) async {
    List<Class> classes;

    Map<String, dynamic> params = {
      'id_user': user.id,
      'id_school': user.idSchool
    };

    try {
      final http.Response response = await http.post(
          '$apiBaseUrl/teacher/classes',
          headers: {
            "Content-Type": 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: json.encode(params));
      switch (response.statusCode) {
        case 200:
          {
            final Iterable<dynamic> list = json.decode(response.body)['data'];
            classes = list.map((e) => Class.fromJson(e)).toList();
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
    return classes;
  }
}
