import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:maawa_app/l10n/app_localizations.dart';
import 'package:maawa_app/app/navigation/app_router.dart';
import 'package:maawa_app/demo/demo_data.dart';
import 'package:maawa_app/ui/screens/properties/owner/property_editor_screen.dart';

void main() {
  group('Owner Editor Routing Tests', () {
    late GoRouter router;

    Widget createTestApp() {
      router = AppRouter.createRouter(
        onThemeChanged: (_) {},
        onLocaleChanged: (_) {},
        currentThemeMode: ThemeMode.light,
        currentLocale: const Locale('en'),
      );

      return MaterialApp.router(
        routerConfig: router,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en'), Locale('ar')],
      );
    }

    testWidgets('Deep-link to /owner/properties/new loads editor', (
      tester,
    ) async {
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      // Navigate to the new property editor
      router.go('/owner/properties/new');
      await tester.pumpAndSettle();

      // Verify editor loads
      expect(find.byType(PropertyEditorScreen), findsOneWidget);
    });

    testWidgets('Deep-link to /owner/properties/{validId}/edit loads editor', (
      tester,
    ) async {
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      // Get a valid property ID from demo data
      final validPropertyId = DemoData.properties.first.id;

      // Navigate to the edit route
      router.go('/owner/properties/$validPropertyId/edit');
      await tester.pumpAndSettle();

      // Verify editor loads
      expect(find.byType(PropertyEditorScreen), findsOneWidget);
    });

    testWidgets('Deep-link to /owner/properties/invalid/edit shows NotFound', (
      tester,
    ) async {
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      // Navigate with invalid ID
      router.go('/owner/properties/invalid_id/edit');
      await tester.pumpAndSettle();
      
      // Verify NotFound screen appears by checking its content
      expect(find.text('Page Not Found'), findsOneWidget);
      expect(find.text('Go Home'), findsOneWidget);
    });

    testWidgets('NotFound screen has Go Home button', (tester) async {
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      // Navigate to NotFound screen
      router.go('/owner/properties/invalid_id/edit');
      await tester.pumpAndSettle();

      // Verify NotFound screen content is present
      expect(find.text('Page Not Found'), findsOneWidget);
      expect(find.text('Go Home'), findsOneWidget);
    });
  });
}
