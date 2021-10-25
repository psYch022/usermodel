// ignore: file_names
// ignore_for_file: file_names
import 'package:flutter/material.dart';

class VerificationKyc extends StatefulWidget {
  const VerificationKyc({Key? key}) : super(key: key);

  @override
  _VerificationKycState createState() => _VerificationKycState();
}

class _VerificationKycState extends State<VerificationKyc> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
              height: 200,
              width: width,
              color: Colors.blueGrey[900],
              child: Padding(
                padding: EdgeInsets.only(top: 60, left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        )),
                    SizedBox(
                      height: 30,
                    ),
                    const Text("KYC Verification",
                        style: TextStyle(fontSize: 25, color: Colors.white))
                  ],
                ),
              )),
          const SizedBox(
            height: 20,
          ),
          Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                children: [
                  Container(
                    height: 100,
                    padding: EdgeInsets.only(left: 20, right: 20),
                    // color: Colors.red,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Enter Your Aadthaar Number",
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 20),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "You will receive an OTP on your registered mobile number for the given Aadhaar number.",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    // height: 200,

                    decoration: BoxDecoration(border: Border.all()),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          color: Colors.purple,
                          height: 100,
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              CircleAvatar(
                                radius: 30,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "15 digit GST Number \n xxxxxxxxxxxxxxx",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 50,
                          margin: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(border: Border.all()),
                          child: const Text("e.g. 12ABCDE345F7G8"),
                        ),
                      ],
                    ),
                  )
                ],
              )),
        ],
      ),
    ));
  }
}
