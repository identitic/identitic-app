import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:identitic/models/class.dart';

import 'package:identitic/models/grade.dart';
import 'package:identitic/models/user.dart';
import 'package:identitic/services/grades_service.dart';

class GradesProvider with ChangeNotifier {

  GradesService _gradesService = GradesService();
  List<Grade> _grades;

  List<Grade> get grades => _grades;

  Future<void> fetchGrades(int idUser) async {
    try {
      _grades = await _gradesService.fetchGrades(idUser);
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
