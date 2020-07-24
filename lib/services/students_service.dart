import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:identitic/models/student.dart';
import 'package:identitic/services/exceptions.dart';
import 'package:identitic/utils/constants.dart';

class StudentsService {
  Future<List<Student>> fetchStudents() async {
    List<Student> students;

    const Map<String, String> jsonHeaders = <String, String>{
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    };

    try {
      final http.Response response = await http.get(
        '${apiBaseUrl}students.php',
        headers: jsonHeaders,
      );
      switch (response.statusCode) {
        case 200:
          {
            final Iterable<dynamic> list =
                json.decode(response.body)['students'];
            students = list.map((e) => Student.fromJson(e)).toList();
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

    return students;
  }

  Future<List<Student>> fetchStudentsByClass() async {
    List<Student> students;

    const Map<String, String> jsonHeaders = <String, String>{
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    };

    try {
      final http.Response response = await http.get(
        '${apiBaseUrl}teacher/class/3',
        headers: jsonHeaders,
      );
      switch (response.statusCode) {
        case 200:
          {
            final Iterable<dynamic> list = json.decode(response.body)['data'];
            students = list.map((e) => Student.fromJson(e)).toList();

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

    return students;
  }
}
