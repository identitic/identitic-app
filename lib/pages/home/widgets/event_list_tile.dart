import 'package:flutter/material.dart';

import 'package:identitic/models/event.dart';

class EventListTile extends StatelessWidget {
  final Event event;

  const EventListTile([this.event]);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
          radius: 24,
          backgroundColor: Colors.pink,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 8),
              Text(
                '${event.date[8]}' + '${event.date[9]}',
                style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600),
              ),
              Text(
                'DIC',
                style: TextStyle(fontSize: 10, color: Colors.white),
              ),
            ],
          )),
      title: Text(
        event?.title ?? 'No hay eventos disponibles',
      ),
      subtitle: Text(event?.description ?? '...'),
    );
  }
}
