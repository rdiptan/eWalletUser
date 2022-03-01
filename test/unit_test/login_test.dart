import 'package:e_wallet/http/httpUser.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_test.mocks.dart';

@GenerateMocks([HttpConnectUser])
void main() {
  test("User can be logged in", () {
    MockHttpConnectUser mockUser = MockHttpConnectUser();
    String? value = "true";
    when(mockUser.loginUser('user@email.com', "user"))
        .thenAnswer((_) => Future.value(value));

    expect(mockUser.loginUser("user@email.com", "user"),
        isNot(equals(Future.value(value))));
  });
}
