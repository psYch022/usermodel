import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:thaartransport/Utils/constants.dart';
import 'package:thaartransport/services/auth_service.dart';

class SideBar extends StatefulWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Menu"),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                    onTap: () {
                      // Navigator.pushNamed(context, PageRoutes.kycverified);
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => KycVerified()));
                    },
                    child: Container(
                      color: Colors.blueGrey,
                      // padding: EdgeInsets.all(5),
                      width: width,
                      height: height * 0.2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              width: width * 0.7,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                      text: const TextSpan(
                                          text:
                                              "Complete your KYC and become a",
                                          style: TextStyle(color: Colors.black),
                                          children: [
                                        TextSpan(
                                            text: "VERIFIED BUSINESS",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                color: Colors.black,
                                                fontSize: 20))
                                      ])),
                                  Container(
                                    width: 200,
                                    color: Colors.purple,
                                    height: 40,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          "Processed KYC",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Icon(
                                          Icons.keyboard_arrow_right_sharp,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )),
                          Image.asset(
                            'assets/images/phone.jpg',
                            height: 80,
                            width: 80,
                          )
                        ],
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),
                const ListTile(
                  leading: Icon(Icons.contact_support),
                  title: Text("Help Guide"),
                  subtitle:
                      Text("A help guide for your to get loads & lorries"),
                ),
                const ListTile(
                  leading: Icon(Icons.settings),
                  title: Text("Settings"),
                  subtitle: Text("Fine tune your Vahak experience"),
                ),
                const ListTile(
                  leading: Icon(Icons.star),
                  title: Text("Rate us on Playstore"),
                  subtitle: Text("We would love to hear from you"),
                ),
                const ListTile(
                  leading: Icon(Icons.speaker),
                  title: Text("Refer a Friend"),
                  subtitle:
                      Text("Invite your friennd through Facebook/ Whatsapp"),
                ),
                const ListTile(
                  leading: Icon(Icons.folder),
                  title: Text("Terms & Conditions"),
                  subtitle: Text("Read what you've signed"),
                ),
                const ListTile(
                  leading: Icon(Icons.privacy_tip),
                  title: Text("Privacy Policy"),
                  subtitle: Text("Compliance and regulations"),
                ),
                const ListTile(
                  leading: Icon(Icons.contact_support_sharp),
                  title: Text("Contact us"),
                  subtitle: Text("Facing an issue? We're there to help you"),
                ),
                RaisedButton(
                    onPressed: () async {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return buildSheet();
                          });
                    },
                    child: Container(
                        width: width,
                        alignment: Alignment.center,
                        child: Text("LogOut")))
              ],
            ),
          ),
        ));
  }

  Widget buildSheet() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 8,
            width: 50,
            decoration: BoxDecoration(
                color: Colors.grey[500],
                borderRadius: BorderRadius.circular(30)),
          ),
          const Text(
            "Are you sure",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text('Do you want to logout?'),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
                color: Colors.red,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'No',
                  style: TextStyle(color: Constants.white),
                ),
              ),
              RaisedButton(
                  color: Colors.red,
                  onPressed: () async {
                    AuthService().logOut(context);
                  },
                  child: Text(
                    "yes",
                    style: TextStyle(
                      color: Constants.white,
                    ),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
