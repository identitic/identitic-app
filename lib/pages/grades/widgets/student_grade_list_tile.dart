import 'package:flutter/material.dart';

import 'package:identitic/models/grade.dart';

class StudentGradeListTile extends StatelessWidget {
  const StudentGradeListTile([this.grade]);

  final Grade grade;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(grade?.subject?.toString() ?? 'Matemática'),
      trailing: CircleAvatar(
        backgroundColor: Colors.pink,
        child: Text(
          grade?.value?.toString() ?? '...',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
