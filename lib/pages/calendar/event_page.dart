import 'package:flutter/material.dart';
import 'package:identitic/models/event.dart';

class EventPage extends StatelessWidget {
  const EventPage(this.event);

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            title: Text(event.subject),
            centerTitle: true,
          ),
          SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  Text(
                    '${event.title}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '${event.description}',
                  )
                ]),
              )),
        ],
      ),
    );
  }
}
