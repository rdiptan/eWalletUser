import 'package:json_annotation/json_annotation.dart';
import 'package:e_wallet/model/tranactionDetails.dart';

part 'transaction_history_resp.g.dart';

@JsonSerializable(explicitToJson: true)
class TransactionHistoryResp {
  TransactionDetails data;
  final bool success;

  TransactionHistoryResp({required this.data, required this.success});

  factory TransactionHistoryResp.fromJson(Map<String, dynamic> json) =>
      _$TransactionHistoryRespFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionHistoryRespToJson(this);
}
