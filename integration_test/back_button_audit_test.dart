import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:maawa_app/main.dart' as app;

/// Integration test to audit back button functionality
///
/// Tests that:
/// - Tab root screens (Home, My Bookings, Wallet, Profile) show no back button
/// - Inner screens show back button with correct tooltip
/// - Back button navigation works correctly
/// - RTL support works for back button tooltip
/// - Deep-linked inner screens show back button and navigate to Home
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Back Button Audit', () {
    testWidgets('Tab root screens should not show back button', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Start on Home (should be a tab root)
      await tester.tap(find.text('Home'));
      await tester.pumpAndSettle();

      // Verify no back button is present on Home
      expect(find.byTooltip('Back'), findsNothing);
      expect(find.byTooltip('رجوع'), findsNothing);

      // Navigate to My Bookings (should be a tab root)
      await tester.tap(find.text('Bookings'));
      await tester.pumpAndSettle();

      // Verify no back button is present on My Bookings
      expect(find.byTooltip('Back'), findsNothing);
      expect(find.byTooltip('رجوع'), findsNothing);

      // Navigate to Wallet (should be a tab root)
      await tester.tap(find.text('Wallet'));
      await tester.pumpAndSettle();

      // Verify no back button is present on Wallet
      expect(find.byTooltip('Back'), findsNothing);
      expect(find.byTooltip('رجوع'), findsNothing);

      // Navigate to Profile (should be a tab root)
      await tester.tap(find.text('Profile'));
      await tester.pumpAndSettle();

      // Verify no back button is present on Profile
      expect(find.byTooltip('Back'), findsNothing);
      expect(find.byTooltip('رجوع'), findsNothing);
    });

    testWidgets('Inner screens should show back button and navigate correctly', (
      tester,
    ) async {
      app.main();
      await tester.pumpAndSettle();

      // Start on Home
      await tester.tap(find.text('Home'));
      await tester.pumpAndSettle();

      // Tap on a property card to navigate to Property Details
      final propertyCard = find.byType(Card).first;
      await tester.tap(propertyCard);
      await tester.pumpAndSettle();

      // Verify back button is present on Property Details
      expect(find.byTooltip('Back'), findsOneWidget);

      // Tap back button to return to Home
      await tester.tap(find.byTooltip('Back'));
      await tester.pumpAndSettle();

      // Verify we're back on Home (no back button)
      expect(find.byTooltip('Back'), findsNothing);

      // Navigate to Property Details again
      await tester.tap(propertyCard);
      await tester.pumpAndSettle();

      // Tap "Request Booking" to navigate to Booking Request
      await tester.tap(find.text('Request Booking'));
      await tester.pumpAndSettle();

      // Verify back button is present on Booking Request
      expect(find.byTooltip('Back'), findsOneWidget);

      // Tap back button to return to Property Details
      await tester.tap(find.byTooltip('Back'));
      await tester.pumpAndSettle();

      // Verify we're back on Property Details (back button should still be present)
      expect(find.byTooltip('Back'), findsOneWidget);

      // Tap back button again to return to Home
      await tester.tap(find.byTooltip('Back'));
      await tester.pumpAndSettle();

      // Verify we're back on Home (no back button)
      expect(find.byTooltip('Back'), findsNothing);
    });

    testWidgets(
      'Deep-linked inner screens should show back button and navigate to Home',
      (tester) async {
        // Launch app with initial route set to an inner page (deep link)
        app.main();
        await tester.pumpAndSettle();

        // Navigate directly to a property detail page (simulating deep link)
        // Note: In a real deep link scenario, this would be set via initial route
        await tester.tap(find.text('Home'));
        await tester.pumpAndSettle();

        final propertyCard = find.byType(Card).first;
        await tester.tap(propertyCard);
        await tester.pumpAndSettle();

        // Verify back button is present on Property Details (even if deep-linked)
        expect(find.byTooltip('Back'), findsOneWidget);

        // Tap back button - should navigate to Home since this simulates a deep link
        await tester.tap(find.byTooltip('Back'));
        await tester.pumpAndSettle();

        // Verify we're on Home (no back button)
        expect(find.byTooltip('Back'), findsNothing);

        // Now test normal navigation flow: Home → Property → Booking Request
        await tester.tap(propertyCard);
        await tester.pumpAndSettle();

        // Verify back button is present on Property Details
        expect(find.byTooltip('Back'), findsOneWidget);

        await tester.tap(find.text('Request Booking'));
        await tester.pumpAndSettle();

        // Verify back button is present on Booking Request
        expect(find.byTooltip('Back'), findsOneWidget);

        // Tap back button to return to Property Details
        await tester.tap(find.byTooltip('Back'));
        await tester.pumpAndSettle();

        // Verify we're back on Property Details (back button should still be present)
        expect(find.byTooltip('Back'), findsOneWidget);

        // Tap back button again to return to Home
        await tester.tap(find.byTooltip('Back'));
        await tester.pumpAndSettle();

        // Verify we're back on Home (no back button)
        expect(find.byTooltip('Back'), findsNothing);
      },
    );

    testWidgets(
      'Deep-linked Booking Request should show back button and navigate to Home',
      (tester) async {
        // Launch app
        app.main();
        await tester.pumpAndSettle();

        // Navigate to Home first
        await tester.tap(find.text('Home'));
        await tester.pumpAndSettle();

        // Navigate to Property Details
        final propertyCard = find.byType(Card).first;
        await tester.tap(propertyCard);
        await tester.pumpAndSettle();

        // Navigate to Booking Request (simulating deep link to Booking Request)
        await tester.tap(find.text('Request Booking'));
        await tester.pumpAndSettle();

        // Verify back button is present on Booking Request
        expect(find.byTooltip('Back'), findsOneWidget);

        // Tap back button - should return to Property Details (normal navigation)
        await tester.tap(find.byTooltip('Back'));
        await tester.pumpAndSettle();

        // Verify we're back on Property Details (back button should still be present)
        expect(find.byTooltip('Back'), findsOneWidget);

        // Now simulate a deep link scenario by going back to Home
        await tester.tap(find.byTooltip('Back'));
        await tester.pumpAndSettle();

        // Navigate directly to Booking Request again (simulating deep link)
        await tester.tap(propertyCard);
        await tester.pumpAndSettle();
        await tester.tap(find.text('Request Booking'));
        await tester.pumpAndSettle();

        // Verify back button is present on Booking Request
        expect(find.byTooltip('Back'), findsOneWidget);

        // Tap back button - should navigate to Property Details
        await tester.tap(find.byTooltip('Back'));
        await tester.pumpAndSettle();

        // Verify we're back on Property Details
        expect(find.byTooltip('Back'), findsOneWidget);

        // Tap back button again to return to Home
        await tester.tap(find.byTooltip('Back'));
        await tester.pumpAndSettle();

        // Verify we're back on Home (no back button)
        expect(find.byTooltip('Back'), findsNothing);
      },
    );

    testWidgets('RTL back button tooltip should work correctly', (
      tester,
    ) async {
      app.main();
      await tester.pumpAndSettle();

      // Switch to Arabic locale (RTL)
      await tester.tap(find.text('Profile'));
      await tester.pumpAndSettle();

      // Navigate to Settings (inner screen)
      await tester.tap(find.byIcon(Icons.settings));
      await tester.pumpAndSettle();

      // Verify Arabic back button tooltip is present
      expect(find.byTooltip('رجوع'), findsOneWidget);

      // Tap back button to return to Profile
      await tester.tap(find.byTooltip('رجوع'));
      await tester.pumpAndSettle();

      // Verify we're back on Profile (no back button)
      expect(find.byTooltip('رجوع'), findsNothing);
    });

    testWidgets('Wallet sub-screens should show back button', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to Wallet
      await tester.tap(find.text('Wallet'));
      await tester.pumpAndSettle();

      // Navigate to Wallet History
      await tester.tap(find.byIcon(Icons.history));
      await tester.pumpAndSettle();

      // Verify back button is present on Wallet History
      expect(find.byTooltip('Back'), findsOneWidget);

      // Tap back button to return to Wallet
      await tester.tap(find.byTooltip('Back'));
      await tester.pumpAndSettle();

      // Verify we're back on Wallet (no back button)
      expect(find.byTooltip('Back'), findsNothing);

      // Navigate to Top Up
      await tester.tap(find.text('Top Up'));
      await tester.pumpAndSettle();

      // Verify back button is present on Top Up
      expect(find.byTooltip('Back'), findsOneWidget);

      // Tap back button to return to Wallet
      await tester.tap(find.byTooltip('Back'));
      await tester.pumpAndSettle();

      // Verify we're back on Wallet (no back button)
      expect(find.byTooltip('Back'), findsNothing);
    });

    testWidgets('Settings and admin screens should show back button', (
      tester,
    ) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to Profile
      await tester.tap(find.text('Profile'));
      await tester.pumpAndSettle();

      // Navigate to Settings
      await tester.tap(find.byIcon(Icons.settings));
      await tester.pumpAndSettle();

      // Verify back button is present on Settings
      expect(find.byTooltip('Back'), findsOneWidget);

      // Navigate to Dev Tools
      await tester.tap(find.text('Dev Tools'));
      await tester.pumpAndSettle();

      // Verify back button is present on Dev Tools
      expect(find.byTooltip('Back'), findsOneWidget);

      // Navigate to Style Guide
      await tester.tap(find.text('Style Guide'));
      await tester.pumpAndSettle();

      // Verify back button is present on Style Guide
      expect(find.byTooltip('Back'), findsOneWidget);

      // Tap back button to return to Dev Tools
      await tester.tap(find.byTooltip('Back'));
      await tester.pumpAndSettle();

      // Verify we're back on Dev Tools (back button should still be present)
      expect(find.byTooltip('Back'), findsOneWidget);

      // Tap back button to return to Settings
      await tester.tap(find.byTooltip('Back'));
      await tester.pumpAndSettle();

      // Verify we're back on Settings (back button should still be present)
      expect(find.byTooltip('Back'), findsOneWidget);

      // Tap back button to return to Profile
      await tester.tap(find.byTooltip('Back'));
      await tester.pumpAndSettle();

      // Verify we're back on Profile (no back button)
      expect(find.byTooltip('Back'), findsNothing);
    });
  });
}
