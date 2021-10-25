import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thaartransport/Utils/constants.dart';
import 'package:thaartransport/auth/login_view_modal.dart';
import 'package:thaartransport/widget/indicatiors.dart';

import 'otp.dart';

class EnterNumber extends StatefulWidget {
  @override
  _EnterNumberState createState() => _EnterNumberState();
}

class _EnterNumberState extends State<EnterNumber> {
  var showDialogBox = false;

  @override
  void dispose() {
    Loader.hide();
    super.dispose();
  }

  bool status = false;

  @override
  Widget build(BuildContext context) {
    LoginViewModal viewModel = Provider.of<LoginViewModal>(context);

    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          leading: GestureDetector(
              onTap: () {
                // Navigator
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          title: const Text(
            "Thaar",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
        ),
        body: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
            child: Container(
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                    reverse: true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/enternumber.jpg',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Get Started",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Visibility(
                            visible: showDialogBox,
                            child: const Align(
                              alignment: Alignment.center,
                              child: CircularProgressIndicator(),
                            )),
                        TextFormField(
                          maxLength: viewModel.numberlimit,
                          autofocus: true,
                          controller: viewModel.phoneController,
                          onChanged: viewModel.onChanged,
                          cursorHeight: 20,
                          cursorColor: Constants.cursorColor,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              width: 2.5,
                              color: Constants.textfieldborder,
                            )),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Constants.textfieldborder)),
                            hintText: "Phone Number",
                            enabled: !showDialogBox,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            child: RaisedButton(
                              color: viewModel.status
                                  ? Constants.btnBG
                                  : Constants.btninactive,
                              textColor: viewModel.status
                                  ? Constants.btntextinactive
                                  : Constants.btntextactive,
                              onPressed: () async {
                                print('$num');
                                if (!showDialogBox) {
                                  SystemChannels.textInput
                                      .invokeMethod('TextInput.hide');

                                  setState(() {
                                    showDialogBox = true;
                                  });
                                  if (viewModel.phoneController.text.length <
                                      viewModel.numberlimit) {
                                    setState(() {
                                      showDialogBox = false;
                                    });
                                    viewModel.numbererror();
                                  } else {
                                    viewModel.login(context);
                                  }
                                }
                              },
                              child: const Text(
                                "CONTINUE",
                                style: TextStyle(fontSize: 18),
                              ),
                            )),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                                onTap: () {},
                                child: const Text(
                                  "Terms & Conditions",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline),
                                )),
                            GestureDetector(
                                onTap: () {},
                                child: const Text(
                                  "Privacy Policy",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline),
                                )),
                          ],
                        )
                      ],
                    )))));
  }
}
