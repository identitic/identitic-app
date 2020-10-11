import 'dart:io';

import 'package:flutter/foundation.dart';

const String apiBaseUrl = 'https://servidor.identiticapp.com';
const String fake_token =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImhpZXJhcmNoeSI6ImFkbSIsImNsYXNzIjpudWxsLCJjbGFzc05hbWUiOjAsInNjaG9vbCI6MSwic2hvb2xOYW1lIjoiVUJBIiwibmFtZSI6Ikp1YW4iLCJsYXN0TmFtZSI6IlBlcmV6IiwiaWF0IjoxNTkzNjU0MDc2LCJleHAiOjE1OTQ5NTAwNzZ9.mn0k0FmYmCZ8dphTG5tAhcUOfHKL4A2Bkkn8cwHM5zc';

bool get isWeb => kIsWeb;
bool get isMobile => !isWeb && (Platform.isIOS || Platform.isAndroid);
bool get isDesktop =>
    !isWeb && (Platform.isMacOS || Platform.isWindows || Platform.isLinux);
bool get isApple => !isWeb && (Platform.isIOS || Platform.isMacOS);
bool get isGoogle => !isWeb && (Platform.isAndroid || Platform.isFuchsia);

class RouteName {
  static const String initial_route = '/';
  static const String onboarding = '/onboarding';
  static const String add_event = '/add_event';
  static const String class_calendar = '/class_calendar';
  static const String calendar = '/calendar';
  static const String calendar_teacher = '/calendar_teacher';
  static const String classes = '/classes';
  static const String grades = '/grades';
  static const String home = '/home';
  static const String inattendances = '/inattendances';
  static const String inattendances_teacher = '/inattendances_teacher';
  static const String main = '/main';
  static const String developing = '/developing';
  static const String messages = '/messages';
  static const String room = '/room';
  static const String sign_in = '/sign_in';
  static const String sign_up = '/sign_up';
  static const String grades_teacher = '/teacher_grades';
  static const String families = '/families';
  static const String article = '/article';
  static const String article_create = '/article_create';
  static const String tasks = '/tasks';
  static const String tasks_teacher = '/tasks_teacher';
  static const String article_markdown = '/article_markdown';
  static const String new_delivery = '/new_delivery';
  static const String article_deliveries = '/article_deliveries';
  static const String view_delivery = '/view_delivery';
}

class StorageKey {
  static const String token = 'token';
}
