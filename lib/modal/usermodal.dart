// ignore_for_file: unnecessary_this, prefer_collection_literals, unnecessary_new

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? location;

  String? companyname;

  // Timestamp? creationtime;
  String? country;
  String? id;
  String? photourl;
  bool? isOnline;
  // Timestamp? lastSeen;
  // Timestamp? lastsigntime;
  String? role;
  String? state;
  String? username;
  String? usernumber;
  UserModel(
      {this.location,
      this.companyname,
      this.country,
      // this.creationtime,
      this.id,
      this.photourl,
      this.isOnline,
      // this.lastSeen,
      // this.lastsigntime,
      this.role,
      this.state,
      this.username,
      this.usernumber});

  UserModel.fromJson(Map<String, dynamic> json) {
    location = json['location'];
    companyname = json['companyname'];
    country = json['country'];
    // creationtime = json['creationtime'];
    id = json['id'];
    photourl = json['photourl'];
    isOnline = json['isOnline'];
    // lastSeen = json['lastSeen'];
    // lastsigntime = json['lastsigntime'];
    role = json['role'];
    state = json['state'];
    username = json['username'];
    usernumber = json['usernumber'];
  }

  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();
    data['location'] = this.location;
    data['companyname'] = this.companyname;
    data['country'] = this.country;
    // data['creationtime'] = this.creationtime;
    data['id'] = this.id;
    data['photourl'] = this.photourl;
    data['isOnline'] = this.isOnline;
    // data['lastSeen'] = this.lastSeen;
    // data['lastsigntime'] = this.lastsigntime;
    data['role'] = this.role;
    data['state'] = this.state;
    data['username'] = this.username;
    data['usernumber'] = this.usernumber;

    return data;
  }
}
