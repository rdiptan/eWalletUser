// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseGetUser _$ResponseGetUserFromJson(Map<String, dynamic> json) =>
    ResponseGetUser(
      success: json['success'] as bool,
      data: UserDetails.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResponseGetUserToJson(ResponseGetUser instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data.toJson(),
    };
