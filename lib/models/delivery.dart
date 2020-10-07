import 'dart:io';

import 'package:flutter/cupertino.dart';

class Delivery {
  final int idUser;
  final int idArticle;
  final int idDelivery;
  final String body;
  final File file;
  final String date;

  const Delivery(
      {@required this.idUser,
      @required this.idArticle,
      this.body,
      this.file,
      this.date,
      this.idDelivery});

  factory Delivery.fromJson(Map<String, dynamic> json) {
    return Delivery(
        idUser: json['id_user'],
        idArticle: json['id_post'],
        body: json['body'],
        date: json['date'],
        file: json['filee'],
        idDelivery: json['id_delivery']);
  }
}
