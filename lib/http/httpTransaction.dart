// ignore_for_file: file_names

import 'dart:convert';
import 'dart:async';

import 'package:e_wallet/model/tranactionDetails.dart';
import 'package:e_wallet/response/transaction_details_credit_resp.dart';
import 'package:e_wallet/response/transaction_details_debit_resp.dart';
import 'package:e_wallet/response/transaction_history_resp.dart';
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
      return userResponse['msg'];
    }
  }

  Future<List<TransactionDetails>> getDebitTransaction() async {
    String? futureToken = await loadToken();
    String authToken = 'Bearer $futureToken';

    final response =
        await http.get(Uri.parse(baseurl + 'transaction/view/debit'), headers: {
      'Content-Type': 'application/json',
      'Authorization': authToken,
    });
    if (jsonDecode(response.body)['success'] == true) {
      var transactionDebitResponse =
          TransactionDetailsDebitResp.fromJson(jsonDecode(response.body));
      return transactionDebitResponse.data;
    } else {
      throw Exception('Failed to load transactions');
    }
  }

  Future<List<TransactionDetails>> getCreditTransaction() async {
    String? futureToken = await loadToken();
    String authToken = 'Bearer $futureToken';

    final response = await http
        .get(Uri.parse(baseurl + 'transaction/view/credit'), headers: {
      'Content-Type': 'application/json',
      'Authorization': authToken,
    });
    if (jsonDecode(response.body)['success'] == true) {
      var transactionCreditResponse =
          TransactionDetailsCreditResp.fromJson(jsonDecode(response.body));
      return transactionCreditResponse.data;
    } else {
      throw Exception('Failed to load transactions');
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
      var transactionHistoryResponse =
          TransactionHistoryResp.fromJson(jsonDecode(response.body));
      return transactionHistoryResponse.data;
    } else {
      throw Exception('Failed to load transaction data');
    }
  }
}
