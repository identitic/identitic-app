import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:identitic/models/user.dart';
import 'package:identitic/providers/auth_provider.dart';
import 'package:identitic/pages/classes/classes_page.dart';
import 'package:identitic/pages/calendar/widgets/calendar_student_page.dart';

final selected = ClassPageType.calendar;

class CalendarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    switch (Provider.of<AuthProvider>(context, listen: false).user.hierarchy) {
      case UserHierarchy.student:
        return CalendarStudentPage();
      case UserHierarchy.teacher:
        return ClassesPage(selected);
      default:
        return CalendarStudentPage();
    }
  }
}
