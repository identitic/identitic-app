import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:identitic/models/event.dart';
import 'package:identitic/providers/events_provider.dart';
import 'package:identitic/pages/home/widgets/event_list_tile.dart';
import 'package:identitic/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarClassPage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<CalendarClassPage> {
  CalendarController _controller;
  int _course;
  DateTime _date = DateTime.now().toUtc();
  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
      physics: const BouncingScrollPhysics(),
      headerSliverBuilder: (_, __) => [
        SliverAppBar(
          pinned: true,
          title: Text('Calendario'),
        ),
      ],
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16),
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
                      color: Colors.blue,
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
          SizedBox(height: 16),
          FlatButton(
            color: Colors.blue,
            child: Text(
              "Añadir evento",
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            onPressed: () => Navigator.pushNamed(context, RouteName.add_event,
                arguments: _course),
          ),
          SizedBox(height: 16),
          FutureBuilder(
              future: Provider.of<EventsProvider>(context, listen: false)
                  .fetchDayEventsTeacher(_date),
              builder: (_, AsyncSnapshot snapshot) {
                final List<Event> _events = snapshot.data;
                if (snapshot.hasData) {
                  if (_events.length != 0) {
                    return ListView.separated(
                      physics: ClampingScrollPhysics(),
                      padding: EdgeInsets.all(8),
                      shrinkWrap: true,
                      itemCount: _events.isNotEmpty ? _events.length : 0,
                      separatorBuilder: (_, int i) => SizedBox(height: 8),
                      itemBuilder: (_, int i) {
                        return EventListTile(_events[i]);
                      },
                    );
                  }
                  return Column(children: [
                    SizedBox(height: 16),
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
