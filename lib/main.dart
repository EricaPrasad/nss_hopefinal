import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_nss/screens/home/home.dart';
import 'package:task_nss/attendance_page.dart';
import 'package:task_nss/activity_tracker_page.dart';
import 'package:task_nss/blood_donation_page.dart';
import 'package:task_nss/feedback_page.dart';
import 'package:task_nss/LoginPage.dart'; // Import LoginPage
import 'package:task_nss/SignUp.dart'; // Import SignUpPage
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyAcKZyy6YM149jditUmL9TbAq_hvdZMl1M",
          authDomain: "nss-community-connect.firebaseapp.com",
          projectId: "nss-community-connect",
          storageBucket: "nss-community-connect.appspot.com",
          messagingSenderId: "142651066073",
          appId: "1:142651066073:web:adec2ec1d96724eb1320c8",
          measurementId: "G-TC6NQT7VZZ"));
  } else {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
