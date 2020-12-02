import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:identitic/providers/events_provider.dart';
import 'package:identitic/pages/home/widgets/event_list_tile.dart';

class EventsListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Próximos eventos',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).textTheme.caption.color,
            ),
            textAlign: TextAlign.left,
          )),
      Consumer<EventsProvider>(
        builder: (_, EventsProvider eventsProvider, __) {
          if (eventsProvider.events != null) {
            if (eventsProvider.events.length != 0) {
              return ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: eventsProvider.events?.length ?? 0,
                itemBuilder: (_, int i) {
                  return EventListTile(eventsProvider.events[i]);
                },
              );
            } else {
              return Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  'No hay nuevos eventos, a relajar!',
                  style: TextStyle(fontSize: 16),
                ),
              );
            }
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      )
    ]);
  }
}
