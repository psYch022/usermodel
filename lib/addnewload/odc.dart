// ignore_for_file: prefer_const_constructors, avoid_returning_null_for_void, unnecessary_this

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:thaartransport/Utils/constants.dart';
import 'package:thaartransport/Utils/controllers.dart';
import 'package:thaartransport/Utils/firebase.dart';
import 'package:thaartransport/addnewload/PostLoad.dart';
import 'package:thaartransport/addnewload/orderpostconfirmed.dart';
import 'package:thaartransport/addnewload/paymentdetails.dart';
import 'package:thaartransport/services/userservice.dart';

class ODCScreen extends StatefulWidget {
  const ODCScreen({Key? key}) : super(key: key);

  @override
  _ODCScreenState createState() => _ODCScreenState();
}

class _ODCScreenState extends State<ODCScreen> {
  bool isSelected = false;
  void initState() {
    // getSocAdd().then(updateSocAdd);
    // getDesAdd().then(updateDesAdd);
    // getMaterial().then(updateMaterial);
    // getQuantity().then(updateQuantity);
    getRadioValue().then(updateRadio);
    getPrice().then(updatePrice);
    getoptionPrice().then(updateoptionPrice);
  }

  String _sourceAdd = "";
  String _destAdd = "";
  String _material = "";
  String _quantity = "";
  String selectedRadio = "";
  String price = "";
  String optionPrice = "";

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SafeArea(
      child: Padding(
          padding:
              const EdgeInsets.only(left: 15, right: 15, bottom: 5, top: 5),
          child: Container(
            height: height,
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  addNewLoad(),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  PaymentDetails(),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  const Text.rich(TextSpan(
                      text: '3. ODC CONSIGNMENT & REMARKS',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      children: <InlineSpan>[
                        TextSpan(
                          text: '(Optional)',
                          style: TextStyle(color: Colors.black54),
                        ),
                      ])),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  ODCCons(),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  TextFormField(
                      minLines: 5,
                      controller: remarkController,
                      maxLines: 20,
                      maxLength: 100,
                      decoration: const InputDecoration(
                          hintText: 'Enter your post remarks here',
                          border: OutlineInputBorder())),
                  SizedBox(
                    height: height * 0.07,
                  ),
                  button()
                ],
              ),
            ),
          )),
    ));
  }

  Widget addNewLoad() {
    return Card(
      elevation: 10,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(10),
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("1. LOAD DETAILS"),
            const SizedBox(
              height: 15,
            ),
            Text('$_sourceAdd - $_destAdd'),
            const SizedBox(
              height: 10,
            ),
            Text("$_material, $_quantity (Tonns)")
          ],
        ),
      ),
    );
  }

  Widget PaymentDetails() {
    return Card(
      elevation: 10,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(10),
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("1. PAYMENT DETAILS"),
            Text.rich(
              TextSpan(
                  text: price + "/", children: [TextSpan(text: optionPrice)]),
            ),
            Row(
              children: [
                const Icon(
                  Icons.check_circle_outline_outlined,
                  color: Colors.blue,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(selectedRadio)
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget ODCCons() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("ODC CONSIGNMENT"),
            FlutterSwitch(
                value: isSelected,
                showOnOff: true,
                onToggle: (val) {
                  setState(() {
                    isSelected = val;
                  });
                })
          ],
        ),
        if (isSelected)
          Column(
            children: [
              TextField(
                controller: lengthController,
                textInputAction: TextInputAction.next,
                maxLength: 6,
                decoration:
                    InputDecoration(labelText: 'Length(L)', suffixText: "MTs"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                textInputAction: TextInputAction.next,
                controller: breadthController,
                maxLength: 6,
                decoration:
                    InputDecoration(labelText: 'Breadth(B)', suffixText: "MTs"),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                textInputAction: TextInputAction.next,
                controller: heightController,
                maxLength: 6,
                decoration:
                    InputDecoration(labelText: 'Height(H)', suffixText: "MTs"),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          )
      ],
    );
  }

  Widget button() {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
            child: Container(
          height: 50,
          child: RaisedButton(
            elevation: 10,
            color: Colors.white,
            highlightColor: Colors.grey,
            // focusColor: Colors.green,
            shape: const RoundedRectangleBorder(
                side: BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                )),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.keyboard_arrow_left,
                  // color: Colors.black,
                  size: 20,
                ),
                Text(
                  "Back",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        )),
        const SizedBox(
          width: 20,
        ),
        Flexible(
            child: Container(
          height: 50,
          child: RaisedButton(
            elevation: 10,
            color: Constants.btnBG,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
              Radius.circular(10),
            )),
            onPressed: () async {
              String id = postRef.doc().id;
              var currentTime = DateTime.now();
              var endTime = currentTime.add(Duration(minutes: 45));

              Map<String, dynamic> data = {
                'sourcecity': _sourceAdd.split(',')[0],
                'sourcestate': _sourceAdd.split(',')[1],
                'sourcecountry': _sourceAdd.split(',')[2],
                'destinationcity': _destAdd.split(',')[0],
                'destinationstate': _destAdd.split(',')[1],
                'destinationcountry': _destAdd.split(',')[2],
                'material': _material.toString(),
                'quantity': _quantity.toString(),
                'paymentmode': selectedRadio.toString(),
                'ownerid': UserService().currentUid(),
                'usernumber': UserService().currentNumber(),
                'postid': id,
                'length':
                    lengthController.text.isEmpty ? "" : lengthController.text,
                'breadth': breadthController.text.isEmpty
                    ? ""
                    : breadthController.text,
                'height':
                    heightController.text.isEmpty ? "" : heightController.text,
                'remarks':
                    remarkController.text.isEmpty ? "" : remarkController.text,
                'status': 'IsActive',
                'loadposttime': DateTime.now().toString(),
                'loadexpiretime': endTime.toString(),
                'expectedprice': price.isEmpty ? "" : price.toString(),
                'paymentoption':
                    optionPrice.isEmpty ? "" : optionPrice.toString(),
              };
              await postRef.doc(id).set(data);

              await CoolAlert.show(
                  context: context,
                  type: CoolAlertType.loading,
                  text: 'Load Posted Successfully \n Your post id: $id',
                  lottieAsset: 'assets/782-check-mark-success.json',
                  autoCloseDuration: Duration(seconds: 2),
                  // confirmBtnColor: Colors.green,
                  animType: CoolAlertAnimType.slideInUp,
                  // cancelBtnText: ,
                  title: 'Load Posted Successfully');

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OrderPostConfirmed(id)));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Post Load",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Icon(
                  Icons.keyboard_arrow_right,
                  size: 20,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ))
      ],
    ));
  }

  void updateSocAdd(
    String socAdd,
  ) {
    setState(() {
      this._sourceAdd = socAdd;
    });
  }

  void updateDesAdd(
    String desAdd,
  ) {
    setState(() {
      this._destAdd = desAdd;
    });
  }

  void updateMaterial(
    String material,
  ) {
    setState(() {
      this._material = material;
    });
  }

  void updateQuantity(
    String quantity,
  ) {
    setState(() {
      this._quantity = quantity;
    });
  }

  // To get the Radio Button Value
  void updateRadio(
    String selected,
  ) {
    setState(() {
      this.selectedRadio = selected;
    });
  }

  // To get the Expected price value
  void updatePrice(
    String price,
  ) {
    setState(() {
      this.price = price;
    });
  }

  // To get the Price option
  void updateoptionPrice(
    String optionPrice,
  ) {
    setState(() {
      this.optionPrice = optionPrice;
    });
  }
}
