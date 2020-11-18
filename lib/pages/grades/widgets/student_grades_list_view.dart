import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:identitic/models/grade.dart';
import 'package:identitic/providers/auth_provider.dart';
import 'package:identitic/providers/grades_provider.dart';
import 'package:identitic/pages/grades/widgets/student_grade_list_tile.dart';

class StudentGradesListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<GradesProvider>(context, listen: false).fetchGrades(
          Provider.of<AuthProvider>(context, listen: false).user.id),
      builder: (_, AsyncSnapshot snapshot) {
        final List<Grade> _grades = snapshot.data;
        if (snapshot.hasData) {
          if (_grades.isNotEmpty) {
            return ListView.separated(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: _grades.length,
                padding: EdgeInsets.all(16),
                separatorBuilder: (_, int i) {
                  return SizedBox(height: 8);
                },
                itemBuilder: (_, int i) {
                  return StudentGradeListTile(_grades[i]);
                });
          }
          return Center(
              child: Text('Todavía no hay calificaciones disponibles'));
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
