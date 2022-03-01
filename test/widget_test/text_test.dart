import 'package:e_wallet/widgets/faq.dart';
import 'package:e_wallet/widgets/kyc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('KYC Page Testing', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: KYC()));

    expect(find.text('KYC'), findsOneWidget);
  });

  testWidgets('Profile Page Testing', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: FAQ()));

    expect(find.text('FAQs will be added soon...'), findsOneWidget);
  });
}
