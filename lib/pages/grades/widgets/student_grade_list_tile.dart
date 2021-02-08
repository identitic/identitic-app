import 'package:flutter/material.dart';

import 'package:identitic/models/grade.dart';
import 'package:identitic/utils/constants.dart';

class StudentGradeListTile extends StatelessWidget {
  const StudentGradeListTile([this.grade]);

  final Grade grade;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(grade?.subject?.toString() ?? 'Matemática'),
      onTap: () => {
        Navigator.pushNamed(context, RouteName.grade_info, arguments: grade)
      },
      trailing: CircleAvatar(
        backgroundColor: Colors.pink,
        child: Text(
          grade?.value?.toString() ?? '?',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
