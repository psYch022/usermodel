import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thaartransport/Utils/firebase.dart';
import 'package:thaartransport/auth/login.dart';
import 'package:thaartransport/auth/login_view_modal.dart';
import 'package:thaartransport/auth/register.dart';
import 'package:thaartransport/screens/homepage.dart';
import 'package:thaartransport/services/userservice.dart';

class AuthService {
  User? getCurrentUser() {
    User? user = firebaseAuth.currentUser;
    return user;
  }

  Future<bool> createUser({
    String? username,
    String? companyname,
    String? location,
  }) async {
    var res = await FirebaseAuth.instance.currentUser!.uid;
    if (res != null) {
      await saveRegistertoFirestore(username, res, companyname, location);
      return true;
    } else {
      return false;
    }
  }

  saveRegistertoFirestore(username, res, companyname, location) {}

//this will save the details inputted by the user to firestore.
  saveUserToFirestore(BuildContext context) async {
    await usersRef.doc(UserService().currentUid()).set({
      "id": UserService().currentUid(),
      "usernumber": UserService().currentNumber(),
      "creationtime": user!.metadata.creationTime.toString(),
      "location": "",
      "state": "",
      "country": "",
      "username": "",
      "companyname": "",
      "role": "",
      "photourl": "",
      "lastsigntime": Timestamp.now().toDate()
    });
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => UserRegistration()));
  }

  saveUserToUpdateFirestore(BuildContext context) async {
    await usersRef.doc(UserService().currentUid()).update({
      "id": UserService().currentUid(),
      "usernumber": UserService().currentNumber(),
      "lastsigntime": Timestamp.now().toDate()
    });
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  logOut(BuildContext context) async {
    await firebaseAuth.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => EnterNumber()),
        (route) => false);
  }
}
