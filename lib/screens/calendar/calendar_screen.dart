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
  // Map<DateTime, List<dynamic>> _events = {};
  List<dynamic> _selectedEvents = [];

  @override
  void didChangeDependencies() {
    // setState(() {
    //   _events = Provider.of<Events>(context, listen: false).events;
    //   _selectedEvents = _events[DateTime.now()];
    // });
    // print(_events);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //   _events = Provider.of<Events>(context, listen: false).events;
    //   _selectedEvents = _events[DateTime.now()];

    // print('Events: ' + _events.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
      ),
      body: SingleChildScrollView(
        child: Consumer<Events>(
          builder: (context, data, child) => Column(
            children: [
              TableCalendar(
                calendarController: _calendarController,
                startingDayOfWeek: StartingDayOfWeek.monday,
                weekendDays: [],
                // calendarStyle: CalendarStyle(),
                events: data.events,
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
                    : _selectedEvents.map((event) {
                        print(event.title);
                        return Container(
                          width: double.infinity,
                          height: 60,
                          // margin: EdgeInsets.all(5),
                          child: Card(
                            margin: EdgeInsets.all(5),
                            child: Center(child: Text('event')),
                          ),
                        );
                      }).toList(),
              ),
            ],
          ),
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
