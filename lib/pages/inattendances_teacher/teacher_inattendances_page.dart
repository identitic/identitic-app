import 'dart:async';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:identitic/models/class.dart';
import 'package:identitic/models/inattendance.dart';
import 'package:identitic/models/student.dart';
import 'package:identitic/providers/inattendances_provider.dart';
import 'package:identitic/providers/students_provider.dart';
import 'package:identitic/pages/inattendances_teacher/widgets/teacher_inattendance_list_tile.dart';

class InattendancesTeacherPage extends StatelessWidget {
  InattendancesTeacherPage(this.classs);

  final Class classs;
  final List<Inattendance> inattendances = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Inasistencias',
          style: TextStyle(fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Student>>(
          future: _fetchStudents(context, classs),
          builder: (_, AsyncSnapshot<List<Student>> snapshot) {
            final List<Student> students = snapshot.data;
            if (snapshot.hasData) {
              return ListView.separated(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: students.length ?? 3,
                padding: EdgeInsets.all(16),
                separatorBuilder: (_, __) {
                  return SizedBox(height: 8);
                },
                itemBuilder: (_, int i) {
                  return 
                   InattendanceTeacherListTile(
                      students[i], inattendances[i]);
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => postInattendances(context, inattendances),
        label: Row(
          children: <Widget>[
            Text('Enviar'),
            SizedBox(width: 8),
            Icon(Icons.send),
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
        inattendances.add(Inattendance(idUser: student.idStudent));
        return student;
      });
    }
    return _students;
  }

  void postInattendances(
          BuildContext context, List<Inattendance> _inattendances) async {
    await Provider.of<InattendancesProvider>(context, listen: false)
        .postInattendances(inattendances);
    Navigator.pop(context);
  }
}
