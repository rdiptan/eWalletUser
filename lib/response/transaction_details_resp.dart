import 'package:json_annotation/json_annotation.dart';
import 'package:e_wallet/model/tranactionDetails.dart';

part 'transaction_details_resp.g.dart';

@JsonSerializable(explicitToJson: true)
class TransactionDetailsResp {
  List<TransactionDetails> data;
  final bool success;

  TransactionDetailsResp({required this.data, required this.success});

  factory TransactionDetailsResp.fromJson(Map<String, dynamic> json) =>
      _$TransactionDetailsRespFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionDetailsRespToJson(this);
}
