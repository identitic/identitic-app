import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:identitic/src/ui/pages/add_event/add_event_page.dart';
import 'package:identitic/src/ui/pages/article/article_page.dart';
import 'package:identitic/src/ui/pages/article/widgets/article_create.dart';
import 'package:identitic/src/ui/pages/calendar/calendar_page.dart';
import 'package:identitic/src/ui/pages/calendar/widgets/calendar_class_page.dart';
import 'package:identitic/src/ui/pages/classes/classes_page.dart';
import 'package:identitic/src/ui/pages/grades/grades_page.dart';
import 'package:identitic/src/ui/pages/grades/widgets/teacher_grades_page.dart';
import 'package:identitic/src/ui/pages/home/home_page.dart';
import 'package:identitic/src/ui/pages/inattendances/inattendances_page.dart';
import 'package:identitic/src/ui/pages/inattendances_teacher/teacher_inattendances_page.dart';
import 'package:identitic/src/ui/pages/main/main_page.dart';
import 'package:identitic/src/ui/pages/messages/messages_page.dart';
import 'package:identitic/src/ui/pages/messages/widgets/room_page.dart';
import 'package:identitic/src/ui/pages/not_found/developing.dart';
import 'package:identitic/src/ui/pages/not_found/not_found_page.dart';
import 'package:identitic/src/ui/pages/sign_in/sign_in_page.dart';
import 'package:identitic/src/ui/pages/sign_up/sign_up_page.dart';
import 'package:identitic/src/ui/pages/splash/splash_page.dart';
import 'package:identitic/src/ui/pages/families/families_page.dart';
import 'package:identitic/src/ui/pages/tasks/tasks_page.dart';
import 'package:identitic/src/ui/pages/tasks/widgets/teacher_tasks_page.dart';
import 'package:identitic/src/utils/constants.dart';


const String initialRoute = RouteName.initial_route;

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  return CupertinoPageRoute<Widget>(
    settings: settings,
    builder: (_) {
      switch (settings.name) {
        case RouteName.initial_route:
          return SplashPage();
        case RouteName.add_event:
          return AddEventPage(settings.arguments);
        case RouteName.article:
          return ArticlePage(settings.arguments);
        case RouteName.calendar:
          return CalendarPage();
        case RouteName.class_calendar:
          return CalendarClassPage(settings.arguments);
        case RouteName.classes:
          return ClassesPage(settings.arguments);
        case RouteName.grades:
          return GradesPage();
        case RouteName.home:
          return HomePage();
        case RouteName.inattendances:
          return InattendancesPage();
        case RouteName.inattendances_teacher:
          return InattendancesTeacherPage(settings.arguments);
        case RouteName.main:
          return MainPage();
        case RouteName.developing:
          return DevelopingPage();
        case RouteName.sign_in:
          return SignInPage();
        case RouteName.sign_up:
          return SignUpPage();
        case RouteName.grades_teacher:
          return TeacherGradesPage(settings.arguments);
        case RouteName.families:
          return FamiliesPage();
        case RouteName.class_calendar:
          return CalendarClassPage(settings.arguments);
        case RouteName.article_create:
          return ArticleCreatePage(settings.arguments);
        case RouteName.tasks:
          return TasksPage();
        case RouteName.tasks_teacher:
          return TeacherTasksPage(settings.arguments);
        case RouteName.messages:
          return MessagesPage();
        case RouteName.room:
          return RoomPage(settings.arguments); 
        default:
          return NotFoundPage();
      }
    },
  );
}
