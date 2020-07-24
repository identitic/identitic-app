import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'package:identitic/models/inattendance.dart';
import 'package:identitic/services/inattendances_service.dart';

class InattendancesProvider with ChangeNotifier {
  InattendancesProvider() {
    fetchInattendances();
  }

  InattendancesService _inattendancesService = InattendancesService();
  List<Inattendance> _inattendances;

  List<Inattendance> get inattendances => _inattendances;

  Future<void> fetchInattendances() async {
    try {
      _inattendances = await _inattendancesService.fetchInattendances();
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> postInattendances(List<Inattendance> inattendances) async {
    try {
      await _inattendancesService.postInattendances(inattendances);
    } catch (e) {
      rethrow;
    }
  }
}
