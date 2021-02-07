import 'package:flutter/material.dart';

import '../helpers/db_helper.dart' as DBHelper;
import '../models/outfit.dart';

import '../models/event.dart';

class Events with ChangeNotifier {
  Map<DateTime, List<Event>> _events = {};

  Map<DateTime, List<Event>> get events {
    return {..._events};
  }

  void fetchAndSetEvents(List<Outfit> outfits) async {
    if (outfits.isEmpty) return;

    final List<Map<String, dynamic>> result =
        await DBHelper.query(DBHelper.Tables.Events);

    for (var eventData in result) {
      final outfit = outfits.firstWhere(
        (element) => element.id == eventData['outfit_id'],
      );

      DateTime dateTime = DateTime.parse(eventData['date']);

      Event event = Event(
        id: eventData['event_id'],
        date: dateTime,
        outfit: outfit,
      );

      _events[dateTime] = [event];
    }
    notifyListeners();
  }

  void addEvent(Event event) async {
    final int id = await DBHelper.insert(DBHelper.Tables.Events, {
      'date': event.date.toIso8601String(),
      'outfit_id': event.outfit.id,
    });
    _events[event.date] = [
      Event(
        id: id,
        date: event.date,
        outfit: event.outfit,
      )
    ];
    notifyListeners();
  }
}
