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
      v: json['__v'] as int?,
      created_at: json['created_at'] as String?,
      is_admin: json['is_admin'] as bool?,
      is_active: json['is_active'] as bool?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      '_id': instance.id,
      'email': instance.email,
      'fname': instance.fname,
      'lname': instance.lname,
      'password': instance.password,
      'image': instance.image,
      '__v': instance.v,
      'created_at': instance.created_at,
      'is_admin': instance.is_admin,
      'is_active': instance.is_active,
    };
