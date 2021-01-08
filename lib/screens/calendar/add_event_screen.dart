import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/outfit.dart';
import '../../models/event.dart';
import '../../providers/events.dart';
import '../../providers/outfits.dart';

class AddEventScreen extends StatefulWidget {
  static const routeName = '/addEvent';

  @override
  _AddEventScreenState createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  DateTime _selectedTime = DateTime.now();
  Outfit _selectedOutfit;
  TextEditingController _textEditingController = TextEditingController();

  @override
  void didChangeDependencies() {
    _selectedOutfit = Provider.of<Outfits>(context).outfits[0];
    super.didChangeDependencies();
  }

  void _showDialog(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1970),
      lastDate: DateTime.now(),
    ).then((value) {
      _selectedTime = value;
    });
  }

  void _save() {
    print('Time: ' + _selectedTime.toIso8601String());
    print('Outfit: ' + _selectedOutfit.toString());
    print('Title: ' + _textEditingController.text.toString());
    Provider.of<Events>(context, listen: false).addEvent(Event(
      id: null,
      date: _selectedTime,
      outfit: _selectedOutfit,
      title: _textEditingController.text,
    ));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Event'),
        actions: [
          IconButton(
            icon: Icon(Icons.done),
            onPressed: _save,
          ),
        ],
      ),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(labelText: 'Title'),
            controller: _textEditingController,
          ),
          RaisedButton(
            onPressed: () => _showDialog(context),
            child: Text('Date'),
          ),
          DropdownButton(
            value: Provider.of<Outfits>(context).outfits[0],
            items: Provider.of<Outfits>(context)
                .outfits
                .map((outfit) => DropdownMenuItem(
                      child: Text(outfit.id.toString()),
                      value: outfit,
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                _selectedOutfit = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
