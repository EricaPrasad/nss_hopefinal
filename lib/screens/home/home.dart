import 'package:flutter/material.dart';
import 'package:task_nss/constants/colour.dart';
import 'package:task_nss/models/task.dart';
import 'event/go_event.dart';

class HomePage extends StatelessWidget {
  final String userName; // Add userName parameter

  HomePage({required this.userName}); // Constructor to accept userName

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(), // Call _buildAppBar method
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          event(), // Display the event widget
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.all(15),
            child: Text(
              'TASKS',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 10),
          _buildTaskGrid(context), // Display the grid of tasks
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        children: [
          Container(
            height: 45,
            width: 45,
            // child: ClipRRect(
            //   borderRadius: BorderRadius.circular(10),
            //   child: Image.asset('assets/images/nss.jpeg'), // Add user's profile image here
            // ),
          ),
          SizedBox(width: 10),
          Text(
            'HI, $userName!', // Display user's name here
            style: TextStyle(
              color: Colors.black,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
      actions: [
        Icon(
          Icons.more_vert,
          color: Colors.black,
          size: 40,
        )
      ],
    );
  }

  Widget _buildTaskGrid(BuildContext context) {
    List<Task> tasks = Task.generateTask();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          childAspectRatio: 1.0,
        ),
        itemCount: tasks.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildTaskBox(context, tasks[index]);
        },
      ),
    );
  }

  Widget _buildTaskBox(BuildContext context, Task task) {
    return GestureDetector(
      onTap: () {
        // Navigate to the desired page based on the task
        if (task.title == 'ATTENDANCE') {
          Navigator.pushNamed(context, '/attendance');
        } else if (task.title == 'ACTIVITY TRACKER') {
          Navigator.pushNamed(context, '/activity_tracker');
        } else if (task.title == 'BLOOD DONATION MANAGEMENT') {
          Navigator.pushNamed(context, '/blood_donation');
        } else if (task.title == 'FEEDBACK') {
          Navigator.pushNamed(context, '/feedback');
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: task.bgColor ?? Colors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              task.iconData ?? Icons.error,
              color: task.iconColor ?? Colors.white,
              size: 50,
            ),
            SizedBox(height: 10),
            Text(
              task.title ?? 'No Title',
              style: TextStyle(
                color: task.iconColor ?? Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16, // Increased font size
              ),
              textAlign: TextAlign.center, // Center aligned text
            ),
          ],
        ),
      ),
    );
  }
}
