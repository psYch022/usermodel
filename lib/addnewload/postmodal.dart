// ignore_for_file: unnecessary_this, prefer_collection_literals, unnecessary_new

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class PostModal {
  String? breadth;
  String? destinationlocation;
  String? sourcelocation;

  String? expectedprice;

  String? height;
  String? postexpiretime;
  String? length;
  String? loadposttime;
  String? material;
  String? ownerid;
  String? paymentoption;
  String? priceunit;
  String? postid;
  String? quantity;
  PostModal({
    this.breadth,
    this.destinationlocation,
    this.sourcelocation,
    this.expectedprice,
    this.height,
    this.postexpiretime,
    this.length,
    required this.loadposttime,
    this.material,
    required this.ownerid,
    required this.paymentoption,
    required this.priceunit,
    this.postid,
    required this.quantity,
  });

  PostModal.fromJson(Map<String, dynamic> json) {
    breadth = json['breadth'];
    destinationlocation = json['destinationlocation'];
    sourcelocation = json['sourcelocation'];
    expectedprice = json['expectedprice'];
    height = json['height'];
    postexpiretime = json['postexpiretime'];
    length = json['length'];
    loadposttime = json['loadposttime'];
    material = json['material'];
    ownerid = json['ownerid'];
    paymentoption = json['paymentoption'];
    priceunit = json['priceunit'];
    postid = json['postid'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();
    data['breadth'] = breadth;
    data['destinationlocation'] = destinationlocation;
    data['sourcelocation'] = sourcelocation;
    data['expectedprice'] = expectedprice;
    data['height'] = height;
    data['postexpiretime'] = postexpiretime;
    data['length'] = length;
    data['loadposttime'] = loadposttime;
    data['material'] = material;
    data['ownerid'] = ownerid;
    data['paymentoption'] = paymentoption;
    data['priceunit'] = priceunit;
    data['postid'] = postid;
    data['quantity'] = quantity;
    return data;
  }
}
