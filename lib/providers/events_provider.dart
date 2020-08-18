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

  Future<List<Event>> fetchDayEvents(int idClass, DateTime _actualDay) async {
    List<Event> _results;
    try {
      _events = await _eventsService.fetchAllEvents(idClass);

      _results = _events
          .where((event) =>
              DateTime.parse(event.date).difference(_actualDay).inDays == 0)
          .toList();
      return _results;
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
