import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AttendancePage extends StatefulWidget {
  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  List<Map<String, dynamic>> _attendanceRecords = [];
  Map<String, Color> _eventColors = {};
  double _totalVolunteeredHours = 0.0;

  String _eventName = '';
  double _volunteeredHours = 0.0;
  final double _requiredHours = 120.0;

  bool _isSaving = false; // New boolean flag to prevent multiple saves

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _loadSavedDataFromFirestore(); // Load saved data when the widget initializes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Text(
                'Total Volunteered Hours: $_totalVolunteeredHours / $_requiredHours',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 40),
              SizedBox(
                width: 250,
                height: 250,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      value: _totalVolunteeredHours / _requiredHours,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                      strokeWidth: 180,
                    ),
                    Text(
                      '${(_totalVolunteeredHours / _requiredHours * 100).toStringAsFixed(1)}%',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isSaving ? null : _saveAttendanceRecord, // Disable button if saving
                child: Text('Save Record'),
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Event Name',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _eventName = value;
                  });
                },
              ),
              SizedBox(height: 10),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Enter Hours',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  double inputHours = double.tryParse(value) ?? 0;
                  setState(() {
                    _volunteeredHours = inputHours;
                  });
                },
              ),
              SizedBox(height: 20),
              _buildAttendanceRecordsTable(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAttendanceRecordsTable() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
      ),
      child: DataTable(
        columns: [
          DataColumn(label: Text('Event')),
          DataColumn(label: Text('Hours')),
        ],
        rows: _attendanceRecords
            .map((record) => DataRow(
          cells: [
            DataCell(Text(record['event'])),
            DataCell(Text(record['hours'].toString())),
          ],
          color: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              return _eventColors[record['event']] ?? Colors.grey;
            },
          ),
        ))
            .toList(),
      ),
    );
  }

  void _saveAttendanceRecord() async {
    // Set flag to indicate saving in progress
    setState(() {
      _isSaving = true;
    });

    // Your saving logic...
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        if (_totalVolunteeredHours + _volunteeredHours <= _requiredHours) {
          setState(() {
            _totalVolunteeredHours += _volunteeredHours;
            _attendanceRecords.add({
              'event': _eventName,
              'hours': _volunteeredHours,
              'userId': user.uid, // Associate record with user ID
            });
            _eventColors[_eventName] = _getEventColor(_eventName);
            _eventName = '';
            _volunteeredHours = 0.0;
          });
          await _saveDataToFirestore(); // Save the updated data to Firestore
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Warning'),
                content: Text(
                    'Total volunteered hours cannot exceed $_requiredHours hours.'),
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
      }
    } catch (e) {
      print('Error saving data: $e');
    } finally {
      // Reset flag after saving completes or if an error occurs
      setState(() {
        _isSaving = false;
      });
    }
  }

  Color _getEventColor(String eventName) {
    switch (eventName) {
      case 'Yellow':
        return kYellow;
      case 'Red':
        return kRed;
      case 'Blue':
        return kBlue;
      default:
        return Colors.grey;
    }
  }

  final Color kYellow = Color(0xFFFAF0DA);
  final Color kRed = Color(0xFFFBE4E6);
  final Color kBlue = Color(0xFFE1EDFC);

  // Save data to Firestore
  Future<void> _saveDataToFirestore() async {
    try {
      CollectionReference attendanceCollection =
      FirebaseFirestore.instance.collection('attendance');
      for (Map<String, dynamic> record in _attendanceRecords) {
        await attendanceCollection.add(record);
      }
    } catch (e) {
      print('Error saving data to Firestore: $e');
    }
  }

  Future<void> _loadSavedDataFromFirestore() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        CollectionReference attendanceCollection =
        FirebaseFirestore.instance.collection('attendance');
        QuerySnapshot querySnapshot = await attendanceCollection
            .where('userId', isEqualTo: user.uid) // Query records associated with the user ID
            .get();
        setState(() {
          _attendanceRecords.clear(); // Clear the list before adding new data
          _attendanceRecords.addAll(querySnapshot.docs
              .map((doc) => doc.data() as Map<String, dynamic>)
              .toList());
        });
      }
    } catch (e) {
      print('Error loading data from Firestore: $e');
    }
  }
}