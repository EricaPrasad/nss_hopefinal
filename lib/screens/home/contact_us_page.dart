import 'package:flutter/material.dart';

const Color kYellowLight = Color(0xFFFFF7EC);
const Color kYellow = Color(0xFFFAF0DA);
const Color kYellowDark = Color(0xFFEBBB7F);

const Color kRedLight = Color(0xFFFCF0F0);
const Color kRed = Color(0xFF7521F5);
const Color kRedDark = Color(0xFFEF777B);

const Color kBlueLight = Color(0xFFEDF4FE);
const Color kBlue = Color(0xFFE1EDFC);
const Color kBlueDark = Color(0xFF2568EF);

class ContactUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
        backgroundColor: kBlue, // Set app bar color to blue
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Motto of NSS',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: kRedDark, // Set text color to red dark
              ),
            ),
            SizedBox(height: 10),
            Text(
              'The Motto of NSS "Not Me But You", reflects the essence of democratic living and upholds the need for selfless service. NSS helps the students develop appreciation for another person\'s point of view and also shows consideration to other living beings. \n The philosophy of the NSS is well doctrine in this motto, which underlines the belief that the welfare of an individual is ultimately dependent on the welfare of the society on the whole and therefore, the NSS volunteers shall strive for the well-being of the society.',
              style: TextStyle(
                fontSize: 16,
                color: kBlueDark, // Set text color to blue dark
              ),
            ),
            SizedBox(height: 30),
            Text(
              'CONTACT US',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: kRedDark, // Set text color to red dark
              ),
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.location_on, color: kRed), // Set icon color to red
              title: Text(
                'Kurla (West)Mumbai - 400070',
                style: TextStyle(
                  fontSize: 18,
                  color: kBlueDark, // Set text color to blue dark
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.phone, color: kRed), // Set icon color to red
              title: Text(
                '022 68878700',
                style: TextStyle(
                  fontSize: 18,
                  color: kBlueDark, // Set text color to blue dark
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.email, color: kRed), // Set icon color to red
              title: Text(
                'dbit@dbit.in',
                style: TextStyle(
                  fontSize: 18,
                  color: kBlueDark, // Set text color to blue dark
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}