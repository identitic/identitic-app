import 'package:flutter/material.dart';

import 'package:outline_material_icons/outline_material_icons.dart';

import 'package:identitic/src/ui/pages/notifications/widgets/notifications_list_view.dart';
import 'package:identitic/src/utils/constants.dart';

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Notificaciones', style: TextStyle(fontSize: 16),),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () => Navigator.pushNamed(context, RouteName.messages),
            icon: Icon(OMIcons.chatBubbleOutline),
            tooltip: 'Mensajes',
          ),
        ],
      ),
      body: NotificationsListView(),
    );
  }
}
