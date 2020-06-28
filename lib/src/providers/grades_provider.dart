import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:identitic/src/models/class.dart';

import 'package:identitic/src/models/grade.dart';
import 'package:identitic/src/models/user.dart';
import 'package:identitic/src/services/grades_service.dart';

class GradesProvider with ChangeNotifier {
  
  GradesProvider() {
    fetchGrades();
  }

  GradesService _gradesService = GradesService();
  List<Grade> _grades;

  List<Grade> get grades => _grades;

  Future<void> fetchGrades() async {
    try {
      _grades = await _gradesService.fetchGrades();
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> postGrades(User user, List<Grade> grades, Class classs) async {
    try {
      await _gradesService.postGrades(user, grades, classs);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
