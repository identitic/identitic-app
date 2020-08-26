import 'package:flutter/material.dart';

import 'package:identitic/pages/notifications/widgets/notifications_list_view.dart';

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
              title: Text('Notificaciones'),
            ),
            SliverFillRemaining(
              hasScrollBody: true,
              child: NotificationsListView(),
            ),
          ],
        ),
      ),
    );
  }
}
