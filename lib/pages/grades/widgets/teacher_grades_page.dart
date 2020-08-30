import 'dart:async';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:identitic/models/class.dart';
import 'package:identitic/models/student.dart';
import 'package:identitic/models/grade.dart';
import 'package:identitic/models/user.dart';
import 'package:identitic/providers/auth_provider.dart';
import 'package:identitic/providers/grades_provider.dart';
import 'package:identitic/pages/grades/widgets/grade_list_tile.dart';
import 'package:identitic/providers/students_provider.dart';

class TeacherGradesPage extends StatelessWidget {
  TeacherGradesPage(this.classs);

  final Class classs;

  final List<Grade> grades = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Calificaciones',
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Student>>(
        future: _fetchStudents(context, classs),
        builder: (_, AsyncSnapshot<List<Student>> snapshot) {
          final List<Student> students = snapshot.data;
          if (snapshot.hasData) {
            return ListView.separated(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(16),
              separatorBuilder: (_, int i) {
                return SizedBox(height: 8);
              },
              itemCount: students.length,
              itemBuilder: (_, int i) {
                return GradeListTile(students[i], grades[i]);
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _postGrades(
            context,
            Provider.of<AuthProvider>(context, listen: false).user,
            grades,
            classs),
        label: Row(
          children: <Widget>[
            Icon(Icons.send),
            SizedBox(width: 8),
            Text('Enviar'),
          ],
        ),
      ),
    );
  }

  Future<List<Student>> _fetchStudents(
      BuildContext context, Class classs) async {
    List<Student> _students =
        await Provider.of<StudentsProvider>(context, listen: false)
            .fetchStudents(classs.id);

    if (_students.isNotEmpty) {
      _students.forEach((student) {
        grades.add(Grade(idUser: student.idStudent));
        return student;
      });
    }
    return _students;
  }

  void _postGrades(
      BuildContext context, User user, List<Grade> grades, Class classs) async {
    await Provider.of<GradesProvider>(context, listen: false)
        .postGrades(user, grades, classs);
    Navigator.pop(context);
  }
}
