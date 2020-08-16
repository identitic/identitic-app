import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'package:identitic/models/inattendance.dart';
import 'package:identitic/services/inattendances_service.dart';

class InattendancesProvider with ChangeNotifier {
  
  InattendancesService _inattendancesService = InattendancesService();
  List<Inattendance> _inattendances;

  List<Inattendance> get inattendances => _inattendances;

  //Antes era void. Lo cambié para que el FutureBuilder funcione.
  Future<List<Inattendance>> fetchInattendances(int idUser) async {
    try {
      _inattendances = await _inattendancesService.fetchInattendances(idUser);
      notifyListeners();
      return _inattendances;
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
