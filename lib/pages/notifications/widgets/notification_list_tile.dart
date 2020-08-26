import 'package:flutter/material.dart';

import 'package:outline_material_icons/outline_material_icons.dart';

class NotificationListTile extends StatelessWidget {
  const NotificationListTile([this.notification, this.type]);

  final dynamic notification;
  final int type;
  @override
  Widget build(BuildContext context) {   
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue,
        child: type == 0 ? Icon(Icons.calendar_today, color: Colors.white ) : Icon(OMIcons.classIcon, color: Colors.white, ),
      ),
      title: Text('Matemática',),
      subtitle: type == 0 ? Text('Tenés un nuevo evento') : Text('Tenés nuevas notas'),
      ); 
  }
}
