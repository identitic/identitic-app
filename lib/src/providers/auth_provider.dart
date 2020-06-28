import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:identitic/src/models/user.dart';
import 'package:identitic/src/services/auth/auth_service.dart';
import 'package:identitic/src/services/auth/auth_service_adapter.dart';
import 'package:identitic/src/services/storage_service.dart';

class AuthProvider {
  AuthService _authService = AuthServiceAdapter();
  String _token;
  User _user;

  String get token => _token;
  User get user => _user;

  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      _token = await _authService.signInWithEmailAndPassword(email, password);
      if (_token != null) {
        String foo = _token.split('.')[1];
        List<int> res = base64.decode(base64.normalize(foo));
        final dynamic map = json.decode(utf8.decode(res));
        _user = User(
          id: map['sub'],
          hierarchy: map['hierarchy'] == 'adm' || map['hierarchy'] == 'teacher'
              ? UserHierarchy.teacher
              : UserHierarchy.student,
          name: map['name'].toString(),
          lastName: map['lastName'].toString(),
          idSchool: map['school']
          //classs: Class(id: map['className'])
        );
        debugPrint(map);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return _user != null;
  }

  Future<void> signOut() async {
    await StorageService.instance.removeAll();
    await StorageService.instance.removeAllEncrypted();
    _token = null;
  }
}
