import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:identitic/src/utils/constants.dart';

class StorageService {
  StorageService._internal();

  static final StorageService instance = StorageService._internal();

  Future<void> set(String key, dynamic value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    switch (value.runtimeType) {
      case bool:
        {
          sharedPreferences.setBool(key, value);
          break;
        }
      case String:
        {
          sharedPreferences.setString(key, value);
          break;
        }
      case int:
        {
          sharedPreferences.setInt(key, value);
          break;
        }
      case double:
        sharedPreferences.setDouble(key, value);
    }
  }

  Future<dynamic> get(String key, dynamic defaultValue) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.get(key) ?? defaultValue;
  }

  Future<void> remove(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(key);
  }

  Future<void> removeAll() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }

  Future<void> setEncrypted(String key, dynamic value) async {
    if (isMobile) {
      await FlutterSecureStorage().write(
        key: key,
        value: value,
      );
    } else {
      await set(key, value);
    }
  }

  Future<dynamic> getEncrypted(String key, dynamic defaultValue) async {
    if (isMobile) {
      return await FlutterSecureStorage().read(key: key) ?? defaultValue;
    }
    return await get(key, defaultValue);
  }

  Future<void> removeEncrypted(String key) async {
    if (isMobile) {
      await FlutterSecureStorage().delete(key: key);
    } else {
      await remove(key);
    }
  }

  Future<void> removeAllEncrypted() async {
    if (isMobile) {
      await FlutterSecureStorage().deleteAll();
    } else {
      await removeAll();
    }
  }
}
