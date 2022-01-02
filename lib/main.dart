import 'package:e_wallet/screen/loginPage.dart';
import 'package:e_wallet/screen/registrationPage.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'eWallet',
        theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF105F49)),
        initialRoute: 'login',
        routes: {
          'login': (context) => const LoginPage(),
          'registration': (context) => const RegistrationPage()
        });
  }
}
