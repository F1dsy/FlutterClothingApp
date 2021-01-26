import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/event.dart';
import '../items/item_widget.dart';

void showEvent(BuildContext context, Event event) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppBar(
            title: Text(DateFormat.yMd().format(event.date)),
            automaticallyImplyLeading: false,
          ),
          Container(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: event.outfit.items
                  .map((item) => ItemWidget(item, (_) {}))
                  .toList(),
            ),
          )
        ],
      ),
    ),
  );
}
