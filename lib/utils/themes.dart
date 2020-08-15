import 'package:flutter/material.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    splashFactory: InkRipple.splashFactory,
    highlightColor: Colors.transparent,
    primaryColor: Colors.white,
    primaryColorBrightness: Brightness.light,
    accentColor: Colors.pink,
    accentColorBrightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
      subtitle1: TextStyle(
        fontWeight: FontWeight.w500,
      ),
    ),
    appBarTheme: AppBarTheme(
      textTheme: TextTheme(
        headline6: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      unselectedItemColor: Colors.grey[200],
      selectedItemColor: Colors.black,
    ),
  );
}
