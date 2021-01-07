import 'package:flutter/material.dart';
import '../helpers/db_helper.dart' as DBHelper;
import 'package:provider/provider.dart';
import '../providers/outfits.dart';
import '../models/outfit.dart';

class Events with ChangeNotifier {
  Map<DateTime, List> _events = {};

  Map<DateTime, List> get events {
    return {..._events};
  }

  void fetchAndSetEvents(BuildContext context) async {
    final List<Map<String, dynamic>> result =
        await DBHelper.query(DBHelper.Tables.Events);
    print(result);
    // await Provider.of<Outfits>(context, listen: false)
    // .fetchAndSetOutfits(context);
    final outfits = Provider.of<Outfits>(context, listen: false).outfits;
    print('Outfits events' + outfits.toString());
    for (var event in result) {
      final outfit = outfits
          .firstWhere((element) => element.id.toString() == event['outfit_id']);
      _events[DateTime(event['date'])] = [outfit];
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
