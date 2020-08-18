import 'package:flutter/material.dart';

import 'package:identitic/models/event.dart';

class EventListTile extends StatelessWidget {
  final Event event;

  const EventListTile([this.event]);

  @override
  Widget build(BuildContext context) {
      return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.pink,
        child: Text(event?.title[0] ?? '?', style: TextStyle(color: Theme.of(context).primaryColor)),
      ),
      title: Text(event?.title ?? 'No hay eventos disponibles',),
      subtitle: Text(event?.description ?? '...'),
      trailing: Text(
        '${event.date[8]}' + 
            '${event.date[9]}' +
            '/' +
            '${event.date[5]}' +
            '${event.date[6]}',
        style: TextStyle(color: Theme.of(context).textTheme.caption.color),
      ),
    );
  }
}