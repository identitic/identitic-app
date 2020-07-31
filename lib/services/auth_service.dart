import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:identitic/services/exceptions.dart';
import 'package:identitic/utils/constants.dart';

class AuthService {
  AuthService._internal();

  static final AuthService instance = AuthService._internal();

  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    String token;
    final String credentials = base64.encode(utf8.encode('$email:$password'));

    final Map<String, String> jsonHeaders = <String, String>{
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Basic $credentials'
    };

    try {
      final http.Response response = await http.post(
        '$apiBaseUrl/general/login',
        headers: jsonHeaders,
      );
      switch (response.statusCode) {
        case 200:
          {
            token = jsonDecode(response.body)['token'];
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

    return token;
  }
}
