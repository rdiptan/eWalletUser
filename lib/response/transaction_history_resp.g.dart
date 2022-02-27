// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_history_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionHistoryResp _$TransactionHistoryRespFromJson(
        Map<String, dynamic> json) =>
    TransactionHistoryResp(
      data: TransactionDetails.fromJson(json['data'] as Map<String, dynamic>),
      success: json['success'] as bool,
    );

Map<String, dynamic> _$TransactionHistoryRespToJson(
        TransactionHistoryResp instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
      'success': instance.success,
    };
