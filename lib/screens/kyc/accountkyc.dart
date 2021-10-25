import 'package:flutter/material.dart';
import 'package:thaartransport/screens/kyc/addressproof.dart';
import 'package:thaartransport/utils/constants.dart';

class AccountKyc extends StatefulWidget {
  const AccountKyc({Key? key}) : super(key: key);

  @override
  _AccountKycState createState() => _AccountKycState();
}

class _AccountKycState extends State<AccountKyc> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: _body(),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: Text("Thaar account KYC"),
    );
  }

  Widget _body() {
    return Column(
      children: [
        Container(
            alignment: Alignment.center,
            height: 45,
            color: Colors.grey[300],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Why am I asked to verify my profile?",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('So that we know who is the user of the THAAR app.')
              ],
            )),
        const SizedBox(
          height: 20,
        ),
        Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: "Your Name",
                  hintText: "Enter Your Full Name",
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Constants.textfieldborder, width: 2.5)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2.5, color: Constants.textfieldborder))),
              validator: (val) {
                if (val!.isEmpty) {
                  return 'Please Enter Your Name';
                }
                return null;
              },
            )),
        Spacer(),
        Row(
          children: [
            Checkbox(
                value: value,
                onChanged: (val) {
                  setState(() {
                    value = val!;
                  });
                }),
            const Text("Terms and condition")
          ],
        ),
        RaisedButton(
          color: value ? Colors.red : Colors.grey[300],
          textColor: value ? Colors.white : Colors.black,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddressProof()));
          },
          child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              child: Text(
                "Verify now",
                style: TextStyle(fontSize: 18),
              )),
        )
      ],
    );
  }
}
