import 'package:flutter/material.dart';
import 'package:identitic/models/notification.dart';

import 'package:identitic/pages/notifications/widgets/notification_list_tile.dart';
import 'package:identitic/providers/push_notifications_provider.dart';
import 'package:provider/provider.dart';

class NotificationsListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<PushNotificationsProvider>(context, listen: false)
          .fetchNotifications(),
      builder: (_, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          final List<PushNotification>_notifications = snapshot.data;
          return ListView.separated(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(0),
              itemCount: _notifications.length,
              separatorBuilder: (_, int i) {
                return SizedBox(height: 8);
              },
              itemBuilder: (_, int i) {
                return NotificationListTile(_notifications[i], 1);
              });
        }
        return ListView.separated(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(0),
            itemCount: 5,
            separatorBuilder: (_, int i) {
              return SizedBox(height: 8);
            },
            itemBuilder: (_, int i) {
              return NotificationListTile(i, 1);
            });
      },
    );
  }
}
