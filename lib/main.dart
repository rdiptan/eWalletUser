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
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFF105F49),
          primaryColor: const Color(0xFF337762),
          accentColor: const Color(0xFFF6F6F6),
          canvasColor: const Color(0xFFE9FFAC),
          textTheme: const TextTheme(
            bodyText1: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),
            bodyText2: TextStyle(color: Color(0xFF15102E), fontSize: 18),
            headline1: TextStyle(
                color: Color(0xFF105F49),
                fontWeight: FontWeight.w700,
                fontSize: 32),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(16),
              minimumSize: const Size(double.infinity, 50),
              elevation: 10,
              primary: const Color(0xFF105F49),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ),
        initialRoute: 'login',
        routes: {
          'login': (context) => const LoginPage(),
          'registration': (context) => const RegistrationPage()
        });
  }
}
