import 'package:flutter/cupertino.dart';
import 'package:identitic/models/student.dart';
import 'package:identitic/services/students_service.dart';

class StudentsProvider with ChangeNotifier {

  StudentsService _studentsService = StudentsService();
  List<Student> _students;

  List<Student> get students => _students;

  Future<List<Student>> fetchStudents(int id) async {
    try {
      _students = await _studentsService.fetchStudents(id);
      notifyListeners();
      return _students;
    } catch (e) {
      rethrow;
    }
  }
}