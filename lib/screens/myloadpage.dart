import 'package:flutter/material.dart';
import 'package:thaartransport/Test/textfield.dart';
import 'package:thaartransport/addnewload/PostLoad.dart';
import 'package:thaartransport/services/userservice.dart';
import 'package:thaartransport/utils/constants.dart';

class MyLoadPage extends StatefulWidget {
  const MyLoadPage({Key? key}) : super(key: key);

  @override
  _MyLoadPageState createState() => _MyLoadPageState();
}

class _MyLoadPageState extends State<MyLoadPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [loadbutton(), filter()],
      ),
    );
  }

  Widget loadbutton() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
      child: RaisedButton(
          color: Constants.btnBG,
          onPressed: () async {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => PostLoad()));
          },
          child: Container(
              height: 45,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Post a new load",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  Icon(Icons.arrow_forward_ios, size: 18, color: Colors.white)
                ],
              ))),
    );
  }

  Widget filter() {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                UserService().countNumber.toString(),
                // "Loads($UserService().)",
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
              ),
              InkWell(
                  onTap: () {
                    // _showModalSheet(context);
                  },
                  child: const Icon(
                    Icons.filter_list,
                  ))
            ],
          )
        ]));
  }
}
