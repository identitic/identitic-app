import 'package:flutter/foundation.dart';

import 'class.dart';

enum UserHierarchy {
  student,
  teacher,
}

class User {
  const User({
    @required this.id,
    @required this.hierarchy,
    this.name,
    this.lastName,
    this.idSchool,
    this.schoolName,
    this.idClass,
    this.classs
  });

  final int id;
  final String name;
  final String lastName;
  final UserHierarchy hierarchy;
  final int idSchool;
  final String schoolName;
  final int idClass;
  final Class classs;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['username'],
      hierarchy: json['hierarchy'] == 2
          ? UserHierarchy.teacher
          : UserHierarchy.student,
      name: json['name'],
      lastName: json['lastName'],
      idSchool: json['id_sc'],
      schoolName: json['shoolName']
    );
  }
}
