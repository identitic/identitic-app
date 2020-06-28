import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:identitic/src/providers/events_provider.dart';
import 'package:identitic/src/ui/pages/home/widgets/event_list_tile.dart';

class EventsListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<EventsProvider>(
      builder: (_, EventsProvider eventsProvider, __) {
        if (eventsProvider.events != null) {
          return ListView.separated(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: /* eventsProvider.events?.length ?? */ 4,
            separatorBuilder: (_, int i) => SizedBox(height: 8),
            itemBuilder: (_, int i) {
              return EventListTile(eventsProvider.events[i]);
            },
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  } 
}
