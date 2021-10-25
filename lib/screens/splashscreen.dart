// ignore: file_names
// ignore_for_file: file_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thaartransport/screens/mainsceen/gettingstarted.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // startTime();
    Future.delayed(const Duration(seconds: 3), () {
      // Navigator.pushNamed(context, PageRoutes.gettingstarted);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => GettingStarted()),
          (route) => false);

      // Navigator.pushReplacementNamed(context, PageRoutes.gettingstarted);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: CircleAvatar(
        radius: 40,
        backgroundImage: AssetImage('assets/images/logo.png'),
      )),
    );
  }
}
