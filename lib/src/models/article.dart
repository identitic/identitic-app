import 'package:flutter/material.dart';

class Article {
  final int idUser;
  final String title;
  final String body;
  final ImageProvider image;
  final String date;
  final String deadline;
  final String hierarchy;
  final int idHierarchy;
  final int idClass;
  final int year;
  final String division;
  final int idSubject;
  final String subject;
  final String name;
  final String lastName;
  
  const Article({
    this.idUser,
    this.name,
    this.lastName,
    this.title,
    this.body,
    this.idClass,
    this.image,
    this.date,
    this.deadline,
    this.hierarchy,
    this.year,
    this.division,
    this.idSubject,
    this.subject,
    this.idHierarchy
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'],
      body: json['body'],
      date: json['date'],
      idClass: json['id_class'],
      year: json['year'],
      division: json['division'],
      idSubject: json['id_subject'],
      subject: json['ds_subject'],
      idUser: json['id_user'],
      name: json['first_name'],
      lastName: json['last_name'],
      deadline: json['deadline'],
      hierarchy: json['hierarchy']
    );
  }
}
