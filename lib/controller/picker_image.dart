import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:training/controller/UserInfo.dart';

class PhotoController {
  var fileName;
  final db = FirebaseFirestore.instance;
  DateTime dt = DateTime.now();
  Future<void> uploadImageToFirebase(Uint8List imageBytes) async {
    try {
      deletePhoto();
      //アップロード作業
      fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageReference =
          FirebaseStorage.instance.ref().child('$userId/img/$fileName.png');
      UploadTask uploadTask = storageReference.putData(imageBytes);
      //
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      String downloadURL = await taskSnapshot.ref.getDownloadURL();
      await db
          .collection('userId')
          .doc(userId)
          .collection('downloadImage')
          .doc("img")
          //Modelを使用してtitleに値を入れる
          .set({'title': downloadURL, 'time': dt});
    } catch (e) {
      print("Error uploading file: $e");
    }
  }

  Future<Uint8List?> pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);

    if (_file != null) {
      return await _file.readAsBytes();
    }

    print("No Images Selected");
    return null;
  }

  Future<Uint8List?> read() async {
    try {
      final doc = await db
          .collection('userId')
          .doc(userId)
          .collection('downloadImage')
          .doc("img")
          .get();

      String? imageUrl = doc.data()?["title"];
      if (imageUrl != null) {
        // 画像のURLから画像をダウンロード
        final Uint8List imageBytes = await _downloadImage(imageUrl);
        return imageBytes;
      }

      return null;
    } catch (e) {
      print("Error reading image: $e");
      return null;
    }
  }

  Future<Uint8List> _downloadImage(String imageUrl) async {
    final HttpClientRequest request =
        await HttpClient().getUrl(Uri.parse(imageUrl));
    final HttpClientResponse response = await request.close();
    return Uint8List.fromList(
        await consolidateHttpClientResponseBytes(response));
  }

  Future<void> deletePhoto() async {
    Reference storageReference =
        FirebaseStorage.instance.ref().child('$userId/img/$fileName.png');
    await storageReference.delete();
  }
}
