// ignore: file_names
// ignore_for_file: file_names, prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:thaartransport/Test/textfield.dart';
import 'package:thaartransport/Utils/controllers.dart';
import 'package:thaartransport/Utils/firebase.dart';
import 'package:thaartransport/Utils/googleservice.dart';
import 'package:uuid/uuid.dart';

import 'PostLoad.dart';

class Destination extends StatefulWidget {
  @override
  _DestinationState createState() => _DestinationState();
}

class _DestinationState extends State<Destination> {
  String? sessionTokenDestination;
  List<dynamic> DestinationList = [];

  @override
  void initState() {
    super.initState();
    destination.addListener(() {
      _onChanged();
    });
  }

  _onChanged() {
    if (sessionTokenDestination == null) {
      setState(() {
        sessionTokenDestination = uuid.v4();
      });
    }
    getDestinationSuggestion(destination.text);
  }

  void getDestinationSuggestion(String input) async {
    String components = googleService().components;
    String baseURL = googleService().baseURL;
    String API_KEY = googleService().kPLACES_API_KEY;
    String type = googleService().type;
    String request =
        '$baseURL?input=$input&types=$type&components=$components&key=$API_KEY&sessiontoken=$sessionTokenDestination';
    var response = await http.get(Uri.parse(request));
    if (response.statusCode == 200) {
      setState(() {
        DestinationList = json.decode(response.body)['predictions'];
      });
    } else {
      throw Exception('Failed to load predictions');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          elevation: 0,
          bottom: PreferredSize(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      autofocus: true,
                      controller: destination,
                      decoration: InputDecoration(
                          hintText: "Search here",
                          focusColor: Colors.white,
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          suffixIcon: IconButton(
                              onPressed: () {
                                destination.clear();
                              },
                              icon: const Icon(
                                Icons.cancel,
                                color: Colors.black,
                              )),
                          prefixIcon: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                              ))),
                    ),
                  ],
                ),
              ),
              preferredSize: const Size.fromHeight(40)),
        ),
        body: ListView.builder(
            shrinkWrap: true,
            itemCount: DestinationList.length,
            itemBuilder: (context, index) {
              final item = DestinationList[index];
              return ListTile(
                onTap: () async {
                  setState(() {
                    destination.text = DestinationList[index]["description"];
                    String id = item['description'];
                    // _placeList1.cast();
                    DestinationList.clear();
                    print(id);
                    saveDestination();
                  });
                },
                title: Text(item["description"]),
              );
            }));
  }

  void saveDestination() {
    String des = destination.text;
    saveNamePreference(des).then((bool committed) {
      // Navigator.pop(context);
      Future.delayed(Duration(seconds: 1));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => PostLoad()));
    });
  }
}

Future<bool> saveNamePreference(String des) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString('des', des);
  return preferences.commit();
}

Future<String> getDes() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String des = preferences.getString('des').toString();
  return des;
}
