// ignore_for_file: file_names

import 'dart:convert';
import 'dart:async';

import 'package:e_wallet/model/transactionSummary.dart';
import 'package:e_wallet/model/user.dart';
import 'package:e_wallet/model/userDetails.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:e_wallet/utils/load_token.dart';
import 'package:e_wallet/response/user_auth_resp.dart';
import 'package:e_wallet/response/user_data_resp.dart';
import 'package:e_wallet/response/transaction_summary_resp.dart';

class HttpConnectUser {
  String baseurl = "http://10.0.2.2:90/";
  static String token = "";

  // Creating User -- POST
  Future<String?> registerUser(User user) async {
    Map<String, dynamic> userMap = {
      "fname": user.fname,
      "lname": user.lname,
      "email": user.email,
      "password": user.password,
    };
    final response = await http.post(Uri.parse(baseurl + 'user/registration'),
        headers: {"content-type": "application/json"},
        body: jsonEncode(userMap));
    if (response.statusCode == 200) {
      final loginResponse = await loginUser(user.email!, user.password!);
      if (loginResponse == "true") {
        return 'true';
      } else {
        return loginResponse;
      }
    } else {
      var userResponse = jsonDecode(response.body);
      return userResponse['msg'];
    }
  }

  // Login User -- POST
  Future<String?> loginUser(String email, String password) async {
    Map<String, dynamic> loginMap = {
      "email": email,
      "password": password,
    };
    final response = await http.post(Uri.parse(baseurl + 'login'),
        headers: {"content-type": "application/json"},
        body: jsonEncode(loginMap));
    if (response.statusCode == 200) {
      var userResponse = ResponseUser.fromJSON(jsonDecode(response.body));
      token = userResponse.token!;
      assignToken(userResponse.token);
      return "true";
    } else {
      var userResponse = jsonDecode(response.body);
      return userResponse['msg'];
    }
  }

  void assignToken(token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    print('token saved locally');
  }

  Future<UserDetails> getUser() async {
    String? futureToken = await loadToken();
    String authToken = 'Bearer $futureToken';
    final response =
        await http.get(Uri.parse(baseurl + 'user/profile'), headers: {
      'Content-Type': 'application/json',
      'Authorization': authToken,
    });
    if (response.statusCode == 200) {
      var processedResponse =
          ResponseGetUser.fromJson(jsonDecode(response.body));
      return processedResponse.data;
    } else {
      return UserDetails();
    }
  }

  Future<TransactionSummary> getTransactionSummary() async {
    String? futureToken = await loadToken();
    String authToken = 'Bearer $futureToken';
    final response =
        await http.get(Uri.parse(baseurl + 'transaction/summary'), headers: {
      'Content-Type': 'application/json',
      'Authorization': authToken,
    });
    if (response.statusCode == 200) {
      var processedResponse =
          TransactionSummaryResp.fromJson(jsonDecode(response.body));
      return processedResponse.data;
    } else {
      return TransactionSummary();
    }
  }
}
