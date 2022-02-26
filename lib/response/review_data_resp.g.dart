// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_data_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseGetReview _$ResponseGetReviewFromJson(Map<String, dynamic> json) =>
    ResponseGetReview(
      success: json['success'] as bool,
      msg: json['msg'] as String,
      data: Review.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResponseGetReviewToJson(ResponseGetReview instance) =>
    <String, dynamic>{
      'success': instance.success,
      'msg': instance.msg,
      'data': instance.data.toJson(),
    };
