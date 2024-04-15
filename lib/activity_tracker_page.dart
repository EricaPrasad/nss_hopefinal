import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

const Color kYellowLight = Color(0xFFFFF7EC);
const Color kYellow = Color(0xFFFAF0DA);
const Color kYellowDark = Color(0xFFEBBB7F);

const Color kRedLight = Color(0xFFFCF0F0);
const Color kRed = Color(0xFFFBE4E6);
const Color kRedDark = Color(0xFFF08A8E);

const Color kBlueLight = Color(0xFFEDF4FE);
const Color kBlue = Color(0xFFE1EDFC);
const Color kBlueDark = Color(0xFFC0D3F8);

class ActivityTrackerPage extends StatefulWidget {
  @override
  _ActivityTrackerPageState createState() => _ActivityTrackerPageState();
}

class _ActivityTrackerPageState extends State<ActivityTrackerPage> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  late final ValueNotifier<DateTime> _focusedDay;
  late final TextEditingController _eventController;
  late final CalendarFormat _calendarFormat;

  final Map<DateTime, List<Event>> _events = {};
  final List<Event> _selectedDayEvents = [];

  @override
  void initState() {
    super.initState();
    final _selectedDay = DateTime.now();
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay));
    _focusedDay = ValueNotifier(_selectedDay);
    _eventController = TextEditingController();
    _calendarFormat = CalendarFormat.month;
  }

  List<Event> _getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activity Tracker Page'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TableCalendar<Event>(
            firstDay: DateTime.utc(2022, 1, 1),
            lastDay: DateTime.utc(2025, 12, 31),
            focusedDay: _focusedDay.value,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) => isSameDay(_focusedDay.value, day), // Import isSameDay function
            eventLoader: _getEventsForDay,
            onDaySelected: (selectedDay, focusedDay) {
              _focusedDay.value = focusedDay;
              _selectedEvents.value = _getEventsForDay(selectedDay);
            },
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ValueListenableBuilder<List<Event>>(
              valueListenable: _selectedEvents,
              builder: (context, events, _) {
                return ListView.builder(
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(events[index].title),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Event {
  final String title;

  const Event(this.title);
}
