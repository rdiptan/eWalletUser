import 'package:json_annotation/json_annotation.dart';

part 'transactionSummary.g.dart';

@JsonSerializable()
class TransactionSummary {
  final String? name;
  final num? balance;
  final num? debit;
  final num? credit;

  TransactionSummary({this.name, this.balance, this.debit, this.credit});

  factory TransactionSummary.fromJson(Map<String, dynamic> json) =>
      _$TransactionSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionSummaryToJson(this);
}
