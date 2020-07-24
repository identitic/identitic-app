import 'package:flutter/material.dart';
import 'package:identitic/providers/events_provider.dart';

import 'package:outline_material_icons/outline_material_icons.dart';

import 'package:identitic/pages/home/widgets/events_list_view.dart';
import 'package:identitic/pages/home/widgets/identitic_circle.dart';
import 'package:identitic/utils/constants.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        physics: const BouncingScrollPhysics(),
        headerSliverBuilder: (_, __) => [
          SliverAppBar(
            pinned: true,
            title: Image.asset(
              'assets/images/identitic_pink.png',
              height: 24,
            ),
          ),
        ],
        body: Container(
          child: RefreshIndicator(
            onRefresh: () => Provider.of<EventsProvider>(context, listen: false)
                .fetchAllEvents(1),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          IdentiticCircle(
                            onTap: () =>
                                Navigator.pushNamed(context, RouteName.grades),
                            child: Icon(OMIcons.classIcon, size: 44),
                            text: "Calificaciones",
                          ),
                          SizedBox(width: 16),
                          IdentiticCircle(
                            onTap: () => Navigator.pushNamed(
                                context, RouteName.inattendances),
                            child: Icon(OMIcons.check, size: 44),
                            text: "Inasistencias",
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          IdentiticCircle(
                            onTap: () => Navigator.pushNamed(
                                context, RouteName.families),
                            child: Icon(OMIcons.peopleOutline, size: 44),
                            text: "Familias",
                          ),
                          SizedBox(width: 16),
                          IdentiticCircle(
                            onTap: () =>
                                Navigator.pushNamed(context, RouteName.tasks),
                            child: Icon(OMIcons.assignment, size: 46),
                            text: "Tareas",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                EventsListView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
