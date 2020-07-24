import 'package:flutter/foundation.dart';

enum AttendanceType {
  present,
  late,
  absent,
}

class Student {
  Student({
    @required this.idStudent,
    @required this.name,
    @required this.lastName,
    this.image,
    this.attendanceType = AttendanceType.present,
  });

  final int idStudent;
  final String name;
  final String lastName;
  final String image;
  AttendanceType attendanceType;

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      idStudent: json['id_user'],
      name: json['first_name'],
      lastName: json['last_name'],
      image: json['image'],
    );
  }
}
