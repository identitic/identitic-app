import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:identitic/src/models/user.dart';
import 'package:identitic/src/providers/auth_provider.dart';
import 'package:identitic/src/ui/pages/classes/classes_page.dart';
import 'package:identitic/src/ui/pages/grades/widgets/student_grades_page.dart';

final selected = ClassPageType.grades;

class GradesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    switch (Provider.of<AuthProvider>(context, listen: false).user.hierarchy) {
      case UserHierarchy.student:
          return StudentGradesPage();
      case UserHierarchy.teacher:
        return ClassesPage(selected);
      default:
        return ClassesPage(selected);
    }

  }
}
