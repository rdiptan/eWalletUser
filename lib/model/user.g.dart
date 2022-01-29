// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['_id'] as String?,
      email: json['email'] as String?,
      fname: json['fname'] as String?,
      lname: json['lname'] as String?,
      password: json['password'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      '_id': instance.id,
      'email': instance.email,
      'fname': instance.fname,
      'lname': instance.lname,
      'password': instance.password,
      'image': instance.image,
    };
