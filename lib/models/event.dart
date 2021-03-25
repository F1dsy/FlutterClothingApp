import 'package:flutter/material.dart';

import 'outfit.dart';

class Event {
  final int? id;

  set time(TimeOfDay time) {
    date = DateTime(date!.year, date!.month, date!.day, time.hour, time.minute);
  }

  TimeOfDay get time {
    return TimeOfDay.fromDateTime(date!);
  }

  DateTime? date;

  Outfit? outfit;

  Event({required this.id, this.date, this.outfit, time}) {
    if (time != null) {
      this.time = time;
    }
  }
}
