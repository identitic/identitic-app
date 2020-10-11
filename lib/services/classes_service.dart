import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:identitic/models/class.dart';
import 'package:identitic/models/user.dart';
import 'package:identitic/services/exceptions.dart';
import 'package:identitic/services/storage_service.dart';
import 'package:identitic/utils/constants.dart';

class ClassesService {
  Future<List<Class>> fetchClasses(User user) async {
    final String token =
        await StorageService.instance.getEncrypted(StorageKey.token, null);

    List<Class> classes;

    var jsonHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    Map<String, dynamic> params = {
      'id_user': user.id,
      'id_school': user.idSchool
    };

    try {
      final http.Response response = await http.post(
          '$apiBaseUrl/teacher/classes',
          headers: jsonHeaders,
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
