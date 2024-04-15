import 'package:flutter/material.dart';

class BloodDonationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blood Donation Page'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          _buildEventBox(
            date: 'March 15, 2023',
            location: 'Don Bosco College, Kurla',
            description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus eget aliquam velit. Nam at maximus lorem. Proin eleifend suscipit sem, nec aliquet risus ullamcorper sit amet. Proin at risus felis. Integer malesuada lorem ac urna posuere, at auctor purus vestibulum. Donec suscipit sem nec ligula pretium ultricies. Aliquam eu risus vitae urna ultrices cursus.',
          ),
          SizedBox(height: 20),
          _buildEventBox(
            date: 'November 20, 2022',
            location: 'Don Bosco College, Kurla',
            description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus eget aliquam velit. Nam at maximus lorem. Proin eleifend suscipit sem, nec aliquet risus ullamcorper sit amet. Proin at risus felis. Integer malesuada lorem ac urna posuere, at auctor purus vestibulum. Donec suscipit sem nec ligula pretium ultricies. Aliquam eu risus vitae urna ultrices cursus.',
          ),
        ],
      ),
    );
  }

  Widget _buildEventBox({
    required String date,
    required String location,
    required String description,
  }) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Date: $date',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Location: $location',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Description: $description',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
