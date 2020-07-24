import 'package:flutter/material.dart';

import 'package:outline_material_icons/outline_material_icons.dart';

import 'package:identitic/pages/notifications/widgets/notifications_list_view.dart';
import 'package:identitic/utils/constants.dart';

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
              hasScrollBody: false,
              child: Column(
                children: [
                  for (int i = 0; i < 10; i++) ListTile(title: Text('$i')),
                ],
              ),
            ),
            // SliverFillRemaining(
            //   hasScrollBody: false,
            //   child: NotificationsListView(),
            // ),
          ],
        ),
      ),
    );
  }
}
