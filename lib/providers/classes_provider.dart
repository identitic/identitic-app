import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'package:identitic/models/class.dart';
import 'package:identitic/models/user.dart';
import 'package:identitic/services/classes_service.dart';

class ClassesProvider with ChangeNotifier {
  ClassesService _classesService = ClassesService();
  List<Class> _classes;
  List<Class> _subjects;

  List<Class> get classes => _classes;
  List<Class> get subjects => _subjects;

  Future<List<Class>> fetchClasses(User user) async {
    try {
      _classes = await _classesService.fetchClasses(user);
      notifyListeners();
      return _classes;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Class>> fetchSubjects() async {
    try {
      _subjects = await _classesService.fetchSubjects();
      notifyListeners();
      return _subjects;
    } catch (e) {
      rethrow;
    }
  }
}
