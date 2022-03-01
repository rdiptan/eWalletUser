import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:e_wallet/auth/loginPage.dart';

import '../unit_test/login_test.mocks.dart';

void main() {
  Widget makeTestableWidget({required Widget child}) {
    return MaterialApp(
        home: Scaffold(
      body: child,
    ));
  }

  testWidgets('email and username field is empty', (WidgetTester tester) async {
    MockHttpConnectUser mockUser = MockHttpConnectUser();

    LoginPage loginPage = const LoginPage();

    await tester.pumpWidget(makeTestableWidget(child: loginPage));

    Finder emailField = find.byKey(const Key('email'));
    await tester.enterText(emailField, '');

    Finder passwordField = find.byKey(const Key('password'));
    await tester.enterText(passwordField, '');

    await tester.tap(find.byKey(const Key('login')));

    verifyNever(mockUser.loginUser('', ''));
  });

  testWidgets('username and password is not empty, login user',
      (WidgetTester tester) async {
    MockHttpConnectUser mockUser = MockHttpConnectUser();

    LoginPage loginPage = const LoginPage();

    when(mockUser.loginUser('user@email.com', 'user'))
        .thenAnswer((_) => Future.value("true"));

    mockUser.loginUser('user@email.com', 'user');

    await tester.pumpWidget(makeTestableWidget(child: loginPage));

    Finder emailField = find.byKey(const Key('email'));
    await tester.enterText(emailField, 'user@email.com');

    Finder passwordField = find.byKey(const Key('password'));
    await tester.enterText(passwordField, 'user');

    expect(find.text('Login Failed'), findsOneWidget);
  });
}
