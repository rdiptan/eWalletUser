import 'package:e_wallet/http/httpTransaction.dart';
import 'package:e_wallet/model/tranactionDetails.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'transactionHistory_test.mocks.dart';

@GenerateMocks([HttpConnectTransaction])
void main() {
  test("Get debit transaction", () {
    MockHttpConnectTransaction mockDebit = MockHttpConnectTransaction();
    when(mockDebit.getDebitTransaction())
        .thenAnswer((_) => Future.value(<TransactionDetails>[]));

    expect(mockDebit.getDebitTransaction(),
        isNot(equals(Future.value(TransactionDetails()))));
  });
  test("Get credit transaction", () {
    MockHttpConnectTransaction mockCredit = MockHttpConnectTransaction();
    when(mockCredit.getCreditTransaction())
        .thenAnswer((_) => Future.value(<TransactionDetails>[]));

    expect(mockCredit.getCreditTransaction(),
        isNot(equals(Future.value(TransactionDetails()))));
  });
}
