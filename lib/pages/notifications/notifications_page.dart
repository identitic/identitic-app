import 'package:flutter/material.dart';
import 'package:identitic/providers/notifications_provider.dart';
import 'package:provider/provider.dart';

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () =>
            Provider.of<NotificationsProvider>(context, listen: false)
                .fetchNotifications(),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              pinned: true,
              centerTitle: false,
              title: Text('Notificaciones', style: TextStyle(fontSize: 28)),
            ),
            SliverFillRemaining(
              hasScrollBody: true,
              //TODO: Notificaciones
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/empty_notifications.png',
                    ),
                    Text(
                      'Todavía no recibiste notificaciones',
                      style: TextStyle(fontSize: 18),
                    )
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
