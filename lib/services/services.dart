import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:thaartransport/Utils/firebase.dart';
import 'package:thaartransport/services/userservice.dart';
import 'package:thaartransport/utils/file_utils.dart';

abstract class Service {
  //function to upload images to firebase storage and retrieve the url.
  Future<String> uploadImage(Reference ref, File file) async {
    String ext = FileUtils.getFileExtension(file);
    Reference storageReference =
        ref.child("${UserService().currentUid()}.$ext");
    UploadTask uploadTask = storageReference.putFile(file);
    await uploadTask.whenComplete(() => null);
    String fileUrl = await storageReference.getDownloadURL();
    return fileUrl;
  }
}
