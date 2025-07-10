import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraWidget extends StatefulWidget {
  const CameraWidget({super.key});

  @override
  State<CameraWidget> createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  XFile? imageFile;
  ImagePicker imagePicker = ImagePicker();

  Future<String> captureImage() async {
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.rear,
    );
    if (pickedImage != null) {
      setState(() {
        imageFile = pickedImage;
      });
      return imageFile?.path ?? "";
    } else {
      return "No Image Captured";
    }
  }

  Future<String> pickImage() async {
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      setState(() {
        imageFile = pickedImage;
      });
      return imageFile?.path ?? "";
    } else {
      return "No Image Picked";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            GestureDetector(
              onDoubleTap: pickImage,
              child: Center(
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    border: Border.all(color: Colors.purpleAccent, width: 2),
                    borderRadius: BorderRadius.circular(120),
                  ),
                  child: imageFile == null
                      ? Icon(Icons.person, size: 40, color: Colors.grey)
                      : ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(120),
                        child: Image.file(
                            File(imageFile?.path ?? ""),
                            fit: BoxFit.cover,
                          ),
                      ),
                ),
              ),
            ),
            Positioned(
              top: 70,
              left: 80,
              child: GestureDetector(
                onTap: captureImage,
                child: Icon(Icons.camera_alt, size: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
