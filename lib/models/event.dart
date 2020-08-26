import 'package:flutter/foundation.dart';

class Event {
  const Event({
    this.id,
    this.idClass,
    this.idSubject,
    this.idCategory,
    this.subject,
    this.category,
    this.idUser,
    @required this.idJoin,
    @required this.title,
    @required this.description,
    @required this.date,
  });

  final int id;
  final int idClass;
  final int idUser;
  final int idSubject;
  final String title;
  final String description;
  final String subject;
  final String date;
  final String category;
  final int idCategory;
  final int idJoin;

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
        title: json['title'],
        description: json['ds_event'],
        subject: json['ds_subject'],
        idSubject: json['id_subject'],
        category: json['ds_category'],
        idCategory: json['id_category'],
        date: json['date'],
        idUser: json['id_user'],
        idJoin: json['id_join']);
  }
}
