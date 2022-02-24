// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: "_id")
  String? id;
  final String? email;
  final String? fname;
  final String? lname;
  final String? password;
  final String? image;
  @JsonKey(name: "__v")
  int? v;
  String? created_at;
  bool? is_admin;
  bool? is_active;

  User({
    this.id,
    this.email,
    this.fname,
    this.lname,
    this.password,
    this.image,
    this.v,
    this.created_at,
    this.is_admin,
    this.is_active,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
