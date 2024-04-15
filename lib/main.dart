import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_nss/screens/home/home.dart';
import 'package:task_nss/attendance_page.dart';
import 'package:task_nss/activity_tracker_page.dart';
import 'package:task_nss/blood_donation_page.dart';
import 'package:task_nss/feedback_page.dart';
import 'package:task_nss/LoginPage.dart'; // Import LoginPage
import 'package:task_nss/SignUp.dart'; // Import SignUpPage
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NSS ACTIVITY TRACKER',
      routes: {
        '/attendance': (context) => AttendancePage(),
        '/activity_tracker': (context) => ActivityTrackerPage(),
        '/blood_donation': (context) => BloodDonationPage(),
        '/feedback': (context) => FeedbackPage(),
        '/login': (context) => LoginPage(), // Define route for LoginPage
      },
      initialRoute: '/login', // Set LoginPage as the initial route
    );
  }
}
