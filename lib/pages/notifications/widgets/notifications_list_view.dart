import 'package:flutter/material.dart';

import 'package:identitic/pages/notifications/widgets/notification_list_tile.dart';

class NotificationsListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(16),
        itemCount: 5,
        separatorBuilder: (_, int i) {
          return SizedBox(height: 8);
        },
        itemBuilder: (_, int i) {
          return NotificationListTile(i);
        });
  }
}
