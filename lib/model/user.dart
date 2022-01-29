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

  User(
      {this.id, this.email, this.fname, this.lname, this.password, this.image});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
