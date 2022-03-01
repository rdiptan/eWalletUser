import 'package:e_wallet/screen/homePage.dart';
import 'package:e_wallet/auth/loginPage.dart';
import 'package:e_wallet/auth/registrationPage.dart';
import 'package:e_wallet/auth/validationPage.dart';
import 'package:e_wallet/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AwesomeNotifications().initialize(null, // icon for your app notification
      [
        NotificationChannel(
            channelKey: 'eWallet',
            channelName: 'eWallet',
            channelDescription: "eWallet Notification",
            defaultColor: const Color(0xFF105F49),
            ledColor: Colors.white,
            playSound: true,
            enableLights: true,
            enableVibration: true)
      ]);
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
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
          initialRoute: '/',
          routes: {
            '/': (context) => const ValidationPage(),
            'login': (context) => const LoginPage(),
            'registration': (context) => const RegistrationPage(),
            'home': (context) => const HomePage(),
          });
    });
  }
}
