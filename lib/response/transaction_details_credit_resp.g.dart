// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_details_credit_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionDetailsCreditResp _$TransactionDetailsCreditRespFromJson(
        Map<String, dynamic> json) =>
    TransactionDetailsCreditResp(
      data: (json['data'] as List<dynamic>)
          .map((e) => TransactionDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
      success: json['success'] as bool,
    );

Map<String, dynamic> _$TransactionDetailsCreditRespToJson(
        TransactionDetailsCreditResp instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'success': instance.success,
    };
