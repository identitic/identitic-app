import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:identitic/models/event.dart';
import 'package:identitic/providers/auth_provider.dart';
import 'package:identitic/providers/events_provider.dart';
import 'package:identitic/pages/home/widgets/event_list_tile.dart';

class CalendarStudentPage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<CalendarStudentPage> {
  CalendarController _controller;
  DateTime _date = DateTime.now().toUtc();
  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    initializeDateFormatting('es_ARG', null);
    Intl.defaultLocale = 'es_ARG';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
            physics: const BouncingScrollPhysics(),
            headerSliverBuilder: (_, __) => [
                  SliverAppBar(
                    pinned: true,
                    title: Text('Calendario', style: TextStyle(fontSize: 24)),
                  ),
                ],
            body: listView()));
  }

  Widget listView() {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 16),
      physics: BouncingScrollPhysics(),
      children: <Widget>[calendar(), SizedBox(height: 16), dayEvents()],
    );
  }

  Widget dayEvents() {
    return FutureBuilder(
        future: Provider.of<EventsProvider>(context, listen: false)
            .fetchDayEvents(
                Provider.of<AuthProvider>(context, listen: false).user.idClass,
                _date),
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
        });
  }

  Widget calendar() {
    return FutureBuilder(
        future: Provider.of<EventsProvider>(context, listen: false)
            .calendarEvents(
                Provider.of<AuthProvider>(context, listen: false).user),
        builder: (_, AsyncSnapshot snapshot) {
          final Map<DateTime, List<dynamic>> _events = snapshot.data;

          return TableCalendar(
            events: _events,
            locale: 'es_ARG',
            calendarController: _controller,
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
              selectedDayBuilder: (context, date, events) =>
                  _buildSelectedDay(date),
              markersBuilder: (context, date, events, holidays) =>
                  _markerBuilder(date, events, holidays),
              todayDayBuilder: (context, date, events) => _buildTodayDay(date),
            ),
          );
        });
  }

  _markerBuilder(date, events, holidays) {
    final children = <Widget>[];

    if (events.isNotEmpty) {
      children.add(
        Positioned(
          right: 0,
          bottom: 0,
          left: 0,
          child: _buildEventsMarker(date, events),
        ),
      );
    }

    if (holidays.isNotEmpty) {
      children.add(
        Positioned(
          right: -2,
          top: -2,
          child: _buildHolidaysMarker(),
        ),
      );
    }

    return children;
  }

  Widget _buildTodayDay(date) {
    return Container(
        margin: const EdgeInsets.all(4.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.pink, borderRadius: BorderRadius.circular(100.0)),
        child: Text(
          date.day.toString(),
          style: TextStyle(color: Colors.white),
        ));
  }

  Widget _buildSelectedDay(date) {
    return Container(
        margin: const EdgeInsets.all(4.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(100.0)),
        child: Text(
          date.day.toString(),
          style: TextStyle(color: Colors.white),
        ));
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _controller.isSelected(date)
              ? Colors.pink[500]
              : _controller.isToday(date)
                  ? Colors.pink[300]
                  : Colors.pink[400]),
      width: 10.0,
      height: 10.0,

      /* child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 10.0,
          ),
        ),
      ), */
    );
  }

  Widget _buildHolidaysMarker() {
    return Icon(
      Icons.add_box,
      size: 20.0,
      color: Colors.blueGrey[800],
    );
  }

  Widget loadingCalendar() {
    return TableCalendar(
      calendarController: _controller,
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
                color: Colors.blue, borderRadius: BorderRadius.circular(100.0)),
            child: Text(
              date.day.toString(),
              style: TextStyle(color: Colors.white),
            )),
        todayDayBuilder: (context, date, events) => Container(
            margin: const EdgeInsets.all(4.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.pink, borderRadius: BorderRadius.circular(100.0)),
            child: Text(
              date.day.toString(),
              style: TextStyle(color: Colors.white),
            )),
      ),
    );
  }
}
