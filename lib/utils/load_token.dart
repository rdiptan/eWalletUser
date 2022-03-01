import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String?> loadToken() async {
  String token;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  token = (prefs.getString('token') ?? '');
  return token;
}

Future<void> removeToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('token');
  Hive.box('debitData').clear();
  Hive.box('creditData').clear();
}
