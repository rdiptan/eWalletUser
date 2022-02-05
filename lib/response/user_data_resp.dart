import 'package:json_annotation/json_annotation.dart';
import 'package:e_wallet/model/userDetails.dart';

part 'user_data_resp.g.dart';

@JsonSerializable(explicitToJson: true)
class ResponseGetUser {
  final bool success;
  final UserDetails data;

  ResponseGetUser({
    required this.success,
    required this.data,
  });

  factory ResponseGetUser.fromJson(Map<String, dynamic> json) =>
      _$ResponseGetUserFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseGetUserToJson(this);
}
