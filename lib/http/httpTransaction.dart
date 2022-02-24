// ignore_for_file: file_names

import 'dart:convert';
import 'dart:async';

import 'package:e_wallet/model/tranactionDetails.dart';
import 'package:e_wallet/response/transaction_details_resp.dart';
import 'package:http/http.dart' as http;
import 'package:e_wallet/utils/load_token.dart';
import 'package:e_wallet/model/transaction.dart';

class HttpConnectTransaction {
  String baseurl = "http://10.0.2.2:90/";

  Future<String?> newTransaction(Transaction transaction) async {
    String? futureToken = await loadToken();
    String authToken = 'Bearer $futureToken';

    Map<String, dynamic> transactionMap = {
      "email": transaction.email,
      "amount": transaction.amount,
      "category": transaction.category,
      "reason": transaction.reason,
    };
    final response = await http.post(Uri.parse(baseurl + 'transaction/new'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': authToken,
        },
        body: jsonEncode(transactionMap));
    if (jsonDecode(response.body)['success'] == true) {
      return 'true';
    } else {
      var userResponse = jsonDecode(response.body);
      // return userResponse['msg'];
      return 'false';
    }
  }

  Future getTransaction() async {
    String? futureToken = await loadToken();
    String authToken = 'Bearer $futureToken';

    final response =
        await http.get(Uri.parse(baseurl + 'transaction/view'), headers: {
      'Content-Type': 'application/json',
      'Authorization': authToken,
    });
    if (jsonDecode(response.body)['success'] == true) {
      var transactionResponse =
          TransactionDetailsResp.fromJson(jsonDecode(response.body));
      return transactionResponse.data;
    } else {
      var transactionResponse = jsonDecode(response.body);
      return transactionResponse['msg'];
    }
  }

  Future<TransactionDetails> getTransactionById(String id) async {
    String? futureToken = await loadToken();
    String authToken = 'Bearer $futureToken';

    final response =
        await http.get(Uri.parse(baseurl + 'transaction/view/' + id), headers: {
      'Content-Type': 'application/json',
      'Authorization': authToken,
    });
    if (jsonDecode(response.body)['success'] == true) {
      var transactionResponse = jsonDecode(response.body);
      return TransactionDetails.fromJson(transactionResponse);
    } else {
      var transactionResponse = jsonDecode(response.body);
      return transactionResponse['msg'];
    }
  }
}
