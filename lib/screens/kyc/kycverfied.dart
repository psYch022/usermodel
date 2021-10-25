import 'package:flutter/material.dart';
import 'package:thaartransport/screens/kyc/accountkyc.dart';
import 'package:thaartransport/screens/kyc/vierficationkyc.dart';

class KycVerified extends StatefulWidget {
  const KycVerified({Key? key}) : super(key: key);

  @override
  _KycVerifiedState createState() => _KycVerifiedState();
}

class _KycVerifiedState extends State<KycVerified> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
      height: height,
      child: Column(
        children: [
          Container(
            height: 300,
            width: width,
            child: Stack(
              children: [
                Container(
                  child: Container(
                      alignment: Alignment.topLeft,
                      height: 250,
                      color: Colors.blueGrey[900],
                      padding: EdgeInsets.only(top: 50, left: 10),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back))),
                ),
                Container(
                  margin: EdgeInsets.only(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "Become a Verified Business",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.verified_rounded,
                            color: Colors.green,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Don't worry! Verfying is Quick & Paperless.",
                        style: TextStyle(color: Colors.white60),
                      )
                    ],
                  ),
                ),
                Positioned(
                    top: 200,
                    child: Container(
                        width: width,
                        alignment: Alignment.center,
                        child: const CircleAvatar(
                          radius: 40,
                          child: Icon(
                            Icons.security,
                            size: 50,
                          ),
                        )))
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 40,
                    color: Colors.orange,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.circle),
                        SizedBox(
                          width: 5,
                        ),
                        Text("ID details are needed for one-time verification.")
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text("KYC Benefits"),
                  const ListTile(
                    leading: Icon(Icons.verified),
                    title: Text("Get verified Business Tags"),
                  ),
                  const ListTile(
                    leading: Icon(Icons.verified),
                    title: Text("Get move Business Leads"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: RichText(
                      text: const TextSpan(
                          text: "By Proceding you agree",
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(
                                text: "Terms & Conditions",
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black,
                                    fontSize: 15))
                          ]),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        // Navigator.pushNamed(
                        //     context, PageRoutes.verificationkyc);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AccountKyc()));
                      },
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        child: Text("START KYC VERIFICATION"),
                      ))
                ],
              ))
        ],
      ),
    )));
  }
}
