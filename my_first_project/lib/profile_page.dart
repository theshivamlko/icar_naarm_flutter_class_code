import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String photoPath = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile Page")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: [
          photoPath.isEmpty
              ? Icon(Icons.image_outlined, size: 200)
              : CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.white,
                  child: ClipOval(
                      clipBehavior: Clip.antiAlias,
                      child: Image.file(File(photoPath))),
                ),

          GestureDetector(
            onTap: () {
              pickImage("gallery");
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text("Pick from Gallery"),
            ),
          ),
          GestureDetector(
            onTap: () {
              pickImage("camera");
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text("Pick from Camera"),
            ),
          ),
        ],
      ),
    );
  }

  void pickImage(String mode) async {
    ImagePicker imagePicker = ImagePicker();
    XFile? xFile = await imagePicker.pickImage(
      source: mode == "gallery" ? ImageSource.gallery : ImageSource.camera,
    );
    photoPath = xFile!.path;
    setState(() {});
  }
}
