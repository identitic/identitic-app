import 'package:flutter/material.dart';

import 'package:identitic/src/ui/widgets/identitic_container.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class NotificationListTile extends StatelessWidget {
  const NotificationListTile([this.notification]);

  final dynamic notification;
  @override
  Widget build(BuildContext context) {
    return IdentiticContainer(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.pink,
          child: Icon(OMIcons.notifications),
        ),
        title: Text('Notificación'),
        subtitle: Text('Subtítulo'),
        trailing: Icon(Icons.chevron_right),
      ),
    );
  }
}
