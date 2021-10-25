import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:thaartransport/Test/textfield.dart';
import 'package:thaartransport/Utils/firebase.dart';
import 'package:thaartransport/Utils/googleservice.dart';
import 'package:thaartransport/addnewload/PostLoad.dart';
import 'package:thaartransport/Utils/controllers.dart';

class SourceLocation extends StatefulWidget {
  @override
  _SourceLocationState createState() => _SourceLocationState();
}

class _SourceLocationState extends State<SourceLocation> {
  String? id;

  String? sessionTokenSource;

  List<dynamic> SourceList = [];

  @override
  void initState() {
    super.initState();
    source.addListener(() {
      _onChangedSource();
    });
  }

  _onChangedSource() {
    if (sessionTokenSource == null) {
      setState(() {
        sessionTokenSource = uuid.v4();
      });
    }
    getSourceSuggestion(source.text);
  }

  void getSourceSuggestion(String input) async {
    String components = googleService().components;
    String baseURL = googleService().baseURL;
    String API_KEY = googleService().kPLACES_API_KEY;
    String type = googleService().type;
    String request =
        '$baseURL?input=$input&types=$type&components=$components&key=$API_KEY&sessiontoken=$sessionTokenSource';
    var response = await http.get(Uri.parse(request));
    if (response.statusCode == 200) {
      setState(() {
        SourceList = json.decode(response.body)['predictions'];
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
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Column(children: [
                const SizedBox(
                  height: 10.0,
                ),
                TextField(
                  autofocus: true,
                  controller: source,
                  decoration: InputDecoration(
                      hintText: "Search here",
                      focusColor: Colors.white,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      suffixIcon: IconButton(
                          onPressed: () {
                            source.clear();
                          },
                          icon: const Icon(Icons.cancel, color: Colors.black)),
                      prefixIcon: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ))),
                ),
              ]),
            ),
            preferredSize: const Size.fromHeight(40),
          ),
        ),
        body: ListView.builder(
            shrinkWrap: true,
            itemCount: SourceList.length,
            itemBuilder: (context, index) {
              final item1 = SourceList[index];
              return ListTile(
                onTap: () async {
                  setState(() {
                    source.text = SourceList[index]["description"];
                    String id = item1['description'];
                    // _placeList1.cast();
                    SourceList.clear();
                    saveSource();
                    print(id);
                  });
                },
                title: Text(item1["description"]),
              );
            }));
  }

  void saveSource() {
    String name1 = source.text;
    saveNamePreference(name1).then((bool committed) {
      // Navigator.pop(context);
      Future.delayed(Duration(seconds: 1));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => PostLoad()));
    });
  }
}

Future<bool> saveNamePreference(String name1) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString('name1', name1);
  return preferences.commit();
}

Future<String> getSource() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String name1 = preferences.getString('name1').toString();
  return name1;
}
