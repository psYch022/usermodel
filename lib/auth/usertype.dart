// ignore: file_names
// ignore_for_file: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thaartransport/Utils/firebase.dart';
import 'package:thaartransport/screens/homepage.dart';
import 'package:thaartransport/services/userservice.dart';
// import 'package:thaartransport/Pages/enterprofiledetails.dart';

class UserType extends StatefulWidget {
  const UserType({Key? key}) : super(key: key);

  @override
  _UserTypeState createState() => _UserTypeState();
}

class _UserTypeState extends State<UserType> {
  String select = 'Shipper';
  late String? title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            Container(
              width: 100,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.call),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Call Us")
                ],
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
          child: ListView(children: [
            const Text(
              "What service do you provide?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("Select a profile that suits you the most"),
            const SizedBox(
              height: 20,
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
            container(
                "Shipper & Truck Owner",
                "I transport goods and have truck as well",
                'assets/images/logo.png'),
            const SizedBox(
              height: 50,
            ),
            RaisedButton(
              onPressed: () async {
                Map<String, dynamic> data = {'role': title.toString()};

                await usersRef.doc(UserService().currentUid()).update(data);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: const Text(
                  "CONFIRM",
                  style: TextStyle(),
                ),
              ),
            )
          ]),
        ));
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
