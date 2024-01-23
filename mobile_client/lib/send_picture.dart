// A widget that displays the picture taken by the user.
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_client/room_data_page.dart';

import 'RoomData.dart';

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  Future<void> uploadImageToServer(BuildContext context) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://172.16.55.198:5000/process_image'));

    request.files.add(await http.MultipartFile.fromPath('image', imagePath));

    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        print('Image uploaded successfully!');
        // Handle success (if needed)
        print(response.body);
        final Map<String, dynamic> data = json.decode(response.body);
        RoomData roomData = RoomData.fromJson(data);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => RoomDataPage(roomData: roomData),
          ),
        );
        print(roomData);
      } else {
        // Handle failure (if needed)
        print("Error");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Bad image, take another picture and try again.'),
          duration: const Duration(seconds: 3),
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Column(
        children: [
          Image.file(File(imagePath)),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              uploadImageToServer(context);
            },
            style: ElevatedButton.styleFrom(
                foregroundColor: const Color(0xff1e0653),
                backgroundColor: const Color(0xffebddff)),
            child: const Text("Send the picture"),
          ),
          //const SizedBox(height: 10),
        ],
      ),
    );
  }
}
