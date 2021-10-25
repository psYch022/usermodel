import 'package:flutter/material.dart';
import 'package:thaartransport/addnewload/destination.dart';
import 'package:thaartransport/addnewload/source.dart';
import 'package:thaartransport/utils/controllers.dart';

class TextFieldLoad extends StatefulWidget {
  const TextFieldLoad({Key? key}) : super(key: key);

  @override
  _TextFieldLoadState createState() => _TextFieldLoadState();
}

class _TextFieldLoadState extends State<TextFieldLoad> {
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  void initState() {
    getSource().then(updateSource);
    getDes().then(updateDestination);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextFormField(
            controller: controller1,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SourceLocation()));
            },
          ),
          TextFormField(
            controller: controller2,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Destination()));
            },
          ),
          TextField()
        ],
      ),
    );
  }

  // To get the source Address
  void updateSource(String name1) {
    setState(() {
      controller1.text = name1;
    });
  }

// To get the Destination Address
  void updateDestination(String des) {
    setState(() {
      controller2.text = des;
    });
  }
}
