
import 'package:flutter/material.dart';

import 'package:identitic/src/models/event.dart';
import 'package:identitic/src/ui/widgets/identitic_container.dart';

class EventListTile extends StatelessWidget {
  const EventListTile([this.event]);

  final  Event event;

  @override
  Widget build(BuildContext context) {
    return IdentiticContainer(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.pink,
          radius: 26,
          child: Text('${event.date[8]}'+'${event.date[9]}' + '/' + '${event.date[5]}' + '${event.date[6]}',
                  style: TextStyle(fontSize: 14, color: Colors.white)
          ),
        ),
        title: Text(event?.title ?? '...'),
        subtitle: Text(event?.description ?? '...'),
        trailing: Icon(Icons.chevron_right),
      ),
    );
  }
}