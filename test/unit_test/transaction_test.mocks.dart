// Mocks generated by Mockito 5.1.0 from annotations
// in e_wallet/test/unit_test/transaction_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:e_wallet/http/httpTransaction.dart' as _i3;
import 'package:e_wallet/model/tranactionDetails.dart' as _i2;
import 'package:e_wallet/model/transaction.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeTransactionDetails_0 extends _i1.Fake
    implements _i2.TransactionDetails {}

/// A class which mocks [HttpConnectTransaction].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpConnectTransaction extends _i1.Mock
    implements _i3.HttpConnectTransaction {
  MockHttpConnectTransaction() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get baseurl =>
      (super.noSuchMethod(Invocation.getter(#baseurl), returnValue: '')
          as String);
  @override
  set baseurl(String? _baseurl) =>
      super.noSuchMethod(Invocation.setter(#baseurl, _baseurl),
          returnValueForMissingStub: null);
  @override
  _i4.Future<String?> newTransaction(_i5.Transaction? transaction) =>
      (super.noSuchMethod(Invocation.method(#newTransaction, [transaction]),
          returnValue: Future<String?>.value()) as _i4.Future<String?>);
  @override
  _i4.Future<List<_i2.TransactionDetails>> getDebitTransaction() =>
      (super.noSuchMethod(Invocation.method(#getDebitTransaction, []),
              returnValue: Future<List<_i2.TransactionDetails>>.value(
                  <_i2.TransactionDetails>[]))
          as _i4.Future<List<_i2.TransactionDetails>>);
  @override
  _i4.Future<List<_i2.TransactionDetails>> getCreditTransaction() =>
      (super.noSuchMethod(Invocation.method(#getCreditTransaction, []),
              returnValue: Future<List<_i2.TransactionDetails>>.value(
                  <_i2.TransactionDetails>[]))
          as _i4.Future<List<_i2.TransactionDetails>>);
  @override
  _i4.Future<_i2.TransactionDetails> getTransactionById(String? id) =>
      (super.noSuchMethod(Invocation.method(#getTransactionById, [id]),
              returnValue: Future<_i2.TransactionDetails>.value(
                  _FakeTransactionDetails_0()))
          as _i4.Future<_i2.TransactionDetails>);
}
