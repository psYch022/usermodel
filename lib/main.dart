import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thaartransport/auth/login.dart';
import 'package:thaartransport/auth/profile_pic.dart';
import 'package:thaartransport/components/life_cycle_event_handler.dart';
import 'package:thaartransport/screens/homepage.dart';
import 'package:thaartransport/screens/splashscreen.dart';
import 'package:thaartransport/services/userservice.dart';
import 'package:thaartransport/utils/config.dart';
import 'package:thaartransport/utils/constants.dart';
import 'package:thaartransport/utils/providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Config.initFirebase();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(
      LifecycleEventHandler(
        detachedCallBack: () => UserService().setUserStatus(false),
        resumeCallBack: () => UserService().setUserStatus(true),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: providers,
        child: MaterialApp(
            title: Constants.appName,
            debugShowCheckedModeBanner: false,
            theme: Constants.lightTheme,
            home: StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
                  if (snapshot.hasData) {
                    return HomePage();
                  } else {
                    return SplashScreen();
                  }
                })));
  }
}
