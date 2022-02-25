// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transactionSummary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionSummary _$TransactionSummaryFromJson(Map<String, dynamic> json) =>
    TransactionSummary(
      name: json['name'] as String?,
      balance: json['balance'] as num?,
      debit: json['debit'] as num?,
      credit: json['credit'] as num?,
    );

Map<String, dynamic> _$TransactionSummaryToJson(TransactionSummary instance) =>
    <String, dynamic>{
      'name': instance.name,
      'balance': instance.balance,
      'debit': instance.debit,
      'credit': instance.credit,
    };
