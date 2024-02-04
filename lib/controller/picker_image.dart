import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PhotoController {
  Future<void> uploadImageToFirebase(Uint8List imageBytes) async {
    try {
      //アップロード作業
      String fileName =
          DateTime.now().millisecondsSinceEpoch.toString(); // ファイル名をユニークにする
      Reference storageReference =
          FirebaseStorage.instance.ref().child('images/$fileName.png');
      UploadTask uploadTask = storageReference.putData(imageBytes);
      //
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      String downloadURL = await taskSnapshot.ref.getDownloadURL();
      print("downLoad URL ; " + downloadURL);
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
}
