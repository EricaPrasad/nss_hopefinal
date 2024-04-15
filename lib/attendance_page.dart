import 'dart:math';

import 'package:flutter/material.dart';

class AttendancePage extends StatelessWidget {
  // Generate random attendance data
  final Random _random = Random();
  final List<String> _names = [
    'Alice',
    'Bob',
    'Charlie',
    'David',
    'Eve',
    'Frank',
    'Grace',
    'Henry',
    'Ivy',
    'Jack',
  ];

  List<String> generateAttendanceData() {
    List<String> attendanceData = [];
    for (int i = 0; i < _names.length; i++) {
      int randomHours = _random.nextInt(3) + 1; // Random hours between 1 and 3
      attendanceData.add('${_names[i]}: $randomHours hours');
    }
    return attendanceData;
  }

  @override
  Widget build(BuildContext context) {
    List<String> attendanceData = generateAttendanceData();

    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance Page'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: attendanceData.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              color: index % 2 == 0 ? Colors.blue[100] : Colors.green[100],
              child: ListTile(
                title: Text(
                  attendanceData[index],
                  style: TextStyle(
                    color: index % 2 == 0 ? Colors.blue[900] : Colors.green[900],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: CircleAvatar(
                  backgroundColor: index % 2 == 0 ? Colors.blue[300] : Colors.green[300],
                  child: Text(
                    '${_names[index][0]}',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
