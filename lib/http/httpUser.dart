// ignore_for_file: file_names

import 'dart:convert';
import 'dart:async';
import 'package:e_wallet/model/review.dart';
import 'package:e_wallet/model/transactionSummary.dart';
import 'package:e_wallet/model/user.dart';
import 'package:e_wallet/model/userDetails.dart';
import 'package:e_wallet/response/review_data_resp.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:e_wallet/utils/load_token.dart';
import 'package:e_wallet/response/user_auth_resp.dart';
import 'package:e_wallet/response/user_data_resp.dart';
import 'package:e_wallet/response/transaction_summary_resp.dart';

class HttpConnectUser {
  String baseurl = "http://10.0.2.2:90/";
  // String baseurl = "http://192.168.0.105:90/";
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

  Future<String?> updateKYC(UserDetails userdetails) async {
    String? futureToken = await loadToken();
    String authToken = 'Bearer $futureToken';

    Map<String, dynamic> kycMap = {
      "phone": userdetails.phone,
      "address": userdetails.address,
      "dob": userdetails.dob,
      "citizenship": userdetails.citizenship,
    };
    final response = await http.put(Uri.parse(baseurl + 'user/kyc/data'),
        headers: {
          "content-type": "application/json",
          'Authorization': authToken,
        },
        body: jsonEncode(kycMap));
    if (jsonDecode(response.body)['success'] == true) {
      return 'true';
    } else {
      var kycResponse = jsonDecode(response.body);
      return kycResponse['msg'];
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

  Future<Review> getReview() async {
    String? futureToken = await loadToken();
    String authToken = 'Bearer $futureToken';
    final response =
        await http.get(Uri.parse(baseurl + 'review/view'), headers: {
      'Content-Type': 'application/json',
      'Authorization': authToken,
    });
    if (response.statusCode == 200) {
      var processedResponse =
          ResponseGetReview.fromJson(jsonDecode(response.body));
      return processedResponse.data;
    } else {
      return Review();
    }
  }

  Future<String?> newReview(String newcomment, double newrating) async {
    String? futureToken = await loadToken();
    String authToken = 'Bearer $futureToken';

    Map<String, dynamic> reviewMap = {
      "comment": newcomment,
      "rating": newrating,
    };
    final response = await http.post(Uri.parse(baseurl + 'review/write'),
        headers: {
          "content-type": "application/json",
          'Authorization': authToken,
        },
        body: jsonEncode(reviewMap));
    if (jsonDecode(response.body)['success'] == true) {
      return 'true';
    } else {
      var reviewResponse = jsonDecode(response.body);
      return reviewResponse['msg'];
    }
  }

  Future<String?> updateReview(String newcomment, double newrating) async {
    String? futureToken = await loadToken();
    String authToken = 'Bearer $futureToken';

    Map<String, dynamic> reviewMap = {
      "comment": newcomment,
      "rating": newrating,
    };
    final response = await http.put(Uri.parse(baseurl + 'review/update'),
        headers: {
          "content-type": "application/json",
          'Authorization': authToken,
        },
        body: jsonEncode(reviewMap));
    if (jsonDecode(response.body)['success'] == true) {
      return 'true';
    } else {
      var reviewResponse = jsonDecode(response.body);
      return reviewResponse['msg'];
    }
  }

  Future<String?> deleteReview() async {
    String? futureToken = await loadToken();
    String authToken = 'Bearer $futureToken';
    final response =
        await http.delete(Uri.parse(baseurl + 'review/delete'), headers: {
      "content-type": "application/json",
      'Authorization': authToken,
    });
    if (jsonDecode(response.body)['success'] == true) {
      return 'true';
    } else {
      var reviewResponse = jsonDecode(response.body);
      return reviewResponse['msg'];
    }
  }

  Future<String?> changePassword(
      String old_password, String new_password) async {
    String? futureToken = await loadToken();
    String authToken = 'Bearer $futureToken';

    Map<String, dynamic> changePasswordMap = {
      "old_password": old_password,
      "new_password": new_password,
    };
    final response = await http.put(
      Uri.parse(baseurl + 'change-password'),
      headers: {
        "HttpHeaders.contentTypeHeader": 'application/x-www-form-urlencoded',
        "content-type": "application/json",
        'HttpHeaders.Authorization': authToken,
      },
      body: jsonEncode(changePasswordMap),
    );
    if (jsonDecode(response.body)['success'] == true) {
      return 'true';
    } else {
      var passResponse = jsonDecode(response.body);
      return passResponse['msg'];
    }
  }
}
