// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thaartransport/Utils/constants.dart';
import 'package:thaartransport/addnewload/PostLoad.dart';
import 'package:thaartransport/addnewload/odc.dart';
import 'package:thaartransport/utils/controllers.dart';

class PaymentDetails extends StatefulWidget {
  const PaymentDetails({Key? key}) : super(key: key);

  @override
  _PaymentDetailsState createState() => _PaymentDetailsState();
}

class _PaymentDetailsState extends State<PaymentDetails> {
  String select = '';
  String option = '';
  String selectedValue = '';
  String price = '';
  void initState() {
    // getSocAdd().then(updateSocAdd);
    // getDesAdd().then(updateDesAdd);
    // getMaterial().then(updateMaterial);
    // getQuantity().then(updateQuantity);
  }

  String _sourceAdd = "";
  String _destAdd = "";
  String _material = "";
  String _quantity = "";

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 5),
        child: Container(
            height: height,
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //....widget1...
                  heading(),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  //...widget2...
                  addNewLoad(),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  const Text("2. PAYMENT DETAILS"),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  TextFormField(
                    controller: priceController,
                    minLines: 1,
                    keyboardType: TextInputType.number,
                    maxLength: 25,
                    decoration: const InputDecoration(
                        labelText: "Expected Price (Optional)"),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  //...widget3...
                  Row(
                    children: [
                      Optional('Fixed Price'),
                      const SizedBox(
                        width: 25,
                      ),
                      Optional('Per Tonne')
                    ],
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  const Text("Payment Mode"),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  radio(),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  //...widget 4...
                  button()
                ],
              ),
            )),
      )),
    );
  }

  Widget heading() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Add New Load",
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20)),
        InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const CircleAvatar(
              backgroundColor: Colors.black38,
              radius: 15,
              child: Icon(
                Icons.close,
                color: Colors.white,
              ),
            ))
      ],
    );
  }

  Widget addNewLoad() {
    return Card(
      elevation: 10,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(left: 10, right: 10),
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: 40,
                alignment: Alignment.center,
                color: Colors.grey[200],
                child: Text("1. LOAD DETAILS")),
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

  Widget radio() {
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              selectedValue = 'To be Billed';
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("To be Billed"),
              Radio(
                  value: 'To be Billed',
                  groupValue: selectedValue,
                  onChanged: (value) => setState(() {
                        selectedValue = value as String;
                      }))
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        InkWell(
            onTap: () {
              setState(() {
                selectedValue = 'To Pay';
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("To Pay"),
                Radio(
                    value: 'To Pay',
                    groupValue: selectedValue,
                    onChanged: (value) => setState(() {
                          selectedValue = value as String;
                        }))
              ],
            ))
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
            color: Constants.white,
            shape: const RoundedRectangleBorder(
                side: BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                )),
            onPressed: () async {
              Navigator.pop(context);
              SharedPreferences pref = await SharedPreferences.getInstance();
              await pref.clear();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.keyboard_arrow_left,
                  color: Colors.black,
                  size: 20,
                ),
                Text(
                  "Back",
                  style: TextStyle(color: Colors.black, fontSize: 20),
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
              if (selectedValue == '') {
                Fluttertoast.showToast(
                    msg: "Please select the Payment Mode",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.grey,
                    textColor: Colors.white,
                    fontSize: 16.0);
              } else if (priceController.text.isNotEmpty && option.isEmpty) {
                Fluttertoast.showToast(
                    msg: "Please select the Payment Option",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.cyan,
                    textColor: Colors.white,
                    fontSize: 16.0);
              } else {
                saveValue();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ODCScreen()));
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Next",
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

  Widget Optional(String option) {
    return InkWell(
        onTap: () {
          selectMethod(option);
          this.option = option;
        },
        child: Container(
          height: 30,
          width: 100,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: switchContainer(option),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: switchBorder(option))),
          child: Text(
            option,
            style: TextStyle(color: switchContentColor(option)),
          ),
        ));
  }

// To change the background color while select one and this code implement in "Option widget" and ending with selectMethod
  Color switchBorder(option) {
    if (option == select) {
      return Colors.blue.withOpacity(0.8);
    } else {
      return Colors.white.withOpacity(0.2);
    }
  }

  Color switchContentColor(option) {
    if (option == select) {
      return Colors.black87;
    } else {
      return Colors.black45;
    }
  }

  Color switchContainer(option) {
    if (option == select) {
      return Colors.black12;
    } else {
      return Colors.white;
    }
  }

  selectMethod(method) {
    setState(() {
      select = method;
    });
  }

// To update the value, getting from PostLoad screen and this code implement in "AddNewLoad Widget"
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

  // To pass the radio button value and Expected price value on nextPage "ODCScreen"
  saveValue() {
    String selected = selectedValue.toString();

    String price = priceController.text;
    String optionPrice = option.toString();
    savePaymentValue(selected, price, optionPrice).then((bool commited) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ODCScreen()));
    });
  }
}

Future<bool> savePaymentValue(
    String selected, String price, String optionPrice) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("selected", selected);
  prefs.setString("price", price);
  prefs.setString("optionPrice", optionPrice);
  return prefs.commit();
}

Future<String> getRadioValue() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String selected = prefs.getString("selected").toString();
  return selected;
}

Future<String> getPrice() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String price = prefs.getString("price").toString();
  return price;
}

Future<String> getoptionPrice() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String optionPrice = prefs.getString("optionPrice").toString();
  return optionPrice;
}
