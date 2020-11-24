import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:identitic/services/profilephoto_service.dart';
import 'package:identitic/services/storage_service.dart';
import 'package:identitic/utils/constants.dart';

class ProfilePhotoProvider with ChangeNotifier {
  ProfilePhotoService _profilePhotoService = ProfilePhotoService();
  File _photo;

  File get photo => _photo;

  Future<void> uploadPhoto(File photo) async {
    try {
      _photo = photo;
      await _profilePhotoService.uploadPhoto(photo);
      if (_photo != null) {
        StorageService.instance.setEncrypted(StorageKey.profilePhoto, photo.path);
      }
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
