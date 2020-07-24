import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:identitic/providers/grades_provider.dart';
import 'package:identitic/pages/grades/widgets/student_grade_list_tile.dart';

class StudentGradesListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GradesProvider>(
      builder: (_, GradesProvider gradesProvider, __) {
        return ListView.separated(
          physics: gradesProvider.grades != null
              ? BouncingScrollPhysics()
              : NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(16),
          itemCount: gradesProvider.grades?.length ?? 10,
          separatorBuilder: (_, int i) => SizedBox(height: 8),
          itemBuilder: (_, int i) {
            if (gradesProvider.grades != null) {
              if (i == 0) {
                return Column(
                  children: <Widget>[
                    ListTile(
                      title: Text('Todas las calificaciones'),
                    ),
                    StudentGradeListTile(gradesProvider.grades[i]),
                  ],
                );
              }
              return StudentGradeListTile(gradesProvider.grades[i]);
            }
            return StudentGradeListTile();
          },
        );
      },
    );
  }
}
