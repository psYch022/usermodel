// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:thaartransport/modal/usermodal.dart';
import 'package:thaartransport/screens/myloadpage.dart';
import 'package:thaartransport/screens/profilescreen.dart';
import 'package:thaartransport/screens/sidebar.dart';
import 'package:thaartransport/services/userservice.dart';
import 'package:thaartransport/utils/constants.dart';
import 'package:thaartransport/utils/firebase.dart';
import 'package:thaartransport/widget/cached_image.dart';
import 'package:line_icons/line_icons.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final tabs = [
    MyLoadPage(),
    Text('data2'),
    Text('data3'),
    const Text(
      "R",
      style: TextStyle(fontSize: 70),
    ),
  ];
  late Stream<DocumentSnapshot> stream;

  void initState() {
    stream = usersRef.doc(UserService().currentUid()).snapshots();
  }

  @override
  Widget build(BuildContext context) {
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
              appBar: AppBar(
                elevation: 0.0,
                backgroundColor: Colors.white,
                leading: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileScreen()));
                    },
                    child: Container(
                        margin: const EdgeInsets.all(5),
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15)),
                        child: Image.network(
                          user.photourl!,
                          fit: BoxFit.cover,
                        ))),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.username!,
                      style: TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Container(
                      width: 100,
                      alignment: Alignment.center,
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.red)),
                      child: const Text(
                        "KYC PENDING",
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    )
                  ],
                ),
                actions: [
                  IconButton(
                      splashRadius: 20,
                      onPressed: () {
                        //To DO
                      },
                      icon: const Icon(Icons.headphones),
                      color: Colors.black),
                  IconButton(
                      splashRadius: 20,
                      onPressed: () {},
                      icon: const Icon(Icons.notifications),
                      color: Colors.black),
                  IconButton(
                    splashRadius: 20,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SideBar()));
                    },
                    color: Colors.black,
                    icon: const Icon(Icons.menu),
                  ),
                ],
              ),
              body: tabs[_selectedIndex],
              bottomNavigationBar: Container(
                decoration: BoxDecoration(
                  color: Constants.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20,
                      color: Colors.black.withOpacity(.1),
                    )
                  ],
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 8),
                    child: GNav(
                      hoverColor: Constants.bnbhover,
                      gap: 8,
                      activeColor: Constants.white,
                      iconSize: 24,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      duration: const Duration(milliseconds: 400),
                      tabBackgroundColor: Constants.bnbhover,
                      color: Colors.black,
                      tabs: const [
                        GButton(
                          icon: LineIcons.home,
                          text: 'My Load',
                        ),
                        GButton(
                          icon: LineIcons.truck,
                          text: 'My Lorry',
                        ),
                        GButton(
                          icon: LineIcons.search,
                          text: 'Market',
                        ),
                        GButton(
                          icon: LineIcons.user,
                          text: 'Netwok',
                        ),
                      ],
                      selectedIndex: _selectedIndex,
                      onTabChange: (index) {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                    ),
                  ),
                ),
              ));
        });
  }

  // StreamBuilder appBar(context) {
  //   return StreamBuilder(
  //       stream: usersRef.doc(UserService().currentUid()).snapshots(),
  //       builder: (context, snapshot) {
  //         if (snapshot.hasData) {
  //           UserModel user = UserModel.fromJson(snapshot.data.data());
  //           return
  //         }
  //       });
  // }
}
