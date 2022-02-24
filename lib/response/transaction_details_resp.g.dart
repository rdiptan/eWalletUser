// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_details_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionDetailsResp _$TransactionDetailsRespFromJson(
        Map<String, dynamic> json) =>
    TransactionDetailsResp(
      data: (json['data'] as List<dynamic>)
          .map((e) => TransactionDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
      success: json['success'] as bool,
    );

Map<String, dynamic> _$TransactionDetailsRespToJson(
        TransactionDetailsResp instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'success': instance.success,
    };
