import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:accident_alert/screens/login_screen.dart';

void main() {
  testWidgets('Login page loads correctly', (WidgetTester tester) async {
    // Build the login page widget inside a MaterialApp
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

    // Verify that "Login" text appears on screen
    expect(find.text('Login'), findsOneWidget);

    // Optionally check that background image or layers exist
    expect(find.byType(Stack), findsOneWidget);
  });
}
