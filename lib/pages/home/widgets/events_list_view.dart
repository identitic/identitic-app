import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:identitic/providers/events_provider.dart';
import 'package:identitic/pages/home/widgets/event_list_tile.dart';

class EventsListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTile(
        title: Text(
          'Próximos eventos',
          style: TextStyle(
            color: Theme.of(context).textTheme.caption.color,
          ),
        ),
      ),
      Consumer<EventsProvider>(
        builder: (_, EventsProvider eventsProvider, __) {
          if (eventsProvider.events != null) {
            if (eventsProvider.events.isEmpty) {
              return Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  'No hay nuevos eventos, a relajar!',
                  style: TextStyle(fontSize: 16),
                ),
              );
            }
            return ListView.builder(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: eventsProvider.events?.length ?? 0,
              itemBuilder: (_, int i) {
                return EventListTile(eventsProvider.events[i]);
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      )
    ]);
  }
}
