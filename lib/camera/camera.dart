import 'dart:io'; // Needed to handle the File
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraButtonPage extends StatefulWidget {
  const CameraButtonPage({super.key});

  @override
  State<CameraButtonPage> createState() => _CameraButtonPageState();
}

class _CameraButtonPageState extends State<CameraButtonPage> {
  // Variable to store the captured image
  File? _selectedImage;

  // The ImagePicker instance
  final ImagePicker _picker = ImagePicker();

  // Function to open the camera
  Future<void> _openCamera() async {
    try {
      final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

      if (photo != null) {
        setState(() {
          _selectedImage = File(photo.path);
        });
      }
    } catch (e) {
      print("Error opening camera: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tap Image to Open Camera')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Material widget for the ripple effect and shape
            Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(20),
              clipBehavior: Clip.antiAlias,
              child: Ink.image(
                // Logic: Show captured image if available, else show the "Button" image
                image: _selectedImage != null
                    ? FileImage(_selectedImage!) as ImageProvider
                    : const NetworkImage('https://cdn-icons-png.flaticon.com/512/3687/3687416.png'),
                width: 200,
                height: 200,
                fit: BoxFit.cover,
                child: InkWell(
                  // This is where the camera triggers
                  onTap: _openCamera, 
                  splashColor: Colors.white.withOpacity(0.3),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Tap the icon to take a photo",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}