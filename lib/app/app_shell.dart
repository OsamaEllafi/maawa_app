import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../l10n/app_localizations.dart';
import '../core/theme/app_theme.dart';
import 'navigation/app_router.dart';

/// App shell that provides theme switching, localization, and navigation
class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  ThemeMode _themeMode = ThemeMode.system;
  Locale _locale = const Locale('en');
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = AppRouter.createRouter(
      onThemeChanged: _changeTheme,
      onLocaleChanged: _changeLocale,
      currentThemeMode: _themeMode,
      currentLocale: _locale,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Maawa',
      debugShowCheckedModeBanner: false,

      // Theme configuration
      theme: _buildLocaleAwareTheme(AppTheme.lightTheme),
      darkTheme: _buildLocaleAwareTheme(AppTheme.darkTheme),
      themeMode: _themeMode,

      // Localization configuration
      locale: _locale,
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      // Router configuration
      routerConfig: _router,

      // Builder to provide theme and locale context
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: MediaQuery.of(
              context,
            ).textScaler.clamp(minScaleFactor: 0.8, maxScaleFactor: 1.3),
          ),
          child: child!,
        );
      },
    );
  }

  void _changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  void _changeLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  ThemeData _buildLocaleAwareTheme(ThemeData baseTheme) {
    if (_locale.languageCode == 'ar') {
      return baseTheme.copyWith(
        textTheme: GoogleFonts.almaraiTextTheme(baseTheme.textTheme),
        primaryTextTheme: GoogleFonts.almaraiTextTheme(baseTheme.primaryTextTheme),
      );
    } else {
      return baseTheme.copyWith(
        textTheme: GoogleFonts.interTextTheme(baseTheme.textTheme),
        primaryTextTheme: GoogleFonts.interTextTheme(baseTheme.primaryTextTheme),
      );
    }
  }
}
