// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thaartransport/modal/usermodal.dart';
import 'package:thaartransport/services/userservice.dart';
import 'package:thaartransport/utils/constants.dart';

class EditProfileViewModel extends ChangeNotifier {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool validate = false;
  bool loading = false;
  UserService userService = UserService();
  final picker = ImagePicker();
  UserModel? user;
  String? location;
  String? username;
  String? companyname;
  File? image;
  String? imgLink;
  String? role;

  setUser(UserModel val) {
    user = val;
    notifyListeners();
  }

  setImage(UserModel user) {
    imgLink = user.photourl!;
    notifyListeners();
  }

  setlocation(String val) {
    print('Setlocation $val');
    location = val;
    notifyListeners();
  }

  setcompanyname(String val) {
    print('setcompanyname $val');
    companyname = val;
    notifyListeners();
  }

  setrole(val) {
    print('setrole $val');
    role = val;
    notifyListeners();
  }

  setUsername(String val) {
    print('SetUsername$val');
    username = val;
    notifyListeners();
  }

  editProfile(BuildContext context) async {
    FormState? form = formKey.currentState;
    form!.save();
    if (!form.validate()) {
      validate = true;
      notifyListeners();
      showInSnackBar(
          'Please fix the errors in red before submitting.', context);
    } else {
      try {
        loading = true;
        notifyListeners();
        bool success = await userService.updateProfile(
            image: image,
            username: username,
            companyname: companyname,
            country: location,
            role: role);
        notifyListeners();
        print(success);
        if (success) {
          clear();
          Navigator.pop(context);
          notifyListeners();
        }
      } catch (e) {
        loading = false;
        notifyListeners();
        print(e);
      }
      loading = false;
      notifyListeners();
    }
  }

  pickImage({bool camera = false, required BuildContext context}) async {
    loading = true;
    notifyListeners();
    try {
      PickedFile? pickedFile = await picker.getImage(
        source: camera ? ImageSource.camera : ImageSource.gallery,
      );
      File? croppedFile = await ImageCropper.cropImage(
        sourcePath: pickedFile!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Constants.lightAccent,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ),
      );
      image = File(croppedFile!.path);
      loading = false;
      notifyListeners();
    } catch (e) {
      loading = false;
      notifyListeners();
      showInSnackBar('Cancelled', context);
    }
  }

  clear() {
    image = null;
    notifyListeners();
  }

  void showInSnackBar(String value, context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
  }
}
