import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:identitic/models/class.dart';
import 'package:identitic/models/event.dart';
import 'package:identitic/providers/events_provider.dart';
import 'package:identitic/pages/home/widgets/event_list_tile.dart';
import 'package:identitic/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarClassPage extends StatefulWidget {
  const CalendarClassPage(this.classs);
  final Class classs;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<CalendarClassPage> {
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
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
      appBar: AppBar(
        title: Text('Calendario'),
        centerTitle: true,
      ),
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
              //return ShowEvents(date);
              debugPrint(date.toIso8601String());
            },
            builders: CalendarBuilders(
              selectedDayBuilder: (context, date, events) => Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
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
            child: Text(
              "Añadir evento",
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            onPressed: () => Navigator.pushNamed(context, RouteName.add_event,
                arguments: widget.classs),
            color: Colors.pink,
          ),
          SizedBox(height: 16),
          FutureBuilder(
              future: Provider.of<EventsProvider>(context, listen: false)
                  .fetchAllEvents(1),
              builder: (_, AsyncSnapshot snapshot) {
                final List<Event> _events = snapshot.data;
                if (snapshot.hasData) {
                  return ListView.separated(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _events?.length ?? 3,
                    separatorBuilder: (_, int i) => SizedBox(height: 8),
                    itemBuilder: (_, int i) {
                      if (i == 0) {
                        return Column(children: [
                          ListTile(
                            title: Text('Eventos'),
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
              }),
        ],
      ),
    );
  }
}
