import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:identitic/pages/add_event/add_event_page.dart';
import 'package:identitic/pages/article/article_all_deliveries.dart';
import 'package:identitic/pages/article/article_correct_delivery.dart';
import 'package:identitic/pages/article/article_markdown.dart';
import 'package:identitic/pages/article/article_new_delivery.dart';
import 'package:identitic/pages/article/article_page.dart';
import 'package:identitic/pages/article/article_create.dart';
import 'package:identitic/pages/article/article_student_view_delivery.dart';
import 'package:identitic/pages/article/article_teacher_view_delivery.dart';
import 'package:identitic/pages/calendar/calendar_page.dart';
import 'package:identitic/pages/calendar/event_page.dart';
import 'package:identitic/pages/calendar/widgets/calendar_class_page.dart';
import 'package:identitic/pages/classes/classes_page.dart';
import 'package:identitic/pages/grades/grade_info.dart';
import 'package:identitic/pages/grades/grades_page.dart';
import 'package:identitic/pages/grades/widgets/teacher_grades_page.dart';
import 'package:identitic/pages/home/home_page.dart';
import 'package:identitic/pages/inattendances/inattendances_page.dart';
import 'package:identitic/pages/inattendances_teacher/teacher_inattendances_page.dart';
import 'package:identitic/pages/main/main_page.dart';
import 'package:identitic/pages/not_found/developing.dart';
import 'package:identitic/pages/not_found/not_found_page.dart';
import 'package:identitic/pages/onboarding/onboarding_page.dart';
import 'package:identitic/pages/profile/user_settings/user_settings_page.dart';
import 'package:identitic/pages/sign_in/sign_in_page.dart';
import 'package:identitic/pages/sign_up/sign_up_page.dart';
import 'package:identitic/pages/splash/splash_page.dart';
import 'package:identitic/pages/communications/communications_page.dart';
import 'package:identitic/pages/tasks/tasks_page.dart';
import 'package:identitic/pages/tasks/widgets/student_tasks_page.dart';
import 'package:identitic/pages/tasks/widgets/teacher_tasks_page.dart';
import 'package:identitic/utils/constants.dart';

const String initialRoute = RouteName.initial_route;

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  // TEST A MATERIALPAGEROUTE FOR DISABLE BACK GESTURE ON ANDROID
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
          return CalendarClassPage();
        case RouteName.event_page:
          return EventPage(settings.arguments);
        case RouteName.classes:
          return ClassesPage(settings.arguments);
        case RouteName.grades:
          return GradesPage();
        case RouteName.grade_info:
          return GradeInfo(settings.arguments);
        case RouteName.home:
          return HomePage();
        case RouteName.inattendances:
          return InattendancesPage();
        case RouteName.inattendances_teacher:
          return InattendancesTeacherPage(settings.arguments);
        case RouteName.main:
          return MainPage();
        case RouteName.onboarding:
          return OnboardingPage();
        case RouteName.developing:
          return DevelopingPage();
        case RouteName.sign_in:
          return SignInPage();
        case RouteName.sign_up:
          return SignUpPage();
        case RouteName.user_settings:
          return UserSettingsPage(settings.arguments);
        case RouteName.grades_teacher:
          return TeacherGradesPage(settings.arguments);
        case RouteName.families:
          return CommunicationsPage();
        case RouteName.article_create:
          return ArticleCreatePage(settings.arguments);
        case RouteName.tasks:
          return TasksPage();
        case RouteName.tasks_student:
          return StudentTasksPage(settings.arguments);
        case RouteName.tasks_teacher:
          return TeacherTasksPage(settings.arguments);
        case RouteName.article_markdown:
          return EditorPage(settings.arguments);
        case RouteName.new_delivery:
          return NewDeliveryPage(settings.arguments);
        case RouteName.article_deliveries:
          return ArticleAllDeliveries(settings.arguments);
        case RouteName.teacher_view_delivery:
          return TeacherViewDeliveryPage(settings.arguments);
        case RouteName.student_view_delivery:
          return StudentViewDeliveryPage(settings.arguments);
        case RouteName.correct_delivery:
          return CorrectDeliveryPage(settings.arguments);
        default:
          return NotFoundPage();
      }
    },
  );
}
