// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:thaartransport/screens/kyc/vierficationkyc.dart';
import 'package:thaartransport/utils/constants.dart';

class AddressProof extends StatefulWidget {
  const AddressProof({Key? key}) : super(key: key);

  @override
  _AddressProofState createState() => _AddressProofState();
}

class _AddressProofState extends State<AddressProof> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: appBar(), body: _body());
  }

  AppBar appBar() {
    return AppBar(
      title: Text("Boss account KYC"),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 40,
          color: Colors.grey[300],
          alignment: Alignment.center,
          child: Text("Submit documents for Ravi"),
        ),
        form()
      ],
    ));
  }

  Padding form() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'One Address Proof',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          const Text(
            'upload one of the following document',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          card('Driving License', 'route'),
          SizedBox(
            height: height * 0.01,
          ),
          card('Aadhaar Card', 'route'),
          SizedBox(
            height: height * 0.01,
          ),
          card('Ration Card', 'route'),
          SizedBox(
            height: height * 0.01,
          ),
          card('Voter ID', 'route'),
          SizedBox(
            height: height * 0.01,
          ),
          card('Electricity Bill', 'route'),
          SizedBox(
            height: height * 0.01,
          ),
          card('Company GST Certificate', 'route'),
          SizedBox(
            height: height * 0.03,
          ),
          const Text(
            "ID Proof",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const Text("PAN card needed for ID proof"),
          SizedBox(
            height: height * 0.01,
          ),
          card('PAN Card', 'route'),
          SizedBox(
            height: height * 0.02,
          ),
          const Text(
            "Thaar account user's Selfie",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: height * 0.001,
          ),
          const Text(
            "Click a photo from this phone",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Card(
            child: Container(
              width: width,
              padding: EdgeInsets.only(left: 10),
              alignment: Alignment.centerLeft,
              height: 45,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Thaar account user's Selfie"),
                  Container(
                    child: Row(
                      children: [Text('Click Selfie'), Icon(Icons.camera_alt)],
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: height * 0.01),
          Container(
              // alignment: Alignment.center,
              height: 45,
              child: Row(
                children: [
                  Column(
                    children: [Icon(Icons.error)],
                  ),
                  SizedBox(
                    width: width * 0.02,
                  ),
                  Flexible(
                      child: Column(
                    children: const [
                      Text(
                        "Make sure to click a photo from this phone's camera. You cannot upload a photo from the phone gallery.",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 12),
                      )
                    ],
                  ))
                ],
              )),
          SizedBox(
            height: height * 0.02,
          )
        ],
      ),
    );
  }

  Widget card(String title, route) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => route));
        },
        child: Card(
          child: Container(
            width: width,
            padding: EdgeInsets.only(left: 10),
            alignment: Alignment.centerLeft,
            height: 45,
            child: Text(title),
          ),
        ));
  }
}
