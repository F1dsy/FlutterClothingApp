import 'package:flutter/material.dart';
import '../helpers/db_helper.dart' as DBHelper;
import 'package:provider/provider.dart';
import '../providers/outfits.dart';

class Events with ChangeNotifier {
  Map<DateTime, List> _events = {};

  Map<DateTime, List> get events {
    return {..._events};
  }

  void fetchAndSetEvents(BuildContext context) async {
    final List<Map<String, dynamic>> result =
        await DBHelper.query(DBHelper.Tables.Events);
    final outfits = Provider.of<Outfits>(context).outfits;
    for (var event in result) {
      final outfit =
          outfits.firstWhere((element) => element.id == event['outfit_id']);
      _events[event['date']] = [outfit];
    }
    notifyListeners();
  }
}
