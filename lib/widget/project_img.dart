// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:portfolio_creator/provider/set_profile_data.dart';
import 'package:provider/provider.dart';

class ProjectImg extends StatefulWidget {
  const ProjectImg({super.key});

  @override
  State<ProjectImg> createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<ProjectImg> {
  XFile? imageFile;
  ImagePicker imagePicker = ImagePicker();
  String? imagePath;

  Future<String> captureImage() async {
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.rear,
    );
    final setProfileDataProvider = Provider.of<SetProfileDataProvider>(
      context,
      listen: false,
    );
    if (pickedImage != null) {
      setState(() {
        imageFile = pickedImage;
        imagePath = pickedImage.path;
        setProfileDataProvider.setProjectImg(imagePath);
      });
      return imageFile?.path ?? "";
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('"No Image Captured"')));
      return "No Image Captured";
    }
  }

  Future<String> pickImage() async {
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    final setProfileDataProvider = Provider.of<SetProfileDataProvider>(
      context,
      listen: false,
    );
    if (pickedImage != null) {
      setState(() {
        imageFile = pickedImage;
        imagePath = pickedImage.path;
        setProfileDataProvider.setProjectImg(imagePath);
      });
      return imageFile?.path ?? "";
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('"No Image Captured"')));
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
              height: MediaQuery.of(context).size.height * 1,
              width: MediaQuery.of(context).size.width * 1,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black45),
                borderRadius: BorderRadius.circular(20),
              ),
              child: imageFile == null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.camera_alt_outlined,
                          size: 50,
                          color: Colors.grey,
                        ),
                        Text(
                          'Upload Project Image',
                          style: TextStyle(color: Colors.black54),
                        ),
                      ],
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.file(
                        File(imageFile?.path ?? ""),
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
