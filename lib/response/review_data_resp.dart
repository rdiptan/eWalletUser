import 'package:e_wallet/model/review.dart';
import 'package:json_annotation/json_annotation.dart';

part 'review_data_resp.g.dart';

@JsonSerializable(explicitToJson: true)
class ResponseGetReview {
  final bool success;
  final String msg;
  final Review data;

  ResponseGetReview({
    required this.success,
    required this.msg,
    required this.data,
  });

  factory ResponseGetReview.fromJson(Map<String, dynamic> json) =>
      _$ResponseGetReviewFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseGetReviewToJson(this);
}
