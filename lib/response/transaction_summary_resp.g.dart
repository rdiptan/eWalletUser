// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_summary_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionSummaryResp _$TransactionSummaryRespFromJson(
        Map<String, dynamic> json) =>
    TransactionSummaryResp(
      data: TransactionSummary.fromJson(json['data'] as Map<String, dynamic>),
      success: json['success'] as bool,
    );

Map<String, dynamic> _$TransactionSummaryRespToJson(
        TransactionSummaryResp instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
      'success': instance.success,
    };
