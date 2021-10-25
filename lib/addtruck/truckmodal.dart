// // ignore_for_file: unnecessary_this, prefer_collection_literals, unnecessary_new

// import 'dart:convert';

// import 'package:cloud_firestore/cloud_firestore.dart';

// class PostModal {
//   String? backimage;
//   String? capacity;
//   String? location;

//   String? fontimage;

//   String? lorrynumber;
//   String? ownerid;
//   String? posttime;
//   String? status;
//   String? truckpostid;
//   String? usernumber;
//   PostModal({
//     this.backimage,
//     this.capacity,
//     this.location,
//     this.fontimage,
//     this.lorrynumber,
//     this.ownerid,
//     this.posttime,
//     this.status,
//     this.truckpostid,
//     this.usernumber,
//   });
 


//   PostModal.fromJson(Map<String, dynamic> json) {
//     backimage = json['backimage'];
//     capacity = json['capacity'];
//     sourcelocation = json['sourcelocation'];
//     expectedprice = json['expectedprice'];
//     height = json['height'];
//     postexpiretime = json['postexpiretime'];
//     length = json['length'];
//     loadposttime = json['loadposttime'];
//     material = json['material'];
//     ownerid = json['ownerid'];
//     paymentoption = json['paymentoption'];
//     priceunit = json['priceunit'];
//     postid = json['postid'];
//     quantity = json['quantity'];
//   }

//   Map<String, dynamic> toJson() {
//     final data = Map<String, dynamic>();
//     data['breadth'] = breadth;
//     data['destinationlocation'] = destinationlocation;
//     data['sourcelocation'] = sourcelocation;
//     data['expectedprice'] = expectedprice;
//     data['height'] = height;
//     data['postexpiretime'] = postexpiretime;
//     data['length'] = length;
//     data['loadposttime'] = loadposttime;
//     data['material'] = material;
//     data['ownerid'] = ownerid;
//     data['paymentoption'] = paymentoption;
//     data['priceunit'] = priceunit;
//     data['postid'] = postid;
//     data['quantity'] = quantity;
//     return data;
//   }
// }
