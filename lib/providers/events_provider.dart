import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:identitic/models/class.dart';

import 'package:identitic/models/event.dart';
import 'package:identitic/models/user.dart';
import 'package:identitic/services/events_service.dart';

class EventsProvider with ChangeNotifier {
  EventsProvider() {
    fetchEvents();
  }

  EventsService _eventsService = EventsService();
  List<Event> _events;

  List<Event> get events => _events;

  Future<List<Event>> fetchEvents() async {
    try {
      _events = await _eventsService.fetchEvents();
      notifyListeners();
      return _events;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Event>> fetchAllEvents(int idClass) async {
    try {
      _events = await _eventsService.fetchAllEvents(idClass);
      notifyListeners();

      return _events;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Event>> fetchAllEventsTeacher() async {
    try {
      _events = await _eventsService.fetchAllEventsTeacher();
      notifyListeners();

      return _events;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Event>> fetchDayEvents(int idClass, DateTime _selectedDay) async {
    List<Event> _results;
    try {
      _events = await _eventsService.fetchAllEvents(idClass);

      _results = _events
          .where((event) =>
              DateTime.parse(event.date).difference(_selectedDay).inDays == 0)
          .toList();
      return _results;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Event>> fetchDayEventsTeacher(DateTime _selectedDay) async {
    List<Event> _results;
    try {
      _events = await _eventsService.fetchAllEventsTeacher();
      if (_events.isNotEmpty) {
        _results = _events
            .where((event) =>
                DateTime.parse(event.date).difference(_selectedDay).inDays == 0)
            .toList();
      }
      return _results;
    } catch (e) {
      rethrow;
    }
  }

  calendarEvents(int idClass, DateTime _selectedDay) async {
    List<Event> _results;
    List<DateTime> _dates;
    List<DateTime> _newdates;
    Map<DateTime, List<dynamic>> _calendarEvents;
    List<dynamic> _newEvents;
    try {
      _events = await _eventsService.fetchAllEvents(idClass);

      _events.forEach((event) {
        _dates.add(DateTime.parse(event.date));
      });

      for (DateTime date in _dates) {
        for (date in _dates) {
          _newdates =
              _dates.where((element) => element.difference(date).inDays != 0);
        }
      }
      print(_newdates);
      print(_dates);
      /* _dates.where((date) => false).toList(); */

      /* _calendarEvents = Map.fromIterables(_newdates, _events); */
    } catch (e) {
      rethrow;
    }
  }

  Future<void> postEvent(User user, Event event, Class classs) async {
    try {
      await _eventsService.postEvent(user, event, classs);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
