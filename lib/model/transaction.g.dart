// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      id: json['_id'] as String?,
      email: json['email'] as String?,
      amount: json['amount'] as String?,
      category: json['category'] as String?,
      reason: json['reason'] as String?,
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'email': instance.email,
      'amount': instance.amount,
      'category': instance.category,
      'reason': instance.reason,
    };
