class ResponseUser {
  bool? success;
  String? token;

  ResponseUser({this.success, this.token});

  factory ResponseUser.fromJSON(Map<String, dynamic> json) {
    return ResponseUser(
      success: json['success'],
      token: json['user_token'],
    );
  }
}
