import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'package:identitic/src/models/class.dart';
import 'package:identitic/src/models/user.dart';
import 'package:identitic/src/services/classes_service.dart';

//not in use

class ClassesProvider with ChangeNotifier {
  ClassesProvider() {
    //fetchClasses();
  }

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
