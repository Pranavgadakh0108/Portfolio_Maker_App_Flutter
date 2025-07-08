import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProjectImg extends StatefulWidget {
  const ProjectImg({super.key});

  @override
  State<ProjectImg> createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<ProjectImg> {
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
        child: GestureDetector(
          onDoubleTap: pickImage,
          onTap: captureImage,
          child: Center(
            child: Container(
              height: 200,
              width: MediaQuery.of(context).size.width * 0.7,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black45, width: 2),
                borderRadius: BorderRadius.circular(
                  20,
                ), // Changed from 120 to 20
              ),
              child: imageFile == null
                  ? const Icon(Icons.camera_alt_outlined, size: 50, color: Colors.grey)
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.file(
                        File(imageFile!.path),
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
