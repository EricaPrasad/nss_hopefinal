import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

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
            'On March 15, 2023, Don Bosco Institute of Technology, Kurla, hosted a successful Blood Donation Camp, drawing participants from all walks of life. The event, held from 9:00 AM to 5:00 PM, saw a remarkable turnout of altruistic individuals eager to make a difference.',
            imagePath: 'assets/images/image1.png', // Path to image1
          ),
          SizedBox(height: 20),
          _buildEventBox(
            date: 'November 20, 2022',
            location: 'Don Bosco College, Kurla',
            description:
            'November 20, 2023, witnessed another successful Blood Donation Camp at Don Bosco Institute of Technology, Kurla. From 9:00 AM to 5:00 PM, the institute welcomed donors from across the region, united in their mission to make a meaningful impact through blood donation.',
            imagePath: 'assets/images/image2.jpg', // Path to image2
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCreatePostDialog(context);
        },
        tooltip: 'Create Post',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildEventBox({
    required String date,
    required String location,
    required String description,
    required String imagePath,
  }) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.calendar_today, color: Colors.blue),
                  SizedBox(width: 5),
                  Text(
                    'Date: $date',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ],
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
          Image.asset(
            imagePath,
            height: 150, // Adjust the height as needed
            width: double.infinity, // Set the width to fill the container
            fit: BoxFit.cover, // Adjust the fit as needed
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

  void _showCreatePostDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CreatePostDialog();
      },
    );
  }
}

class CreatePostDialog extends StatefulWidget {
  @override
  _CreatePostDialogState createState() => _CreatePostDialogState();
}

class _CreatePostDialogState extends State
{
  File? _image;
  String? _imagePath;

  Future<void> _getImage() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      setState(() {
        _image = File(result.files.single.path!);
        _imagePath = result.files.single.path!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Create a Post"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              labelText: "Write something...",
            ),
            autofocus: true,
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: _getImage,
                child: Text('Upload Picture'),
              ),
              if (_imagePath != null)
                Image.file(
                  File(_imagePath!),
                  height: 50,
                  width: 50,
                ),
              ElevatedButton(
                onPressed: () {
                  // Post functionality
                  _post();
                },
                child: Text('Post'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _post() {
    // Retrieve text from text field and image path
    String? text = ''; // Replace '' with the actual text from the text field
    String? imagePath = _imagePath;

    // Display post (you can customize this part based on your requirement)
    print('Posted: Text - $text, ImagePath - $imagePath');
  }
}
