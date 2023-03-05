import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class FileService {
  Future<String> uploadFile(File image) async {
    var ref = FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(image.path).pathSegments.last}');
    await ref.putFile(image);
    var imageUrl = ref.getDownloadURL();
    return imageUrl;
  }
}
