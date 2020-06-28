import 'package:flutter/material.dart';

import 'package:identitic/src/models/inattendance.dart';
import 'package:identitic/src/ui/widgets/identitic_container.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class InattendanceListTile extends StatelessWidget {
  const InattendanceListTile([this.inattendance]);

  final Inattendance inattendance;

  @override
  Widget build(BuildContext context) {
    return IdentiticContainer(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.pink,
          child: Icon(OMIcons.close)
        ),
        title: Text('${inattendance.date[8]}'+'${inattendance.date[9]}' + '/' + '${inattendance.date[5]}' + '${inattendance.date[6]}')
      ),
    );
  }
}
