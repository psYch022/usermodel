// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thaartransport/addnewload/paymentdetails.dart';
import 'package:thaartransport/services/post_service.dart';
import 'package:thaartransport/services/userservice.dart';
import 'package:thaartransport/services/uploadload.dart';

class PostLoadModal extends ChangeNotifier {
  //Services
  UserService userService = UserService();
  PostService postService = PostService();

  //Keys
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState>? formKey = GlobalKey<FormState>();
  //Variables
  bool validate = false;
  bool loading = false;
  final String _selectedItem = '';
  String group = '';
  String? breadth;
  String? destinationlocation;
  String? sourcelocation;

  String? expectedprice;

  String? height;
  String? postexpiretime;
  String? length;
  String? loadposttime;
  String? material;
  String? ownerid;
  String? paymentoption;
  String? priceunit;
  String? postid;
  String? quantity;
  //controllers
  // TextEditingController locationTEC = TextEditingController();
  TextEditingController Priceunit = TextEditingController();

  //Setters
  setsourcelocation(String val) {
    print('setsourcelocation $val');
    sourcelocation = val;
    notifyListeners();
  }

  setdestinationlocation(String val) {
    print('setdestinationlocation $val');
    destinationlocation = val;
    notifyListeners();
  }

  setmaterial(String val) {
    print('setMaterial $val');
    material = val;
    notifyListeners();
  }

  setpriceunit(String val) {
    print('setPriceunit $val');
    priceunit = val;
    notifyListeners();
  }

  void initState() {
    // formKey = GlobalKey<FormState>();
  }

  // uploadPosts(BuildContext context) async {
  //   FormState? form = formKey!.currentState;
  //   form!.save();
  //   if (!form.validate()) {
  //     validate = true;
  //     notifyListeners();
  //     showInSnackBar(
  //         'Please fix the errors in red before submitting.', context);
  //   } else {
  //     try {
  //       loading = true;
  //       notifyListeners();
  //       await LoadService.uploadload(
  //           sourcelocation, destinationlocation, material, priceunit);
  //       loading = false;
  //       Navigator.push(
  //           context, MaterialPageRoute(builder: (context) => PaymentDetails()));
  //       notifyListeners();
  //     } catch (e) {
  //       print(e);
  //       loading = false;
  //       // resetPost();
  //       showInSnackBar('Uploaded successfully!', context);
  //       notifyListeners();
  //     }
  //   }
  // }

  void showInSnackBar(String value, context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
  }

  void onButtonPressed(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            height: 250,
            child: Container(
              child: _buildBottomNavigationMenu(context),
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
    notifyListeners();
  }

  Column _buildBottomNavigationMenu(BuildContext context) {
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
            margin: const EdgeInsets.only(left: 15),
            child: const Text("Select your price Unit",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ))),
        RadioListTile(
          title: const Text("Fixed price"),
          value: 'fixed price',
          groupValue: group,
          onChanged: (value) {
            group = value as String;
            Navigator.pop(context);
            Priceunit.text = value;
            notifyListeners();
          },
        ),
        RadioListTile(
          title: Text("Tonne"),
          value: 'tonne',
          groupValue: group,
          onChanged: (value) {
            group = value as String;
            Priceunit.text = value;
            Navigator.pop(context);
            notifyListeners();
          },
        )
      ],
    );
  }
}
