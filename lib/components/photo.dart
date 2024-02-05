import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
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
  final _photoController = PhotoController();
  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    final firebase_storage = PhotoController();
    Uint8List? img =
        await firebase_storage.read(); // readメソッドが非同期になっているためawaitを使用
    setState(() {
      _image = img;
    });
  }

  void selectImage() async {
    Uint8List? img = await _photoController.pickImage(ImageSource.gallery);
    if (img != null) {
      await _photoController.uploadImageToFirebase(img);
      setState(() {
        _image = img;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _image != null
          ? GestureDetector(
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 120,
                child: ClipOval(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    width: 120,
                    height: 120,
                    child: Image.memory(
                      _image!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              onTap: () {
                selectImage();
              },
            )
          : GestureDetector(
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 120,
                child: ClipOval(
                  child: Container(
                    width: 120,
                    height: 120,
                    child: Icon(
                      CupertinoIcons.person,
                      color: Colors.white70,
                      size: 80,
                    ),
                  ),
                ),
              ),
              onTap: () {
                selectImage();
              },
            ),
    );
  }
}
