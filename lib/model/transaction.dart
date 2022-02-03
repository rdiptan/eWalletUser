import 'package:json_annotation/json_annotation.dart';

part 'transaction.g.dart';

@JsonSerializable()
class Transaction {
  @JsonKey(name: "_id")
  String? id;
  final String? email;
  final String? amount;
  final String? category;
  final String? reason;

  Transaction({this.id, this.email, this.amount, this.category, this.reason});

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}
