// import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ecofood/main.dart';
import 'package:ecofood/pages/get_started.dart';
import 'package:ecofood/pages/splash_screen.dart';

void main() {
  testWidgets('Splash screen and navigation test', (WidgetTester tester) async {
    // Initialize app with first launch flag set to true
    await tester.pumpWidget(const MyApp(isFirstLaunch: true));

    // Verify that the splash screen is displayed
    expect(find.byType(SplashScreen), findsOneWidget);

    // After the splash screen completes, verify the next screen is displayed
    await tester.pumpAndSettle();

    // Assuming your app navigates to the next screen (GetStarted)
    expect(find.byType(GetStarted), findsOneWidget);
  });
}
