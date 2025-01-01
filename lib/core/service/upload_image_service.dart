import 'dart:developer';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ImageServiceFirebase {
  static Future<bool> uploadImage(
      {required String fileImagePath, required String fileStoreName}) async {
    try {
      File? file;

      file = File(fileImagePath); //convert to file
      if (await file.exists()) {
        log('File found at path: $fileImagePath');
      } else {
        log('File not found at path: $fileImagePath');
      }
      var imageName = basename(fileImagePath); //get image name

      var metadata = SettableMetadata(contentType: 'image/jpeg');
      var ref = FirebaseStorage.instance.ref().child(fileStoreName).child(
          imageName); //reates a reference to a specific location in Firebase Storage where the image will be stored.

      await ref.putFile(file, metadata);

      return true;
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }

  static Future<String> getImageFirebase(
      {required String fileStoreName, required String imageName}) async {
    var url = await FirebaseStorage.instance
        .ref()
        .child(fileStoreName)
        .child(basename(imageName))
        .getDownloadURL();
    return url;
  }

  static Future<void> deleteImageFirebase(
      {required String fileStoreName, required String imageName}) async {
    await FirebaseStorage.instance
        .ref()
        .child(fileStoreName)
        .child(imageName)
        .delete();
  }
}
