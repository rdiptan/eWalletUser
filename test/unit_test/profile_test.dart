import 'package:e_wallet/http/httpUser.dart';
import 'package:e_wallet/model/userDetails.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_test.mocks.dart';

@GenerateMocks([HttpConnectUser])
void main() {
  test("Get profile page", () {
    MockHttpConnectUser mockUser = MockHttpConnectUser();
    when(mockUser.getUser()).thenAnswer((_) => Future.value(UserDetails()));

    expect(mockUser.getUser(), isNot(equals(Future.value(UserDetails()))));
  });
  test("change password", () {
    MockHttpConnectUser mockUser = MockHttpConnectUser();
    String? value = "true";
    when(mockUser.changePassword('user', "user"))
        .thenAnswer((_) => Future.value(value));

    expect(mockUser.changePassword("user", "user"),
        isNot(equals(Future.value(value))));
  });
}
