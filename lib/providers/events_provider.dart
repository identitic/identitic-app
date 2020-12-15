import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'package:identitic/models/event.dart';
import 'package:identitic/models/user.dart';
import 'package:identitic/services/events_service.dart';

class EventsProvider with ChangeNotifier {
  EventsProvider() {
    fetchEvents();
  }

  EventsService _eventsService = EventsService();

  List<Event> _events;
  List<Event> _allEvents;

  List<Event> get events => _events;
  List<Event> get allEvents => _allEvents;

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
      _allEvents = await _eventsService.fetchAllEvents(idClass);
      notifyListeners();

      return _allEvents;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Event>> fetchAllEventsTeacher() async {
    try {
      _allEvents = await _eventsService.fetchAllEventsTeacher();
      notifyListeners();
      return _allEvents;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Event>> fetchDayEvents(int idClass, DateTime _selectedDay) async {
    List<Event> _results;
    try {
      _allEvents = await _eventsService.fetchAllEvents(idClass);
      if (_allEvents != null) {
        if (_allEvents.length != 0) {
          _results = _allEvents
              .where((event) =>
                  DateTime.parse(event.date).day == _selectedDay.day &&
                  DateTime.parse(event.date).month == _selectedDay.month &&
                  DateTime.parse(event.date).year == _selectedDay.year)
              .toList();
        }
        _results = [];
      }
      print(_allEvents);
      _results = [];
      return _results;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Event>> fetchDayEventsTeacher(DateTime _selectedDay) async {
    List<Event> _results;
    try {
      _allEvents = await _eventsService.fetchAllEventsTeacher();
      if (_allEvents != null) {
        if (_allEvents.length != 0) {
          _results = _allEvents
              .where((event) =>
                  DateTime.parse(event.date).day == _selectedDay.day &&
                  DateTime.parse(event.date).month == _selectedDay.month &&
                  DateTime.parse(event.date).year == _selectedDay.year)
              .toList();
        }
        _results = [];
      }
      print(_allEvents);
      _results = [];
      return _results;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<DateTime, List<dynamic>>> calendarEvents(User user) async {
    Map<DateTime, List<dynamic>> calendarEvents = Map();

    try {
      // Asking user hierarchy
      _allEvents = user.hierarchy == UserHierarchy.teacher
          ? await _eventsService.fetchAllEventsTeacher()
          : await _eventsService.fetchAllEvents(user.idClass);

      if (_allEvents != null && _allEvents.isNotEmpty) {
        _allEvents.forEach((event) {
          calendarEvents[DateTime.parse(event.date)] == null
              ? calendarEvents[DateTime.parse(event.date)] = [event]
              : calendarEvents[DateTime.parse(event.date)].add(event);
        });
      }
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }

    return calendarEvents;
  }

  Future<void> postEvent(Event event) async {
    try {
      await _eventsService.postEvent(event);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
