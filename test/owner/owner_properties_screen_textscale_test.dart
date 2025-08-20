import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:maawa_app/l10n/app_localizations.dart';
import 'package:maawa_app/ui/screens/properties/owner/owner_properties_screen.dart';

void main() {
  group('OwnerPropertiesScreen Text Scale Tests', () {
    Widget createTestApp({required Locale locale}) {
      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const OwnerPropertiesScreen(),
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
        await tester.binding.setSurfaceSize(const Size(600, 800));

        await tester.pumpWidget(
          MediaQuery(
            data: const MediaQueryData(textScaleFactor: 1.3),
            child: createTestApp(locale: const Locale('en')),
          ),
        );

        // Wait for animations to complete
        await tester.pumpAndSettle();

        // Verify the screen renders without overflow exceptions
        expect(find.byType(OwnerPropertiesScreen), findsOneWidget);

        // Check that tab bar is visible
        expect(find.byType(TabBar), findsOneWidget);

        // Check that tab content is visible
        expect(find.byType(TabBarView), findsOneWidget);
      },
    );

    testWidgets('should render without overflow at 130% text scale in Arabic', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(600, 800));

      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(textScaleFactor: 1.3),
          child: createTestApp(locale: const Locale('ar')),
        ),
      );

      // Wait for animations to complete
      await tester.pumpAndSettle();

      // Verify the screen renders without overflow exceptions
      expect(find.byType(OwnerPropertiesScreen), findsOneWidget);

      // Check that tab bar is visible
      expect(find.byType(TabBar), findsOneWidget);

      // Check that tab content is visible
      expect(find.byType(TabBarView), findsOneWidget);
    });

    testWidgets('should handle tab switching without overflow', (tester) async {
      await tester.binding.setSurfaceSize(const Size(600, 800));

      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(textScaleFactor: 1.3),
          child: createTestApp(locale: const Locale('en')),
        ),
      );

      await tester.pumpAndSettle();

      // Tap on different tabs to test navigation
      await tester.tap(find.text('Pending'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Published'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Rejected'));
      await tester.pumpAndSettle();

      // Verify no overflow exceptions occurred
      expect(find.byType(OwnerPropertiesScreen), findsOneWidget);
    });
  });
}
