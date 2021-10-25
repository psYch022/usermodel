import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thaartransport/Utils/constants.dart';
import 'package:thaartransport/Utils/firebase.dart';
import 'package:lottie/lottie.dart';
import 'package:thaartransport/auth/login_view_modal.dart';
import 'package:thaartransport/screens/homepage.dart';
import 'package:thaartransport/services/auth_service.dart';
import 'package:thaartransport/services/userservice.dart';

import 'login.dart';

class OTPScreen extends StatefulWidget {
  final String verificationOtp;
  final String phone;
  const OTPScreen(
    this.verificationOtp,
    this.phone,
  );
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  late String _verificationCode;
  final TextEditingController otpController = TextEditingController();

  bool hasError = false;
  var showDialogBox = false;

  bool status = false;

  var isValidUser = false;
  bool showLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FocusNode _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: Constants.white,
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: Constants.textfieldborder,
    ),
  );
  void initState() {}
  int charLength = 0;
  onChangedOtp(String value) {
    setState(() {
      charLength = value.length;
    });

    if (charLength == 6) {
      setState(() {
        status = true;
      });
    } else {
      setState(() {
        status = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    LoginViewModal loginViewModal = Provider.of<LoginViewModal>(context);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        key: _scaffoldkey,
        appBar: AppBar(
          elevation: 0.0,
          title: const Text(
            "Thaar",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
        ),
        body: Padding(
            padding:
                const EdgeInsets.only(top: 10, left: 10, right: 5, bottom: 5),
            child: Container(
                height: height,
                child: SingleChildScrollView(
                    reverse: true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Lottie.asset('assets/60247-mobile-otp.json'),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        const Text.rich(TextSpan(
                            text: 'Enter  OTP\n',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: 'You will receive the OTP on',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                              )
                            ])),
                        SizedBox(height: height * 0.03),
                        Row(
                          children: [
                            Text(
                              widget.phone,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                // saveNumber();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EnterNumber()));
                              },
                              child: const CircleAvatar(
                                  backgroundColor: Colors.orange,
                                  radius: 15,
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 20,
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.04,
                        ),
                        Visibility(
                            visible: showDialogBox,
                            child: const Align(
                              alignment: Alignment.center,
                              child: CircularProgressIndicator(),
                            )),
                        PinPut(
                          fieldsCount: 6,
                          textStyle: TextStyle(
                              fontSize: 25.0, color: Constants.btntextactive),
                          eachFieldWidth: 40.0,
                          eachFieldHeight: 55.0,
                          focusNode: _pinPutFocusNode,
                          controller: otpController,
                          submittedFieldDecoration: pinPutDecoration,
                          selectedFieldDecoration: pinPutDecoration,
                          followingFieldDecoration: pinPutDecoration,
                          pinAnimationType: PinAnimationType.fade,
                          onChanged: onChangedOtp,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          height: height * 0.09,
                        ),
                        Visibility(
                            maintainSize: true,
                            maintainAnimation: true,
                            maintainState: true,
                            visible: status,
                            child: RaisedButton(
                                color: Constants.btnBG,
                                onPressed: () async {
                                  PhoneAuthCredential phoneAuthCredential =
                                      await PhoneAuthProvider.credential(
                                          verificationId:
                                              widget.verificationOtp.toString(),
                                          smsCode: otpController.text);

                                  signInWithPhoneAuthCredential(
                                      phoneAuthCredential);

                                  CheckDataExit();

                                  setState(() {
                                    hasError = true;
                                  });
                                },
                                child: Container(
                                  width: width,
                                  height: height * 0.06,
                                  alignment: Alignment.center,
                                  child: const Text(
                                    "Verify Now",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                )))
                      ],
                    )))));
  }

  CheckDataExit() async {
    var data = await usersRef.doc(UserService().currentUid()).get();
    if (data.exists) {
      print('Exists');
      AuthService().saveUserToUpdateFirestore(context);
    }
    if (!data.exists) {
      print('Not exists');

      AuthService().saveUserToFirestore(context);
    }
  }

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });

    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

      setState(() {
        showLoading = false;
      });

      if (authCredential.user != null) {
        CheckDataExit();
        showLoading = true;
        showDialogBox = true;
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });
      print(e.message);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please enter corrent otp number')));
    }
  }
}
