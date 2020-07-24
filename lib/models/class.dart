import 'package:flutter/foundation.dart';

class Class {
  const Class(
      {this.id,
      @required this.label,
      @required this.year,
      @required this.course,
      this.idSubject});

  final int id;
  final String label;
  final String course;
  final int year;
  final int idSubject;

  factory Class.fromJson(Map<String, dynamic> json) {
    return Class(
        id: json['id_class'],
        label: json['ds_subject'],
        idSubject: json['id_subject'],
        course: json['division'],
        year: json['year']);
  }
}
