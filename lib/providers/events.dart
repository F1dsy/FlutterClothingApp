import 'package:flutter/material.dart';
import '../helpers/db_helper.dart' as DBHelper;
// import 'package:provider/provider.dart';
// import '../providers/outfits.dart';
import '../models/outfit.dart';

class Events with ChangeNotifier {
  set update(value) {
    fetchAndSetEvents(value);
  }

  Map<DateTime, List> _events = {};

  Map<DateTime, List> get events {
    return {..._events};
  }

  void fetchAndSetEvents(List<Outfit> outfits) async {
    final List<Map<String, dynamic>> result =
        await DBHelper.query(DBHelper.Tables.Events);
    // print('result' + result.toString());
    // print('Outfits events' + outfits.toString());
    for (var event in result) {
      final outfit = outfits.where(
        (element) => element.id == event['outfit_id'],
      );
      // print('outfits: ' + outfit.toString());
      _events[DateTime.parse(event['date'])] = [...outfit];
    }
    notifyListeners();
  }

  void addEvent(DateTime date, Outfit outfit) {
    DBHelper.insert(DBHelper.Tables.Events, {
      'date': date.toIso8601String(),
      'outfit_id': outfit.id,
    });
    _events[date] = [outfit];
    notifyListeners();
  }
}
