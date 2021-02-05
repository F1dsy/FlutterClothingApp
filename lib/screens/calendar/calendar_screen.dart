import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';

import '../../screens/calendar/add_event_screen.dart';
import '../../providers/events.dart';
import '../../models/event.dart';
import '../../widgets/custom_app_bar.dart';
import '../../l10n/app_localizations.dart';
import 'event_widget.dart';

class CalendarScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarController _calendarController = CalendarController();
  // Map<DateTime, List<dynamic>> _events = {};
  List<Event> _selectedEvents = [];

  DateTime _selectedDay = DateTime.now();

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  void _addNewEvent() {
    Navigator.of(context, rootNavigator: true)
        .pushNamed(AddEventScreen.routeName, arguments: _selectedDay);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text('Calendar'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addNewEvent,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Consumer<Events>(
          builder: (context, data, child) => Column(
            children: [
              TableCalendar(
                initialSelectedDay: _selectedDay,
                calendarController: _calendarController,
                startingDayOfWeek: StartingDayOfWeek.monday,
                locale: AppLocalizations.of(context).localeName,
                weekendDays: [],
                events: data.events,
                initialCalendarFormat: CalendarFormat.month,
                headerStyle: HeaderStyle(
                  centerHeaderTitle: true,
                  formatButtonVisible: false,
                ),
                onDaySelected: (day, events, holidays) {
                  setState(() {
                    _selectedDay = day;
                    _selectedEvents = (events is List<Event>) ? events : null;
                  });
                },
                availableGestures: AvailableGestures.horizontalSwipe,
                calendarStyle: CalendarStyle(
                  selectedColor: Theme.of(context).primaryColor,
                  todayColor: Theme.of(context).primaryColor.withOpacity(0.6),
                ),
              ),
              Column(
                children: _selectedEvents == null
                    ? []
                    : _selectedEvents.map((event) {
                        return Card(
                          margin: EdgeInsets.all(5),
                          child: ListTile(
                            title: Text(event.time.format(context) ?? 'NO'),
                            onTap: () => showEvent(context, event),
                          ),
                        );
                      }).toList(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 65.0),
        child: FloatingActionButton(
          onPressed: _addNewEvent,
          child: Icon(Icons.add),
          heroTag: null,
        ),
      ),
    );
  }
}
