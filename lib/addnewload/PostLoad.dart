// ignore: file_names
// ignore_for_file: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thaartransport/Utils/constants.dart';
import 'package:thaartransport/Utils/firebase.dart';
import 'package:thaartransport/addnewload/destination.dart';
import 'package:thaartransport/addnewload/source.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:thaartransport/screens/homepage.dart';
import 'package:thaartransport/services/uploadload.dart';
import 'package:thaartransport/utils/controllers.dart';

import 'paymentdetails.dart';

class PostLoad extends StatefulWidget {
  const PostLoad({Key? key}) : super(key: key);

  @override
  _PostLoadState createState() => _PostLoadState();
}

class _PostLoadState extends State<PostLoad> {
  final _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool validate = false;
  bool loading = false;
  String _selectedItem = '';
  String group = '';
  void initState() {
    getSource().then(updateSource);
    getDes().then(updateDestination);
  }

  void dispose() {}

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: appBar(),
      body: WillPopScope(
          onWillPop: () async {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
            source.clear();
            destination.clear();
            controller3.clear();
            controller4.clear();

            return true;
          },
          child: Container(
              child: SingleChildScrollView(
            reverse: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.04,
                ),
                documentField(),
                SizedBox(
                  height: height * 0.09,
                ),
              ],
            ),
          ))),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: FloatingActionButton.extended(
              backgroundColor: Constants.btnBG,
              shape: Border(),
              label: Container(
                  alignment: Alignment.center,
                  width: width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("Next",
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                      Icon(
                        Icons.keyboard_arrow_right_outlined,
                        color: Colors.white,
                      ),
                    ],
                  )),
              onPressed: () async {
                FormState? form = _formKey.currentState;
                form!.save();
                if (!form.validate()) {
                  validate = true;

                  showInSnackBar(
                      'Please fix the errors in red before submitting.',
                      context);
                } else {
                  try {
                    loading = true;
                    await LoadService.uploadload(source.text, destination.text,
                        controller3.text, controller4.text);
                    loading = false;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PaymentDetails()));
                  } catch (e) {
                    print(e);
                    loading = false;

                    showInSnackBar('Uploaded successfully!', context);
                  }
                }
              })),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: Constants.btntextactive,
      title: const Text("Post Load"),
      centerTitle: false,
    );
  }

  Widget heading() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
        padding: const EdgeInsets.only(left: 10),
        color: Colors.grey[200],
        height: height * 0.05,
        child: Row(
          children: [
            const Icon(
              Icons.ac_unit,
              size: 18,
            ),
            SizedBox(
              width: width * 0.03,
            ),
            const Text(
              "Load Details",
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
            ),
          ],
        ));
  }

  Widget documentField() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  textInputAction: TextInputAction.next,
                  initialValue: source.text,
                  // controller: controller1,
                  readOnly: true,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SourceLocation()));
                  },

                  cursorColor: Constants.cursorColor,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(13),
                    isDense: true,
                    hintText: 'Source Location',
                    labelText: 'Source Location',
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      width: 2.5,
                      color: Constants.textfieldborder,
                    )),
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Constants.textfieldborder)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter Source, Eg. Mumbai';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  initialValue: destination.text,
                  // controller: controller2,
                  readOnly: true,
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Destination()));
                  },

                  cursorColor: Constants.cursorColor,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(13),
                    isDense: true,
                    hintText: "Destination",
                    labelText: 'Destination',
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Constants.textfieldborder)),
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Constants.textfieldborder)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter Destination, Eg. Bangalore';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: controller3,
                  cursorColor: Constants.cursorColor,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(13),
                      isDense: true,
                      hintText: "Material",
                      labelText: 'Material',
                      labelStyle: TextStyle(color: Colors.black),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Constants.textfieldborder)),
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Constants.textfieldborder),
                      )),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter material, Eg. Steel';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                TextFormField(
                    controller: quantity,
                    minLines: 1,
                    keyboardType: TextInputType.number,
                    maxLength: 25,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(13),
                        isDense: true,
                        labelText: "Quanity",
                        labelStyle: TextStyle(color: Colors.black),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Constants.textfieldborder)),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Constants.textfieldborder))),
                    validator: (value) {
                      if (value!.isEmpty || value == '') {
                        return 'Please Enter Quantity';
                      } else if (int.parse(value) > 100) {
                        return 'Please Enter Quantity under 100';
                      }
                    }),
                SizedBox(
                  height: height * 0.03,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: controller4,
                  readOnly: true,
                  cursorColor: Constants.cursorColor,
                  onTap: () {
                    _onButtonPressed();
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(13),
                    isDense: true,
                    hintText: "price unit",
                    labelText: 'Price Unit',
                    labelStyle: TextStyle(color: Colors.black),
                    suffixIcon: const Icon(
                      Icons.keyboard_arrow_right_outlined,
                      color: Colors.black,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Constants.textfieldborder)),
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Constants.textfieldborder)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please select any one';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                TextFormField(
                  controller: priceController,
                  minLines: 1,
                  keyboardType: TextInputType.number,
                  maxLength: 25,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(13),
                      isDense: true,
                      labelText: "Expected Price (Optional)",
                      labelStyle: TextStyle(color: Colors.black),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Constants.textfieldborder)),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Constants.textfieldborder))),
                ),
              ],
            )));
  }

  // for price unit bottom sheet value

  _onButtonPressed() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            height: 250,
            child: Container(
              child: _buildBottomNavigationMenu(),
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
            ),
          );
        });
  }

  Column _buildBottomNavigationMenu() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const SizedBox(
          height: 5,
        ),
        Center(
            child: Container(
                height: 3.0, width: 40.0, color: const Color(0xFF32335C))),
        const SizedBox(
          height: 30,
        ),
        Container(
            margin: EdgeInsets.only(left: 15),
            child: const Text("Select your price Unit",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ))),
        RadioListTile(
          title: Text("Fixed price"),
          value: 'fixed price',
          groupValue: group,
          onChanged: (value) {
            group = value as String;
            Navigator.pop(context);
            controller4.text = value;
          },
        ),
        RadioListTile(
          title: Text("Tonne"),
          value: 'tonne',
          groupValue: group,
          onChanged: (value) {
            group = value as String;
            controller4.text = value;
            Navigator.pop(context);
          },
        )
      ],
    );
  }

  // for paymentoption

  // To get the source Address
  void updateSource(String name1) {
    setState(() {
      controller1.text = name1;
    });
  }

// To get the Destination Address
  void updateDestination(String des) {
    setState(() {
      controller2.text = des;
    });
  }

  void showInSnackBar(String value, context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
  }

// To pass the all controller value on nextPage(PaymentDetails)

}
