import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:thaartransport/Utils/constants.dart';
import 'package:thaartransport/Utils/firebase.dart';
import 'package:thaartransport/auth/register_view_modal.dart';
import 'package:thaartransport/services/userservice.dart';

class UserRegistration extends StatefulWidget {
  const UserRegistration({Key? key}) : super(key: key);

  @override
  _UserRegistrationState createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  var isLoading = true;

  final _city = TextEditingController();
  final _name = TextEditingController();
  final _companyName = TextEditingController();
  String select = 'Shipper';
  late String? title;
  @override
  Widget build(BuildContext context) {
    RegisterViewModel registerViewModel =
        Provider.of<RegisterViewModel>(context, listen: false);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Profile'),
      ),
      body: Padding(
          padding:
              const EdgeInsets.only(top: 30, left: 10, right: 10, bottom: 10),
          child: Container(
            width: width,
            child: SingleChildScrollView(
              reverse: true,
              child: Form(
                key: registerViewModel.formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.03,
                    ),
                    TextFormField(
                      controller: _name,
                      decoration: InputDecoration(
                          labelText: "Your Name",
                          hintText: "Enter Your Name",
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Constants.textfieldborder,
                                  width: 2.5)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2.5,
                                  color: Constants.textfieldborder))),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Please Enter Your Name';
                        }
                        return null;
                      },
                      onChanged: registerViewModel.setName,
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    TextFormField(
                      controller: _companyName,
                      decoration: InputDecoration(
                          labelText: "Company Name",
                          hintText: "Enter Company Name",
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Constants.textfieldborder,
                                  width: 2.5)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2.5,
                                  color: Constants.textfieldborder))),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Enter the company name';
                        }
                        return null;
                      },
                      onChanged: registerViewModel.setCompanyName,
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    TextFormField(
                      onTap: () {},
                      controller: _city,
                      decoration: InputDecoration(
                          labelText: 'City',
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Constants.textfieldborder,
                                  width: 2.5)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2.5,
                                  color: Constants.textfieldborder))),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Select your city';
                        }
                        return null;
                      },
                      onChanged: registerViewModel.setlocation,
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    container(
                        "Shipper",
                        "I transport goods and I am looking for trucks",
                        'assets/images/logo.png'),
                    const SizedBox(
                      height: 20,
                    ),
                    container("Truck Owner", "I have trucks for transportation",
                        'assets/images/logo.png'),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          )),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: FloatingActionButton.extended(
            backgroundColor: Constants.btnBG,
            shape: Border(),
            label: Container(
                alignment: Alignment.center,
                width: width,
                child: const Text(
                  "Save Changes",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                )),
            onPressed: () async {
              registerViewModel.setrole(title);
              registerViewModel.register(context);
            },
          )),
    );
  }

  Widget container(String title, String status, String img) {
    return InkWell(
        onTap: () {
          selectDate(title);
          this.title = title;
        },
        child: Container(
            height: 100,
            decoration: BoxDecoration(
                color: switchColor(title),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 1,
                      offset: Offset(6, 8),
                      blurRadius: 7)
                ],
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title,
                              style:
                                  TextStyle(color: switchContentColor(title))),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            status,
                            style: TextStyle(color: switchContentColor(title)),
                          )
                        ],
                      ),
                    ),
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(img),
                    )
                  ],
                ),
              ],
            )));
  }

  Color switchColor(title) {
    if (title == select) {
      return Colors.blue.withOpacity(0.8);
    } else {
      return Colors.white.withOpacity(0.2);
    }
  }

  Color switchContentColor(title) {
    if (title == select) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  selectDate(date) {
    setState(() {
      select = date;
    });
  }
}
