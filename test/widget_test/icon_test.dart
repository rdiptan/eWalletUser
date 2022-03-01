import 'package:e_wallet/page/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Home Page Testing', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: Home()));
    expect(find.byIcon(Icons.settings), findsOneWidget);
  });
  testWidgets('popup', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: Drawer()));
    expect(find.byIcon(Icons.logout), findsOneWidget);
  });
}
