import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:training/controller/picker_image.dart';

class Photo extends StatefulWidget {
  final double width;
  const Photo({super.key, required this.width});

  @override
  State<Photo> createState() => _PhotoState();
}

class _PhotoState extends State<Photo> {
  Uint8List? _image;
  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _image != null
          ? CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: widget.width,
              backgroundImage: MemoryImage(_image!),
            )
          : CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 120,
              child: ClipOval(
                child: Image.asset(
                  "assets/img/user1.png",
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
            ),
    );
  }
}
