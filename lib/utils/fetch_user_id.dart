import 'package:jwt_decode/jwt_decode.dart';

String? getIdFromToken(String? token) {
  if (token != null) {
    Map<String, dynamic> payload = Jwt.parseJwt(token);
    return payload['uid'];
  }
}
