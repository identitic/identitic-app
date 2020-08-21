import 'package:flutter/foundation.dart';

class Class {
  const Class(
      {@required this.id, this.label, this.year, this.course, this.idSubject, this.idJoin});

  final int id;
  final String label;
  final String course;
  final int year;
  final int idSubject;
  final int idJoin;

  factory Class.fromJson(Map<String, dynamic> json) {
    return Class(
        id: json['id_class'],
        label: json['ds_subject'],
        idSubject: json['id_subject'],
        course: json['division'],
        year: json['year'],
        idJoin: json['id_join']
        );
  }
}
