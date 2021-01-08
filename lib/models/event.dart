import 'package:flutter/foundation.dart';

import 'outfit.dart';

class Event {
  final int id;
  String title;
  DateTime date;
  Outfit outfit;

  Event({
    @required this.id,
    this.title,
    this.date,
    this.outfit,
  });
}
