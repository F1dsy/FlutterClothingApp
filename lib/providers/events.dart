import 'package:flutter/material.dart';

import '../helpers/db_helper.dart' as DBHelper;
import '../models/outfit.dart';
import '../models/event.dart';

class Events with ChangeNotifier {
  set update(List<Outfit> value) {
    if (value.isEmpty) return;
    fetchAndSetEvents(value);
  }

  Map<DateTime, List<Event>> _events = {};

  Map<DateTime, List<Event>> get events {
    return {..._events};
  }

  void fetchAndSetEvents(List<Outfit> outfits) async {
    final List<Map<String, dynamic>> result =
        await DBHelper.query(DBHelper.Tables.Events);

    for (var event in result) {
      final outfit = outfits.firstWhere(
        (element) => element.id == event['outfit_id'],
      );

      _events[DateTime.parse(event['date'])] = [
        Event(
          id: event['event_id'],
          date: DateTime.parse(event['date']),
          outfit: outfit,
        )
      ];
    }
    notifyListeners();
  }

  void addEvent(Event event) {
    DBHelper.insert(DBHelper.Tables.Events, {
      'date': event.date.toIso8601String(),
      'outfit_id': event.outfit.id,
    });
    _events[event.date] = [event];
    notifyListeners();
  }
}
