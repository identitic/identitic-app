import 'package:flutter/material.dart';

import 'package:identitic/models/inattendance.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class InattendanceListTile extends StatelessWidget {
  const InattendanceListTile([this.inattendance]);

  final Inattendance inattendance;

  @override
  Widget build(BuildContext context) {
    if (inattendance != null) {
      return ListTile(
          leading: CircleAvatar(
              backgroundColor: Colors.pink,
              child: Icon(OMIcons.close, color: Colors.white)),
          title: Text('${inattendance.date[8]}' +
              '${inattendance.date[9]}' +
              '/' +
              '${inattendance.date[5]}' +
              '${inattendance.date[6]}'));
    }
    return Center(
      child: Text(
        'No tienes nuevas inasistencias!',
      ),
    );
  }
}
