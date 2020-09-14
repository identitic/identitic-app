import 'package:flutter/material.dart';
import 'package:identitic/models/notification.dart';
import 'package:identitic/pages/notifications/widgets/notification_list_tile.dart';

import 'package:identitic/pages/notifications/widgets/notifications_list_view.dart';
import 'package:identitic/providers/notifications_provider.dart';
import 'package:provider/provider.dart';

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => null,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              pinned: true,
              title: Text('Notificaciones', style: TextStyle(fontSize: 24)),
            ),
            SliverFillRemaining(
              hasScrollBody: true,
              child: Consumer<NotificationsProvider>(builder:
                  (_, NotificationsProvider notificationsProvider, __) {
                final List<PushNotification> _notifications =
                    notificationsProvider.notifications;
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
              }),
            ),
          ],
        ),
      ),
    );
  }
}
