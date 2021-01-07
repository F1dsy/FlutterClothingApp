import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/outfit.dart';
import '../../providers/events.dart';
import '../../providers/outfits.dart';

class AddEventScreen extends StatelessWidget {
  static const routeName = '/addEvent';

  void _showDialog(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1970),
      lastDate: DateTime.now(),
    ).then((value) {
      Provider.of<Events>(context, listen: false).addEvent(
        value,
        Provider.of<Outfits>(context, listen: false).outfits[0],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Event'),
        actions: [
          IconButton(
            icon: Icon(Icons.done),
            onPressed: null,
          ),
        ],
      ),
      body: Column(
        children: [
          RaisedButton(
            onPressed: () => _showDialog(context),
            child: Text('Date'),
          ),
        ],
      ),
    );
  }
}
