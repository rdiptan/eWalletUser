import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  late ThemeData _selectedTheme;
  late Typography defaultTypography;
  late SharedPreferences prefs;

  ThemeData dark = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: const Color(0xFF000000),
    primaryColor: const Color(0xFF000000),
    accentColor: const Color(0xFFF6F6F6),
    canvasColor: const Color(0xFF000000),
    textTheme: const TextTheme(
      bodyText1: TextStyle(
          color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),
      bodyText2: TextStyle(color: Color(0xFF15102E), fontSize: 18),
      headline1: TextStyle(
          color: Color(0xFF000000), fontWeight: FontWeight.w700, fontSize: 32),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      hintStyle: TextStyle(color: Colors.grey), // == grey
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(16),
        minimumSize: const Size(double.infinity, 50),
        elevation: 10,
        primary: const Color(0xFF000000),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: const Color(0xFFE9FFAC),
        primary: const Color(0xFF000000),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  );

  ThemeData light = ThemeData.light().copyWith(
    scaffoldBackgroundColor: const Color(0xFF105F49),
    // primaryColor: const Color(0xFF337762),
    primaryColor: const Color(0xFF105F49),
    accentColor: const Color(0xFFF6F6F6),
    canvasColor: const Color(0xFF337762),
    textTheme: const TextTheme(
      bodyText1: TextStyle(
          color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),
      bodyText2: TextStyle(color: Color(0xFF15102E), fontSize: 18),
      headline1: TextStyle(
          color: Color(0xFF105F49), fontWeight: FontWeight.w700, fontSize: 32),
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
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: const Color(0xFFE9FFAC),
        primary: const Color(0xFF105F49),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  );

  ThemeProvider(bool darkThemeOn) {
    _selectedTheme = darkThemeOn ? dark : light;
  }
  Future<void> swapTheme() async {
    prefs = await SharedPreferences.getInstance();

    if (_selectedTheme == dark) {
      _selectedTheme = light;
      await prefs.setBool("darkTheme", false);
    } else {
      _selectedTheme = dark;
      await prefs.setBool("darkTheme", true);
    }

    notifyListeners();
  }

  ThemeData getTheme() => _selectedTheme;
}
