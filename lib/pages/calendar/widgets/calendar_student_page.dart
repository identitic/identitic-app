import 'package:flutter/material.dart';
import 'package:identitic/models/event.dart';
import 'package:identitic/providers/auth_provider.dart';
import 'package:identitic/providers/events_provider.dart';
import 'package:identitic/pages/home/widgets/event_list_tile.dart';
import 'package:provider/provider.dart';

import 'package:table_calendar/table_calendar.dart';

class CalendarStudentPage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<CalendarStudentPage> {
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  DateTime _date;
  @override
  void initState() {
    super.initState();
    _controller = CalendarController();

    /* traigo los eventos en una list<event>

    for(recorra list<event>){
      event[i].date: event[i]
    } */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
      physics: const BouncingScrollPhysics(),
      headerSliverBuilder: (_, __) => [
        SliverAppBar(pinned: true, title: Text('Calendario')),
      ],
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          TableCalendar(
            initialCalendarFormat: CalendarFormat.month,
            availableCalendarFormats: const {CalendarFormat.month: "Mensual"},
            initialSelectedDay: DateTime.now(),
            calendarStyle: CalendarStyle(
                todayColor: Colors.pink,
                selectedColor: Theme.of(context).primaryColor,
                todayStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.white)),
            headerStyle: HeaderStyle(
              centerHeaderTitle: true,
              formatButtonDecoration: BoxDecoration(
                color: Colors.pink,
                borderRadius: BorderRadius.circular(20.0),
              ),
              formatButtonTextStyle: TextStyle(color: Colors.white),
              formatButtonShowsNext: false,
            ),
            startingDayOfWeek: StartingDayOfWeek.monday,
            onDaySelected: (date, events) {
              setState(() {
                _date = date;
              });
            },
            builders: CalendarBuilders(
              selectedDayBuilder: (context, date, events) => Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(100.0)),
                  child: Text(
                    date.day.toString(),
                    style: TextStyle(color: Colors.white),
                  )),
              todayDayBuilder: (context, date, events) => Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.pink,
                      borderRadius: BorderRadius.circular(100.0)),
                  child: Text(
                    date.day.toString(),
                    style: TextStyle(color: Colors.white),
                  )),
            ),
            calendarController: _controller,
          ),
          FutureBuilder(
              future: Provider.of<EventsProvider>(context, listen: false)
                  .fetchDayEvents(
                      Provider.of<AuthProvider>(context, listen: false)
                          .user
                          .idClass,
                      _date),
              builder: (_, AsyncSnapshot snapshot) {
                final List<Event> _events = snapshot.data;
                if (snapshot.hasData) {
                  if (_events.length != 0) {
                    return ListView.separated(
                      physics: ClampingScrollPhysics(),
                      padding: EdgeInsets.all(16),
                      shrinkWrap: true,
                      itemCount: _events.isNotEmpty ? _events.length : 0,
                      separatorBuilder: (_, int i) => SizedBox(height: 8),
                      itemBuilder: (_, int i) {
                        if (i == 0) {
                          return Column(children: [
                            ListTile(
                              title: Text(
                                'Eventos',
                                style: TextStyle(
                                  color:
                                      Theme.of(context).textTheme.caption.color,
                                ),
                              ),
                            ),
                            EventListTile(_events[i])
                          ]);
                        }
                        return EventListTile(_events[i]);
                      },
                    );
                  }
                  return Column(children: [
                    ListTile(
                      contentPadding: EdgeInsets.all(16),
                      title: Text(
                        'Eventos',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.caption.color,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        'No tienes eventos en esta fecha!',
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  ]);
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ],
      ),
    ));
  }
}

/* _filterEvents(BuildContext context, DateTime _actualDate) async {
  List<Event> _events =
      await Provider.of<EventsProvider>(context, listen: false).fetchAllEvents(
          Provider.of<AuthProvider>(context, listen: false).user.idClass);
  List<Event> _results;

  _results = _events
      .where((event) =>
          DateTime.parse(event.date).difference(_actualDate).inDays == 0)
      .toList();

  print(_results);
  return _results;
} */

/* FutureBuilder(
              future: Provider.of<EventsProvider>(context, listen: false)
                  .fetchAllEvents(
                      Provider.of<AuthProvider>(context, listen: false)
                          .user
                          .idClass),
              builder: (_, AsyncSnapshot snapshot) {
                final List<Event> _events = snapshot.data;
                if (snapshot.hasData) {
                  return ListView.separated(
                    physics: ClampingScrollPhysics(),
                    padding: EdgeInsets.all(16),
                    shrinkWrap: true,
                    itemCount: _events.isNotEmpty ? _events.length : 0,
                    separatorBuilder: (_, int i) => SizedBox(height: 8),
                    itemBuilder: (_, int i) {
                      if (i == 0) {
                        return Column(children: [
                          ListTile(
                            title: Text(
                              'Eventos',
                              style: TextStyle(
                                color:
                                    Theme.of(context).textTheme.caption.color,
                              ),
                            ),
                          ),
                          EventListTile(_events[i])
                        ]);
                      }
                      return EventListTile(_events[i]);
                    },
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }), */

/* class ShowEvents extends StatelessWidget {
  const ShowEvents(this._date);
  final DateTime _date;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Event>>(
      future:
          Provider.of<EventsProvider>(context, listen: false).fetchAllEvents(5
              //Provider.of<AuthProvider>(context, listen: false).user.idClass
              ),
      builder: (_, AsyncSnapshot<List<Event>> snapshot) {
        final List<Event> events = snapshot.data;
        if (snapshot.hasData) {
          return ListView.separated(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (_, int i) {
              return SizedBox(height: 8);
            },
            itemCount: events.length ?? 4,
            itemBuilder: (_, int i) {
              return EventListTile(events[i]);
            },
          );
        }
        return Center(
          child: Text("No hay eventos en este día."),
        );
      },
    );
  }
}
 */
