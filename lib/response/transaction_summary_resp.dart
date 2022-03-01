import 'package:e_wallet/model/transactionSummary.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transaction_summary_resp.g.dart';

@JsonSerializable(explicitToJson: true)
class TransactionSummaryResp {
  final TransactionSummary data;
  final bool success;

  TransactionSummaryResp({required this.data, required this.success});

  factory TransactionSummaryResp.fromJson(Map<String, dynamic> json) =>
      _$TransactionSummaryRespFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionSummaryRespToJson(this);
}
