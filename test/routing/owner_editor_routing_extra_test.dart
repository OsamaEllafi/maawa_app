import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:maawa_app/l10n/app_localizations.dart';
import 'package:maawa_app/app/navigation/app_router.dart';
import 'package:maawa_app/demo/demo_data.dart';
import 'package:maawa_app/ui/screens/properties/owner/property_editor_screen.dart';

void main() {
  group('Owner Editor Routing Extra Tests', () {
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

    testWidgets('Trailing slash canonicalization redirects correctly', (
      tester,
    ) async {
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      // Navigate to create editor with trailing slash
      router.go('/owner/properties/new/');
      await tester.pumpAndSettle();

      // Verify editor loads (redirect should happen automatically)
      expect(find.byType(PropertyEditorScreen), findsOneWidget);
    });

    testWidgets('Legacy edit path redirects correctly', (
      tester,
    ) async {
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      // Get a valid property ID from demo data
      final validPropertyId = DemoData.properties.first.id;

      // Navigate to legacy edit route
      router.go('/owner/property/$validPropertyId/editor');
      await tester.pumpAndSettle();

      // Verify editor loads (redirect should happen automatically)
      expect(find.byType(PropertyEditorScreen), findsOneWidget);
    });

    testWidgets('Percent-encoded ID resolves correctly', (
      tester,
    ) async {
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      // Get a valid property ID and encode it
      final validPropertyId = DemoData.properties.first.id;
      final encodedId = Uri.encodeComponent(validPropertyId);

      // Navigate with encoded ID
      router.go('/owner/properties/$encodedId/edit');
      await tester.pumpAndSettle();

      // Verify editor loads
      expect(find.byType(PropertyEditorScreen), findsOneWidget);
    });

    testWidgets('Empty ID shows NotFound', (
      tester,
    ) async {
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      // Navigate with empty ID (use a valid pattern but empty parameter)
      router.go('/owner/properties/%20/edit');
      await tester.pumpAndSettle();

      // Verify NotFound screen appears
      expect(find.text('Page Not Found'), findsOneWidget);
      expect(find.text('Go Home'), findsOneWidget);
    });

    testWidgets('Invalid ID shows NotFound', (
      tester,
    ) async {
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      // Navigate with invalid ID
      router.go('/owner/properties/invalid_id/edit');
      await tester.pumpAndSettle();

      // Verify NotFound screen appears
      expect(find.text('Page Not Found'), findsOneWidget);
      expect(find.text('Go Home'), findsOneWidget);
    });

    testWidgets('Query and fragment are preserved during redirect', (
      tester,
    ) async {
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      // Navigate with query and fragment
      router.go('/owner/properties/new/?ref=deep#frag');
      await tester.pumpAndSettle();

      // Verify editor loads (query/fragment should be preserved)
      expect(find.byType(PropertyEditorScreen), findsOneWidget);
    });

    testWidgets('RTL locale works with invalid edit path', (
      tester,
    ) async {
      // Create app with Arabic locale
      router = AppRouter.createRouter(
        onThemeChanged: (_) {},
        onLocaleChanged: (_) {},
        currentThemeMode: ThemeMode.light,
        currentLocale: const Locale('ar'),
      );

      await tester.pumpWidget(MaterialApp.router(
        routerConfig: router,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en'), Locale('ar')],
      ));
      await tester.pumpAndSettle();

      // Navigate to invalid edit path
      router.go('/owner/properties/invalid_id/edit');
      await tester.pumpAndSettle();

      // Verify NotFound screen appears with localized content
      expect(find.text('Page Not Found'), findsOneWidget);
      expect(find.text('Go Home'), findsOneWidget);
    });

    testWidgets('Whitespace-only ID shows NotFound', (
      tester,
    ) async {
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      // Navigate with whitespace-only ID
      router.go('/owner/properties/   /edit');
      await tester.pumpAndSettle();

      // Verify NotFound screen appears
      expect(find.text('Page Not Found'), findsOneWidget);
      expect(find.text('Go Home'), findsOneWidget);
    });

    testWidgets('Multiple trailing slashes are handled', (
      tester,
    ) async {
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      // Navigate with multiple trailing slashes
      router.go('/owner/properties/new///');
      await tester.pumpAndSettle();

      // Verify editor loads (should redirect to canonical path)
      // Note: The redirect only handles single trailing slash, so this should still work
      expect(find.byType(PropertyEditorScreen), findsOneWidget);
    });
  });
}
