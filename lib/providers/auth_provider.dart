import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:identitic/models/user.dart';
import 'package:identitic/services/auth_service.dart';
import 'package:identitic/services/profilephoto_service.dart';
import 'package:identitic/services/storage_service.dart';
import 'package:identitic/utils/constants.dart';
import 'package:identitic/utils/jwt.dart';

class AuthProvider {
  User _user;

  AuthProvider() {
    _setup();
  }

  User get user => _user;

  /* ProfilePhotoService _photoService = ProfilePhotoService(); */

  Future<void> _setup() async {
    final String token =
        await StorageService.instance.getEncrypted(StorageKey.token, null);
    if (token != null) {
      _user = User.fromJson(JWT.toMap(token));
    }
  }

  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      final String token = await AuthService.instance
          .signInWithEmailAndPassword(email, password);
      if (token != null) {
        print(token);
        _user = User.fromJson(JWT.toMap(token));
        StorageService.instance.setEncrypted(StorageKey.token, token);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return _user != null;
  }

  Future<void> signOut() async {
    await StorageService.instance.removeAll();
    await StorageService.instance.removeAllEncrypted();
    _user = null;
  }

/*   Future<void> updateProfilePhoto(File _newPhoto) async {
    try {
      await _photoService.uploadPhoto(_newPhoto);
      _user.profilePhoto = _newPhoto.path;
    } catch (e) {
      rethrow;
    }
  } */
}
