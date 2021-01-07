import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';

import '../../screens/calendar/add_event_screen.dart';
import '../../providers/events.dart';

class CalendarScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarController _calendarController = CalendarController();
  Map<DateTime, List<dynamic>> _events = {};
  List _selectedEvents = [];

  @override
  void didChangeDependencies() {
    // _events = Provider.of<Events>(context, listen: false).events;
    // print(_events);
    // _selectedEvents = _events[DateTime.now()];
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // _events = Provider.of<Events>(context, listen: false).events;
    // print(_events);
    // _selectedEvents = _events[DateTime.now()];
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TableCalendar(
              calendarController: _calendarController,
              startingDayOfWeek: StartingDayOfWeek.monday,
              weekendDays: [],
              events: _events,
              initialCalendarFormat: CalendarFormat.month,
              headerStyle: HeaderStyle(
                centerHeaderTitle: true,
                formatButtonVisible: false,
              ),
              onDaySelected: (day, events, holidays) {
                setState(() {
                  _selectedEvents = events;
                });
              },
              availableGestures: AvailableGestures.horizontalSwipe,
            ),
            Column(
              children: _selectedEvents == null
                  ? []
                  : _selectedEvents
                      .map(
                        (e) => Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          margin:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: ListTile(
                            title: Text(e),
                          ),
                        ),
                      )
                      .toList(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context, rootNavigator: true)
              .pushNamed(AddEventScreen.routeName);
        },
        child: Icon(Icons.add),
        heroTag: null,
      ),
    );
  }
}
