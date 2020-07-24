import 'package:flutter/material.dart';
import 'package:identitic/pages/tasks/widgets/student_tasks_page.dart';

import 'package:provider/provider.dart';

import 'package:identitic/models/user.dart';
import 'package:identitic/providers/auth_provider.dart';
import 'package:identitic/pages/classes/classes_page.dart';

final selected = ClassPageType.tasks;

class TasksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    switch (Provider.of<AuthProvider>(context, listen: false).user.hierarchy) {
      case UserHierarchy.student:
        return StudentTasksPage();
      case UserHierarchy.teacher:
        return ClassesPage(selected);
      default:
        return ClassesPage(selected);
    }
  }
}
