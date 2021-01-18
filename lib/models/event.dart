import 'package:flutter/foundation.dart';

import 'outfit.dart';

class Event {
  final int id;

  DateTime date;
  Outfit outfit;

  Event({
    @required this.id,
    this.date,
    this.outfit,
  });
}
