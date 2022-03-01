import 'package:e_wallet/widgets/drawer.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/mockito.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  testWidgets("Navigation Testing", (WidgetTester tester) async {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    AppDrawer myDrawer = const AppDrawer();

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        key: scaffoldKey,
        drawer: myDrawer,
      ),
    ));
    scaffoldKey.currentState!.openDrawer();
    await tester.pump();
    expect(find.text("Logout"), findsOneWidget);
  });
}
