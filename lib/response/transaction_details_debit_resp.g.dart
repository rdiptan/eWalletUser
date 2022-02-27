// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_details_debit_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionDetailsDebitResp _$TransactionDetailsDebitRespFromJson(
        Map<String, dynamic> json) =>
    TransactionDetailsDebitResp(
      data: (json['data'] as List<dynamic>)
          .map((e) => TransactionDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
      success: json['success'] as bool,
    );

Map<String, dynamic> _$TransactionDetailsDebitRespToJson(
        TransactionDetailsDebitResp instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'success': instance.success,
    };
