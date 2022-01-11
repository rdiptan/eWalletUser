import 'package:e_wallet/screen/loginPage.dart';
import 'package:e_wallet/screen/registrationPage.dart';
import 'package:e_wallet/theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

// void main() => runApp(const MyApp());
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((prefs) {
    var isDarkTheme = prefs.getBool("darkTheme") ?? false;
    return runApp(
      ChangeNotifierProvider<ThemeProvider>(
        child: const MyApp(),
        create: (BuildContext context) {
          return ThemeProvider(isDarkTheme);
        },
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, value, child) {
      return MaterialApp(
          title: 'eWallet',
          theme: value.getTheme(),
          initialRoute: 'login',
          routes: {
            'login': (context) => const LoginPage(),
            'registration': (context) => const RegistrationPage()
          });
    });
  }
}
