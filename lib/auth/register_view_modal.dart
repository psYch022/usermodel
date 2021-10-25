import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:thaartransport/auth/profile_pic.dart';
import 'package:thaartransport/auth/usertype.dart';
import 'package:thaartransport/screens/homepage.dart';
import 'package:thaartransport/services/auth_service.dart';
import 'package:thaartransport/services/userservice.dart';
import 'package:thaartransport/utils/firebase.dart';

class RegisterViewModel extends ChangeNotifier {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool validate = false;
  bool loading = false;
  String? title;
  String? username;
  String? companyname;
  String? location;
  String? role;
  FocusNode usernameFN = FocusNode();
  FocusNode emailFN = FocusNode();
  FocusNode countryFN = FocusNode();
  FocusNode passFN = FocusNode();
  FocusNode cPassFN = FocusNode();
  AuthService auth = AuthService();

  register(BuildContext context) async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      await usersRef.doc(UserService().currentUid()).update({
        'location': location,
        'username': username,
        'companyname': companyname,
        'role': role
      });
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ProfilePicture()));
      print("Added");
    }
  }

  setName(val) {
    username = val;
    notifyListeners();
  }

  setCompanyName(val) {
    companyname = val;
    notifyListeners();
  }

  setlocation(val) {
    location = val;
    notifyListeners();
  }

  setrole(val) {
    role = val;
    notifyListeners();
  }

  void showInSnackBar(String value, context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
  }
}
