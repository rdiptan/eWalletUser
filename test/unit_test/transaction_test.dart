import 'package:e_wallet/http/httpTransaction.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'transaction_test.mocks.dart';

@GenerateMocks([HttpConnectTransaction])
void main() {
  test("new transaction", () {
    MockHttpConnectTransaction newTransaction = MockHttpConnectTransaction();
    when(newTransaction.newTransaction(null)).thenAnswer((_) => Future.value());

    expect(newTransaction.newTransaction(null),
        isNot(equals(Future.value('true'))));
  });
}
