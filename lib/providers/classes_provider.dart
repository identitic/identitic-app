import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'package:identitic/models/class.dart';
import 'package:identitic/models/user.dart';
import 'package:identitic/services/classes_service.dart';

//not in use

class ClassesProvider with ChangeNotifier {
  ClassesService _classesService = ClassesService();
  List<Class> _classes;

  List<Class> get classes => _classes;

  Future<void> fetchClasses(User user) async {
    try {
      _classes = await _classesService.fetchClasses(user);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
