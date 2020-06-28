import 'package:flutter/material.dart';
import 'package:identitic/src/ui/pages/tasks/widgets/student_tasks_page.dart';

import 'package:provider/provider.dart';

import 'package:identitic/src/models/user.dart';
import 'package:identitic/src/providers/auth_provider.dart';
import 'package:identitic/src/ui/pages/classes/classes_page.dart';


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
