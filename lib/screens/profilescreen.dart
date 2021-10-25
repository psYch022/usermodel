import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:thaartransport/Utils/firebase.dart';
import 'package:thaartransport/modal/usermodal.dart';
import 'package:thaartransport/screens/homepage.dart';
import 'package:thaartransport/screens/kyc/kycverfied.dart';
import 'package:thaartransport/screens/profile/editprofile.dart';
import 'package:thaartransport/services/userservice.dart';
import 'package:thaartransport/widget/cached_image.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Stream<DocumentSnapshot> stream;

  void initState() {
    stream = usersRef.doc(UserService().currentUid()).snapshots();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    double height = MediaQuery.of(context).size.height;
    return StreamBuilder<DocumentSnapshot>(
        stream: stream,
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Scaffold(body: Text("Somthing went Wrong"));
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(body: Center(child: Text("Loading...")));
          }

          UserModel user =
              UserModel.fromJson(snapshot.data!.data() as Map<String, dynamic>);
          return Scaffold(
              appBar: appBar(user),
              body: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          user.companyname!.toUpperCase(),
                          style: GoogleFonts.lato(
                              textStyle: const TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                height: 100,
                                width: 100,
                                child: cachedNetworkImage(
                                  user.photourl!,
                                )),
                            SizedBox(
                              width: width * 0.03,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                Text(
                                  user.username!.toUpperCase(),
                                  style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 22),
                                ),
                                Text(" " + user.usernumber!.substring(3),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 22)),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                Text(
                                  user.location!.toUpperCase(),
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                Text(user.role!,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        VerifyContainer(),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        container(),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  )));
        });
  }

  AppBar appBar(user) {
    return AppBar(
      elevation: 0.0,
      title: const Text(
        "My Profile",
        style: TextStyle(),
      ),
      centerTitle: true,
      actions: [
        Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
                splashRadius: 20,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditProfile(user: user)));
                },
                icon: const Icon(
                  Icons.edit,
                  color: Colors.white,
                )))
      ],
    );
  }

  // Widget profile(BuildContext context) {
  //   double width = MediaQuery.of(context).size.width;

  //   double height = MediaQuery.of(context).size.height;

  //   return StreamBuilder<DocumentSnapshot>(
  //       stream: usersRef.doc(UserService().currentUid()).snapshots(),
  //       builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
  //         if (snapshot.hasError) {
  //           return const Scaffold(body: Text("Somthing went Wrong"));
  //         } else if (snapshot.connectionState == ConnectionState.waiting) {
  //           return const Scaffold(body: Center(child: Text("Loading...")));
  //         }

  //         UserModel user =
  //             UserModel.fromJson(snapshot.data!.data() as Map<String, dynamic>);

  //         return Padding(
  //             padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
  //             child: SingleChildScrollView(
  //               child: Column(
  //                 children: [
  //                   Text(
  //                     user.companyname!.toUpperCase(),
  //                     style: GoogleFonts.lato(
  //                         textStyle: const TextStyle(
  //                             fontSize: 30, fontWeight: FontWeight.bold)),
  //                   ),
  //                   SizedBox(
  //                     height: height * 0.01,
  //                   ),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.start,
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Container(
  //                           height: 100,
  //                           width: 100,
  //                           child: cachedNetworkImage(
  //                             user.photourl!,
  //                           )),
  //                       SizedBox(
  //                         width: width * 0.03,
  //                       ),
  //                       Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           SizedBox(
  //                             height: height * 0.02,
  //                           ),
  //                           Text(
  //                             user.username!.toUpperCase(),
  //                             style: GoogleFonts.roboto(
  //                                 fontWeight: FontWeight.normal, fontSize: 22),
  //                           ),
  //                           Text(" " + user.usernumber!.substring(3),
  //                               style: TextStyle(
  //                                   fontWeight: FontWeight.normal,
  //                                   fontSize: 22)),
  //                           SizedBox(
  //                             height: height * 0.02,
  //                           ),
  //                           Text(
  //                             user.location!.toUpperCase(),
  //                             style: const TextStyle(
  //                                 fontSize: 15, fontWeight: FontWeight.w500),
  //                           ),
  //                           SizedBox(
  //                             height: height * 0.01,
  //                           ),
  //                           Text(user.role!,
  //                               style: const TextStyle(
  //                                 fontSize: 15,
  //                                 fontWeight: FontWeight.w500,
  //                               )),
  //                         ],
  //                       )
  //                     ],
  //                   ),
  //                   SizedBox(
  //                     height: height * 0.03,
  //                   ),
  //                   VerifyContainer(),
  //                   SizedBox(
  //                     height: height * 0.03,
  //                   ),
  //                   container(),
  //                   const SizedBox(
  //                     height: 20,
  //                   ),
  //                 ],
  //               ),
  //             ));
  //       });
  // }

  Widget VerifyContainer() {
    return InkWell(
        onTap: () {
          // Navigator.pushNamed(context, PageRoutes.kycverified);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => KycVerified()));
        },
        child: Container(
            height: 120,
            color: Colors.brown[100],
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Complete your KYC and become"),
                      RichText(
                          text: const TextSpan(
                              text: "a",
                              style: TextStyle(
                                  color: Colors.black45, fontSize: 15),
                              children: [
                            TextSpan(
                              text: " VERIFIED BUSINESS",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                  fontSize: 16),
                            )
                          ])),
                      Container(
                        height: 30,
                        width: 130,
                        color: Colors.blue[900],
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "Proceed KYC",
                              style: TextStyle(color: Colors.white),
                            ),
                            Icon(
                              Icons.double_arrow,
                              color: Colors.white24,
                              size: 15,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 70,
                    height: 70,
                    child: Image.asset("assets/images/phone.jpg"),
                  )
                ],
              ),
            )));
  }

  Widget container() {
    return Material(
        elevation: 10,
        child: Container(
          // height: 10,
          decoration: BoxDecoration(border: Border.all(color: Colors.white)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                'assets/images/download.jpg',
                width: 80,
                height: 80,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Profile Looks",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Text("empty!",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 250,
                    height: 40,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.blue)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.add),
                        Text("Add Company Bio")
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              )
            ],
          ),
        ));
  }
}
