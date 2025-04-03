import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:table_calendar/table_calendar.dart';

// Colors
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
  late final TextEditingController _titleController;
  late final TextEditingController _durationController;
  late final TextEditingController _descriptionController;
  late final CalendarFormat _calendarFormat;
  late final DateTime _focusedDay;

  List<Map<String, dynamic>> activities = [];

  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _durationController = TextEditingController();
    _descriptionController = TextEditingController();
    _calendarFormat = CalendarFormat.month;
    _focusedDay = DateTime.now();
    _fetchActivities(); // Fetch activities when the page initializes
  }

  // Method to fetch activities from Firestore
  Future<void> _fetchActivities() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        final snapshot = await FirebaseFirestore.instance
            .collection('activities')
            .where('UserId', isEqualTo: user.uid)
            .get();

        setState(() {
          activities = snapshot.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return {
              'Title': data['Title'],
              'Duration': data['Duration'],
              'Description': data['Description'],
              'StartDate': (data['StartDate'] as Timestamp).toDate(),
              'EndDate': (data['EndDate'] as Timestamp).toDate(),
              'UserId': user.uid,
            };
          }).toList();
        });
      }
    } catch (e) {
      print('Error fetching activities: $e');
    }
  }


  void _addActivity() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add an Activity'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: _durationController,
                  decoration: InputDecoration(labelText: 'Duration'),
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () async {
                          final selectedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2022),
                            lastDate: DateTime(2025),
                          );
                          setState(() {
                            _startDate = selectedDate;
                          });
                        },
                        child: Text(_startDate == null
                            ? 'Start Date'
                            : 'Start Date: ${_formatDate(_startDate!)}'),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: TextButton(
                        onPressed: () async {
                          final selectedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2022),
                            lastDate: DateTime(2025),
                          );
                          setState(() {
                            _endDate = selectedDate;
                          });
                        },
                        child: Text(_endDate == null
                            ? 'End Date'
                            : 'End Date: ${_formatDate(_endDate!)}'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: _saveActivity,
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // Method to save activity to Firestore
  Future<void> _saveActivity() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null && _startDate != null && _endDate != null) {
        final newActivity = {
          'Title': _titleController.text,
          'Duration': _durationController.text,
          'Description': _descriptionController.text,
          'StartDate': _startDate,
          'EndDate': _endDate,
          'UserId': user.uid, // Associate activity with user ID
        };
        await FirebaseFirestore.instance.collection('activities').add(newActivity);
        setState(() {
          activities.add(newActivity);
        });
        _titleController.clear();
        _durationController.clear();
        _descriptionController.clear();
        _startDate = null;
        _endDate = null;
        Navigator.of(context).pop();
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Please select start and end dates.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print('Error saving activity: $e');
    }
  }

  // Method to format date to day/month/year format
  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activity Tracker Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.group),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PeersActivitiesPage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: _focusedDay,
            firstDay: DateTime(2022),
            lastDay: DateTime(2025),
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: activities.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  color: index % 2 == 0 ? kYellowLight : kBlueLight,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Title: ${activities[index]["Title"]}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('Duration: ${activities[index]["Duration"]}'),
                        Text('Description: ${activities[index]["Description"]}'),
                        Text('Start Date: ${_formatDate(activities[index]["StartDate"])}'),
                        Text('End Date: ${_formatDate(activities[index]["EndDate"])}'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addActivity,
        tooltip: 'Add an Activity',
        child: Icon(Icons.add),
      ),
    );
  }
}

class PeersActivitiesPage extends StatelessWidget {
  final List<Map<String, String>> activities = [
    {"Activity": "RRC Street play and awareness", "Volunteer": "Hemesh"},
    {"Activity": "New year mela and Don Bosco Day with Muskan Children 26 January", "Volunteer": "Nishant"},
    {"Activity": "Annual Day at Muskan", "Volunteer": "Manish"},
    {"Activity": "Koshish – Mentoring the NGO’s", "Volunteer": "Manish"},
    {"Activity": "Don Bosco Oratory", "Volunteer": "Sarang"},
    {"Activity": "NSS camp Followup", "Volunteer": "Vinith"},
    {"Activity": "Career Guidance Programs in the Communities", "Volunteer": "Manish"},
    {"Activity": "Basic Computer course for youth", "Volunteer": "Salvi"},
    {"Activity": "Research on Govt schemes", "Volunteer": "Shantanu/Shanaya"}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Peers Activities'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: activities.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: index % 2 == 0 ? kYellowLight : kBlueLight,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Activity: ${activities[index]["Activity"]}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Volunteer: ${activities[index]["Volunteer"]}',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Activity Tracker App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => ActivityTrackerPage(),
      },
    );
  }
}
