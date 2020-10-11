import 'dart:io';

import 'package:flutter/cupertino.dart';

class Delivery {
  final int idUser;
  final int idArticle;
  final int idDelivery;
  final List deliveries;
  final String body;
  final File file;
  final String date;

  final String userName;
  final String userLastName;

  //RETURN BY TEACHER

  final String returnBody;
  final String returnMark;
  final int finished;
  final File returnedFile;

  const Delivery(
      {@required this.idUser,
      @required this.idArticle,
      this.userName,
      this.userLastName,
      this.body,
      this.file,
      this.date,
      this.idDelivery,
      this.returnBody,
      this.returnMark,
      this.returnedFile,
      this.finished,
      this.deliveries});

  factory Delivery.fromJson(Map<String, dynamic> json) {
    return Delivery(
        idUser: json['id_user'],
        idArticle: json['id_post'],
        body: json['body'],
        date: json['date'],
        file: json['filee'],
        deliveries: json['deliveries'],
        userName: json['first_name'],
        userLastName: json['last_name'],
        returnMark: json['last_mark'],
        returnBody: json['deliveries']);
  }
}
