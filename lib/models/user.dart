import 'dart:io';

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
    this.profilePhoto,
    this.idSchool,
    this.schoolName,
    this.idClass,
    this.classs
  });

  final int id;
  final String name;
  final String lastName;
  final String profilePhoto;
  final UserHierarchy hierarchy;
  final int idSchool;
  final String schoolName;
  final int idClass;
  final Class classs;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['sub'],
      hierarchy: json['hierarchy'] == 'teacher'
          ? UserHierarchy.teacher
          : UserHierarchy.student,
      name: json['name'],
      lastName: json['lastName'],
      profilePhoto: json['profile_photo'],
      idSchool: json['school'],
      schoolName: json['shoolName'],
      idClass: json['class']
    );
  }
}
