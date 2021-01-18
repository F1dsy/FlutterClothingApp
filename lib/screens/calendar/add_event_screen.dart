import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '../../models/outfit.dart';
// import '../../models/event.dart';
// import '../../providers/events.dart';
import '../../providers/outfits.dart';

void addEvent(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      child: Container(
        child: Consumer<Outfits>(
          builder: (context, data, _) => ListView.builder(
            itemBuilder: (context, i) => ListTile(
              leading: Image.file(data.outfits[i].items[0].image),
            ),
            itemCount: data.outfits.length,
          ),
        ),
      ),
    ),
  );
}
