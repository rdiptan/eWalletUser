// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
      rating: json['rating'] as double?,
      comment: json['comment'] as String?,
      updated_at: json['updated_at'] as String?,
    );

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'rating': instance.rating,
      'comment': instance.comment,
      'updated_at': instance.updated_at,
    };
