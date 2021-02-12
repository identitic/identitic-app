import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:identitic/providers/events_provider.dart';
import 'package:identitic/pages/home/widgets/events_list_view.dart';
import 'package:identitic/pages/home/widgets/identitic_circle.dart';
import 'package:identitic/utils/constants.dart';

//TODO: Convertir NestedScrollView en CustomScrollView, y la ListView en una SliverList, creo.

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        physics: const BouncingScrollPhysics(),
        headerSliverBuilder: (_, __) => [
          SliverAppBar(
            pinned: true,
            centerTitle: false,
            title: Image.asset(
              'assets/images/identitic_pink.png',
              height: 24,
            ),
          ),
        ],
        body: Container(
          child: RefreshIndicator(
            onRefresh: () => Provider.of<EventsProvider>(context, listen: false)
                .fetchEvents(),
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
                            child: Image.asset('assets/images/marks.png',
                                height: 70),
                            text: "Calificaciones",
                          ),
                          SizedBox(width: 16),
                          IdentiticCircle(
                            onTap: () => Navigator.pushNamed(
                                context, RouteName.inattendances),
                            child: Image.asset(
                                'assets/images/inattendances.png',
                                height: 70),
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
                            child: Image.asset('assets/images/school2.png',
                                height: 70),
                            text: "Comunicados",
                          ),
                          SizedBox(width: 16),
                          IdentiticCircle(
                            onTap: () =>
                                Navigator.pushNamed(context, RouteName.tasks),
                            child: Image.asset('assets/images/open-book.png',
                                height: 70),
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
