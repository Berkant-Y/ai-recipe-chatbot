import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food/main.dart';

void main() {
  testWidgets('App başlatma testi', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Splash screen kontrolü
    expect(find.text('Food Assistant'), findsOneWidget);
  });
}