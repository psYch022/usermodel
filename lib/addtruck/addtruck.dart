// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, unused_local_variable, prefer_function_declarations_over_variables

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thaartransport/Utils/constants.dart';
import 'package:thaartransport/Utils/controllers.dart';
import 'package:thaartransport/Utils/firebase.dart';

import 'package:dotted_border/dotted_border.dart';
import 'package:thaartransport/addtruck/validations.dart';
import 'package:thaartransport/services/userservice.dart';

class AddTruck extends StatefulWidget {
  const AddTruck({Key? key}) : super(key: key);

  @override
  _AddTruckState createState() => _AddTruckState();
}

class _AddTruckState extends State<AddTruck> {
  bool showDoc = false;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  void initState() {
    // getsearchCity().then(updateCurrentCity);
    currentcity.clear();
  }

  var id = truckRef.doc().id.toString();
  String imgUrl1 = '';
  String imgUrl2 = '';
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.btntextactive,
        title: Text("Add New"),
      ),
      body: Padding(
          padding: EdgeInsets.only(left: 15, right: 15, top: height * 0.04),
          child: Container(
              child: SingleChildScrollView(
            reverse: true,
            child: Column(
              children: [
                _BuildTextField(),
                SizedBox(
                  height: height * 0.06,
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                documentField()
              ],
            ),
          ))),
    );
  }

  Widget _BuildTextField() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Form(
      key: formkey,
      child: Column(
        children: [
          TextFormField(
            initialValue: searchcity.text,
            onTap: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => CurrentCity()));
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Current City',
                hintText: 'Search source city',
                labelStyle: TextStyle(color: Colors.black),
                hintStyle: TextStyle(color: Colors.black26)),
            validator: (value) {
              if (value!.isEmpty) {
                return 'EnterCity, Eg. Mumbai';
              }
              return null;
            },
          ),
          SizedBox(
            height: height * 0.03,
          ),
          TextFormField(
              controller: lorry,
              maxLength: 10,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Lorry Number',
                hintText: 'KA 10 AE 5555',
                labelStyle: TextStyle(color: Colors.black),
                hintStyle: TextStyle(color: Colors.black26),
              ),
              validator: Validations.validateNumber),
          SizedBox(
            height: height * 0.03,
          ),
          TextFormField(
              controller: capacity,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "In Tonne(S)",
                  labelText: 'Capacity',
                  labelStyle: TextStyle(color: Colors.black),
                  hintStyle: TextStyle(color: Colors.black26)),
              validator: (value) {
                if (value!.isEmpty || value == '') {
                  return 'Please enter the capacity';
                } else if (int.parse(value) > 100) {
                  return 'Capacity more than 100 tonnes is not allowed';
                }
              }),
        ],
      ),
    );
  }

  Widget documentField() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return DottedBorder(
        color: Colors.blue,
        child: InkWell(
          onTap: () async {
            final isValid = formkey.currentState!.validate();
            if (!isValid) {
              return;
            }
            formkey.currentState!.save();
            dialog();
          },
          child: Container(
              height: height * 0.06,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add),
                  SizedBox(
                    width: width * 0.02,
                  ),
                  Text(
                    "Upload Documents",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              )),
        ));
  }

  Future dialog() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
                title: const Text("Are you sure?"),
                content: const Text("Do you want to  process further"),
                actions: [
                  FlatButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text("No")),
                  FlatButton(
                      onPressed: () async {
                        Map<String, dynamic> data = {
                          'city': searchcity.text.split(',')[0],
                          'state': searchcity.text.split(',')[1],
                          'country': searchcity.text.split(',')[2],
                          'lorrynumber': lorry.text.toUpperCase(),
                          'capacity': capacity.text,
                          'ownerid': UserService().currentUid(),
                          'truckpostid': id,
                          'usernumber': UserService().currentNumber()
                        };
                        await truckRef.doc(id).set(data);

                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => UploadRC(
                        //               id,
                        //               lorry.text,
                        //             )));
                      },
                      child: const Text("Yes"))
                ]));
  }

  void updateCurrentCity(String searchCity) {
    setState(() {
      currentcity.text = searchCity;
    });
  }
}
