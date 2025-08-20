import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:maawa_app/l10n/app_localizations.dart';
import 'package:maawa_app/ui/screens/properties/owner/property_editor_screen.dart';

void main() {
  group('PropertyEditorScreen Text Scale Tests', () {
    Widget createTestApp({required Locale locale}) {
      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const PropertyEditorScreen(),
          ),
        ],
      );

      return MaterialApp.router(
        locale: locale,
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

    testWidgets(
      'should render without overflow at 130% text scale in English',
      (tester) async {
        await tester.binding.setSurfaceSize(const Size(400, 800));

        await tester.pumpWidget(
          MediaQuery(
            data: const MediaQueryData(textScaleFactor: 1.3),
            child: createTestApp(locale: const Locale('en')),
          ),
        );

        // Wait for animations to complete
        await tester.pumpAndSettle();

        // Verify the screen renders without overflow exceptions
        expect(find.byType(PropertyEditorScreen), findsOneWidget);

        // Check that form fields are visible
        expect(find.byType(TextFormField), findsWidgets);

        // Check that save button is visible (wrapped in Semantics)
        expect(find.text('Create Property'), findsOneWidget);
      },
    );

    testWidgets('should render without overflow at 130% text scale in Arabic', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(400, 800));

      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(textScaleFactor: 1.3),
          child: createTestApp(locale: const Locale('ar')),
        ),
      );

      // Wait for animations to complete
      await tester.pumpAndSettle();

      // Verify the screen renders without overflow exceptions
      expect(find.byType(PropertyEditorScreen), findsOneWidget);

      // Check that form fields are visible
      expect(find.byType(TextFormField), findsWidgets);

      // Check that save button is visible (wrapped in Semantics)
      expect(find.text('إنشاء العقار'), findsOneWidget);
    });

    testWidgets('should handle form interaction without overflow', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(400, 800));

      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(textScaleFactor: 1.3),
          child: createTestApp(locale: const Locale('en')),
        ),
      );

      await tester.pumpAndSettle();

      // Tap on form fields to test interaction
      await tester.tap(find.byType(TextFormField).first);
      await tester.pumpAndSettle();

      // Verify no overflow exceptions occurred
      expect(find.byType(PropertyEditorScreen), findsOneWidget);
    });
  });
}
