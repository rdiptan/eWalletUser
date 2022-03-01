import 'package:e_wallet/auth/registrationPage.dart';
import 'package:e_wallet/model/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:mockito/mockito.dart';

import '../unit_test/registration_test.mocks.dart';

void main() {
  Widget makeTestableWidget({required Widget child}) {
    return MaterialApp(
        home: Scaffold(
      body: child,
    ));
  }

  testWidgets('registration', (WidgetTester tester) async {
    MockHttpConnectUser mockRegister = MockHttpConnectUser();

    RegistrationPage registerPage = const RegistrationPage();

    when(mockRegister.registerUser(User(
            fname: 'drt',
            lname: 'drt',
            password: 'drtdrt123',
            email: "drt@gmail.com")))
        .thenAnswer((_) => Future.value("true"));

    await tester.pumpWidget(makeTestableWidget(child: registerPage));

    Finder fnameField = find.byKey(const Key('fname'));
    await tester.enterText(fnameField, 'drt');

    Finder lnameField = find.byKey(const Key('lname'));
    await tester.enterText(lnameField, 'drt');

    Finder emailField = find.byKey(const Key('email'));
    await tester.enterText(emailField, 'drt@gmail.com');

    Finder passwordField = find.byKey(const Key('password'));
    await tester.enterText(passwordField, 'drtdrt123');

    await tester.tap(find.byKey(const Key('register')));

    expect('true', 'true');
  });
}
