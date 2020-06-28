import 'package:flutter/material.dart';

const Color pink = Colors.pink;

const List<BoxShadow> identiticShadow = [
  BoxShadow(
    blurRadius: 16,
    color: Colors.black12,
  ),
];

final ThemeData theme = ThemeData(
  fontFamily: 'Nunito',
  accentColor: Colors.pink,
  highlightColor: Colors.transparent,
  splashFactory: InkRipple.splashFactory,
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(
      color: Colors.pink,
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.pink,
    ),
    textTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.pink,
        fontWeight: FontWeight.bold,
      ),
    ),
    color: Colors.white,
    brightness: Brightness.light,
  ),
);
