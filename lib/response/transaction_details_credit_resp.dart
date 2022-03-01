import 'package:json_annotation/json_annotation.dart';
import 'package:e_wallet/model/tranactionDetails.dart';

part 'transaction_details_credit_resp.g.dart';

@JsonSerializable(explicitToJson: true)
class TransactionDetailsCreditResp {
  List<TransactionDetails> data;
  final bool success;

  TransactionDetailsCreditResp({required this.data, required this.success});

  factory TransactionDetailsCreditResp.fromJson(Map<String, dynamic> json) =>
      _$TransactionDetailsCreditRespFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionDetailsCreditRespToJson(this);
}
