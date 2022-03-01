import 'package:e_wallet/http/httpUser.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'registration_test.mocks.dart';

@GenerateMocks([HttpConnectUser])
void main() {
  test("add new user", () {
    MockHttpConnectUser mockRegister = MockHttpConnectUser();
    String? value = "true";
    when(mockRegister.registerUser(null))
        .thenAnswer((_) => Future.value(value));

    expect(mockRegister.registerUser(null), isNot(equals(Future.value(value))));
  });
}
