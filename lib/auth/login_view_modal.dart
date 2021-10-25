import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:thaartransport/Utils/constants.dart';
import 'package:thaartransport/auth/otp.dart';
import 'package:thaartransport/services/auth_service.dart';
import 'package:thaartransport/widget/indicatiors.dart';

class LoginViewModal extends ChangeNotifier {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool validate = false;
  bool loading = false;
  AuthService auth = AuthService();
  TextEditingController phoneController = TextEditingController();

  var showDialogBox = false;

  late String verificationId;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool status = false;
  int charLength = 0;
  int numberlimit = 10;
  int otplimit = 6;

  onChanged(String value) {
    charLength = value.length;
    notifyListeners();
    if (charLength == 10) {
      status = true;
      notifyListeners();
    } else {
      status = false;
      notifyListeners();
    }
  }

  onChangedOtp(String value) {
    charLength = value.length;
    notifyListeners();
    if (charLength == 6) {
      status = true;
      notifyListeners();
    } else {
      status = false;
      notifyListeners();
    }
  }

  void dispose() {
    // notifyListeners();
    super.dispose();
  }

  numbererror() {
    Fluttertoast.showToast(
        msg: "Enter Valid Numner ",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    notifyListeners();
  }

  login(BuildContext context) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: "+91" + phoneController.text.toString().trim(),
      timeout: const Duration(seconds: 60),
      verificationCompleted: (phoneAuthCredential) async {
        circularProgress(context);
        notifyListeners();
      },
      verificationFailed: (verificationFailed) async {
        circularProgress(context);
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(
            (SnackBar(content: Text(verificationFailed.message!))));

        notifyListeners();
      },
      codeSent: (verificationId, resendingToken) async {
        circularProgress(context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    OTPScreen(verificationId, phoneController.text)));
        this.verificationId = verificationId;
        notifyListeners();
      },
      codeAutoRetrievalTimeout: (verificationId) async {},
    );
  }
}
