// ignore_for_file: file_names, unnecessary_this, unnecessary_new, prefer_collection_literals

import 'package:e_wallet/model/user.dart';

class UserDetails {
  String? sId;
  User? user;
  String? phone;
  String? address;
  String? citizenship;
  String? citizenshipProof;
  DateTime? dob;
  bool? isVerified;
  num? balance;

  UserDetails(
      {this.sId,
      this.user,
      this.phone,
      this.address,
      this.citizenship,
      this.citizenshipProof,
      this.dob,
      this.isVerified,
      this.balance});

  UserDetails.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    phone = json['phone'];
    address = json['address'];
    citizenship = json['citizenship'];
    citizenshipProof = json['citizenship_proof'];
    dob = json['dob'];
    isVerified = json['is_verified'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['citizenship'] = this.citizenship;
    data['citizenship_proof'] = this.citizenshipProof;
    data['dob'] = this.dob;
    data['is_verified'] = this.isVerified;
    data['balance'] = this.balance;
    return data;
  }
}
