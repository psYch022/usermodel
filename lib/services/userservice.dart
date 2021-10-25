import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:thaartransport/Utils/firebase.dart';
import 'package:thaartransport/modal/usermodal.dart';
import 'package:thaartransport/services/services.dart';

class UserService extends Service {
  //get the authenticated uis
  currentNumber() {
    return FirebaseAuth.instance.currentUser!.phoneNumber.toString();
  }

  String currentUid() {
    return FirebaseAuth.instance.currentUser!.uid.toString();
  }

  setUserStatus(bool isOnline) {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      usersRef
          .doc(currentUid())
          .update({'isOnline': isOnline, 'lastSeen': Timestamp.now()});
    }
  }

  updateProfile(
      {File? image,
      String? username,
      String? companyname,
      String? role,
      String? country}) async {
    DocumentSnapshot doc = await usersRef.doc(currentUid()).get();
    var users = UserModel.fromJson(doc.data() as Map<String, dynamic>);
    users.username = username;
    users.country = country;
    if (image != null) {
      users.photourl = await uploadImage(profilePic, image);
    }
    await usersRef.doc(currentUid()).update({
      'username': username ?? '',
      'companyname': companyname ?? '',
      'location': country ?? '',
      'role': role ?? '',
      "photourl": users.photourl ?? '',
    });

    return true;
  }

  var countNumber = 0;
  Future getCount({String? id}) async => postRef
          .where('CurrentUserNo', isEqualTo: user!.phoneNumber)
          .get()
          .then((value) {
        countNumber = value.docs.length;

        return countNumber;
      });
}
