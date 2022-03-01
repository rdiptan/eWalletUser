import 'package:json_annotation/json_annotation.dart';
import 'package:e_wallet/model/tranactionDetails.dart';

part 'transaction_details_debit_resp.g.dart';

@JsonSerializable(explicitToJson: true)
class TransactionDetailsDebitResp {
  List<TransactionDetails> data;
  final bool success;

  TransactionDetailsDebitResp({required this.data, required this.success});

  factory TransactionDetailsDebitResp.fromJson(Map<String, dynamic> json) =>
      _$TransactionDetailsDebitRespFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionDetailsDebitRespToJson(this);
}
