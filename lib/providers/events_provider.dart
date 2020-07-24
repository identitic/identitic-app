import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:identitic/models/class.dart';

import 'package:identitic/models/event.dart';
import 'package:identitic/models/user.dart';
import 'package:identitic/services/events_service.dart';

class EventsProvider with ChangeNotifier {
  EventsProvider() {
    fetchAllEvents(1);
    //TODO: Hacer get con token, no rompan hijos de puta.
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

  Future<void> postEvent(User user, Event event, Class classs) async {
    try {
      await _eventsService.postEvent(user, event, classs);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
