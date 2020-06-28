import 'package:flutter/material.dart';

import 'package:identitic/src/models/grade.dart';
import 'package:identitic/src/ui/widgets/identitic_container.dart';

class StudentGradeListTile extends StatelessWidget {
  const StudentGradeListTile([this.grade]);

  final Grade grade;

  @override
  Widget build(BuildContext context) {
    return IdentiticContainer(
      child: ListTile(
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
      ),
    );
  }
}
