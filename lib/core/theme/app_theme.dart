import 'package:flutter/material.dart';

/// Spacing constants following the 4pt base unit system
class Spacing {
  static const double xs = 4.0; // 1
  static const double sm = 8.0; // 2
  static const double md = 16.0; // 4
  static const double lg = 24.0; // 6
  static const double xl = 32.0; // 8
  static const double xxl = 48.0; // 12
}

/// Motion duration constants
class MotionDuration {
  static const micro = Duration(milliseconds: 120);
  static const microExtended = Duration(milliseconds: 180);
  static const microEmphasized = Duration(milliseconds: 240);
  static const standard = Duration(milliseconds: 250);
  static const standardExtended = Duration(milliseconds: 300);
  static const standardEmphasized = Duration(milliseconds: 400);
  static const page = Duration(milliseconds: 400);
  static const pageExtended = Duration(milliseconds: 500);
  static const pageEmphasized = Duration(milliseconds: 600);
}

/// Motion curve constants
class MotionCurves {
  static const standard = Curves.easeInOut;
  static const standardDecelerate = Curves.easeOut;
  static const standardAccelerate = Curves.easeIn;
  static const emphasized = Curves.easeInOutCubic;
  static const emphasizedDecelerate = Curves.easeOutCubic;
  static const emphasizedAccelerate = Curves.easeInCubic;
  static const bounce = Curves.elasticOut;
  static const sharp = Curves.easeInOutBack;
}

/// Border radius constants
class BorderRadiusTokens {
  static const small = 4.0;
  static const medium = 8.0;
  static const large = 12.0;
  static const extraLarge = 16.0;
  static const pill = 50.0;
  static const circle = 50.0;
  static const full = 999.0;
}

/// Color tokens for the design system
class AppColors {
  // Primary Colors
  static const primary50 = Color(0xFFE3F2FD);
  static const primary100 = Color(0xFFBBDEFB);
  static const primary500 = Color(0xFF2196F3);
  static const primary600 = Color(0xFF1E88E5);
  static const primary700 = Color(0xFF1976D2);
  static const primary900 = Color(0xFF0D47A1);

  // Secondary Colors
  static const secondary50 = Color(0xFFF3E5F5);
  static const secondary100 = Color(0xFFE1BEE7);
  static const secondary500 = Color(0xFF9C27B0);
  static const secondary600 = Color(0xFF8E24AA);
  static const secondary700 = Color(0xFF7B1FA2);

  // Surface Colors
  static const surface0 = Color(0xFFFFFFFF);
  static const surface50 = Color(0xFFFAFAFA);
  static const surface100 = Color(0xFFF5F5F5);
  static const surface200 = Color(0xFFEEEEEE);
  static const surface300 = Color(0xFFE0E0E0);

  // Background Colors
  static const background = Color(0xFFFFFFFF);
  static const backgroundSecondary = Color(0xFFF8F9FA);

  // Success Colors
  static const success50 = Color(0xFFE8F5E8);
  static const success500 = Color(0xFF4CAF50);
  static const success600 = Color(0xFF43A047);
  static const success700 = Color(0xFF388E3C);

  // Warning Colors
  static const warning50 = Color(0xFFFFF8E1);
  static const warning500 = Color(0xFFFFC107);
  static const warning600 = Color(0xFFFFB300);
  static const warning700 = Color(0xFFFFA000);

  // Error Colors
  static const error50 = Color(0xFFFFEBEE);
  static const error500 = Color(0xFFF44336);
  static const error600 = Color(0xFFE53935);
  static const error700 = Color(0xFFD32F2F);

  // Text Colors
  static const textPrimary = Color(0xFF212121);
  static const textSecondary = Color(0xFF757575);
  static const textDisabled = Color(0xFFBDBDBD);
  static const textInverse = Color(0xFFFFFFFF);

  // Dark Theme Colors
  static const darkPrimary50 = Color(0xFF0D47A1);
  static const darkPrimary100 = Color(0xFF1565C0);
  static const darkPrimary500 = Color(0xFF42A5F5);
  static const darkPrimary600 = Color(0xFF1976D2);
  static const darkPrimary700 = Color(0xFF1565C0);
  static const darkPrimary900 = Color(0xFF0D47A1);

  static const darkSecondary50 = Color(0xFF4A148C);
  static const darkSecondary100 = Color(0xFF6A1B9A);
  static const darkSecondary500 = Color(0xFFAB47BC);
  static const darkSecondary600 = Color(0xFF9C27B0);
  static const darkSecondary700 = Color(0xFF8E24AA);

  static const darkSurface0 = Color(0xFF121212);
  static const darkSurface50 = Color(0xFF1E1E1E);
  static const darkSurface100 = Color(0xFF2D2D2D);
  static const darkSurface200 = Color(0xFF424242);
  static const darkSurface300 = Color(0xFF616161);

  static const darkBackground = Color(0xFF121212);
  static const darkBackgroundSecondary = Color(0xFF1E1E1E);

  static const darkSuccess50 = Color(0xFF1B5E20);
  static const darkSuccess500 = Color(0xFF66BB6A);
  static const darkSuccess600 = Color(0xFF4CAF50);
  static const darkSuccess700 = Color(0xFF388E3C);

  static const darkWarning50 = Color(0xFFF57F17);
  static const darkWarning500 = Color(0xFFFFB300);
  static const darkWarning600 = Color(0xFFFF8F00);
  static const darkWarning700 = Color(0xFFFF6F00);

  static const darkError50 = Color(0xFFC62828);
  static const darkError500 = Color(0xFFEF5350);
  static const darkError600 = Color(0xFFE53935);
  static const darkError700 = Color(0xFFD32F2F);

  static const darkTextPrimary = Color(0xFFFFFFFF);
  static const darkTextSecondary = Color(0xFFB3B3B3);
  static const darkTextDisabled = Color(0xFF666666);
  static const darkTextInverse = Color(0xFF212121);

  // Additional surface and state colors
  static const surface500 = Color(0xFF9AA0A6);
  static const success100 = Color(0xFFE8F5E8);
  static const error100 = Color(0xFFFFEBEE);
  static const warning100 = Color(0xFFFFF3E0);
}

/// App theme configuration
class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary500,
      onPrimary: AppColors.textInverse,
      primaryContainer: AppColors.primary50,
      onPrimaryContainer: AppColors.primary900,
      secondary: AppColors.secondary500,
      onSecondary: AppColors.textInverse,
      secondaryContainer: AppColors.secondary50,
      onSecondaryContainer: AppColors.secondary700,
      surface: AppColors.surface0,
      onSurface: AppColors.textPrimary,
      error: AppColors.error500,
      onError: AppColors.textInverse,
      errorContainer: AppColors.error50,
      onErrorContainer: AppColors.error700,
      outline: AppColors.surface300,
      outlineVariant: AppColors.surface200,
      shadow: Color(0x1F000000),
      scrim: Color(0x52000000),
      inverseSurface: AppColors.darkSurface0,
      onInverseSurface: AppColors.darkTextPrimary,
      inversePrimary: AppColors.darkPrimary500,
      surfaceTint: AppColors.primary500,
    ),
    textTheme: _buildTextTheme(ThemeData.light().textTheme),
    primaryTextTheme: _buildTextTheme(ThemeData.light().textTheme),
    inputDecorationTheme: _buildInputDecorationTheme(),
    elevatedButtonTheme: _buildElevatedButtonTheme(),
    outlinedButtonTheme: _buildOutlinedButtonTheme(),
    textButtonTheme: _buildTextButtonTheme(),
    cardTheme: _buildCardTheme(),
    appBarTheme: _buildAppBarTheme(),
    bottomNavigationBarTheme: _buildBottomNavigationBarTheme(),
    floatingActionButtonTheme: _buildFloatingActionButtonTheme(),
    chipTheme: _buildChipTheme(),
    dividerTheme: _buildDividerTheme(),
    iconTheme: _buildIconTheme(),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.darkPrimary500,
      onPrimary: AppColors.darkTextInverse,
      primaryContainer: AppColors.darkPrimary50,
      onPrimaryContainer: AppColors.darkPrimary900,
      secondary: AppColors.darkSecondary500,
      onSecondary: AppColors.darkTextInverse,
      secondaryContainer: AppColors.darkSecondary50,
      onSecondaryContainer: AppColors.darkSecondary700,
      surface: AppColors.darkSurface0,
      onSurface: AppColors.darkTextPrimary,
      error: AppColors.darkError500,
      onError: AppColors.darkTextInverse,
      errorContainer: AppColors.darkError50,
      onErrorContainer: AppColors.darkError700,
      outline: AppColors.darkSurface300,
      outlineVariant: AppColors.darkSurface200,
      shadow: Color(0x1FFFFFFF),
      scrim: Color(0x52FFFFFF),
      inverseSurface: AppColors.surface0,
      onInverseSurface: AppColors.textPrimary,
      inversePrimary: AppColors.primary500,
      surfaceTint: AppColors.darkPrimary500,
    ),
    textTheme: _buildTextTheme(ThemeData.dark().textTheme),
    primaryTextTheme: _buildTextTheme(ThemeData.dark().textTheme),
    inputDecorationTheme: _buildInputDecorationTheme(),
    elevatedButtonTheme: _buildElevatedButtonTheme(),
    outlinedButtonTheme: _buildOutlinedButtonTheme(),
    textButtonTheme: _buildTextButtonTheme(),
    cardTheme: _buildCardTheme(),
    appBarTheme: _buildAppBarTheme(),
    bottomNavigationBarTheme: _buildBottomNavigationBarTheme(),
    floatingActionButtonTheme: _buildFloatingActionButtonTheme(),
    chipTheme: _buildChipTheme(),
    dividerTheme: _buildDividerTheme(),
    iconTheme: _buildIconTheme(),
  );

  static TextTheme _buildTextTheme(TextTheme base) {
    // Use Inter as base, but we'll override with locale-aware fonts in the app
    return base.copyWith(
      displayLarge: base.displayLarge?.copyWith(
        fontSize: 57,
        height: 64 / 57,
        fontWeight: FontWeight.w400,
      ),
      displayMedium: base.displayMedium?.copyWith(
        fontSize: 45,
        height: 52 / 45,
        fontWeight: FontWeight.w400,
      ),
      displaySmall: base.displaySmall?.copyWith(
        fontSize: 36,
        height: 44 / 36,
        fontWeight: FontWeight.w400,
      ),
      headlineLarge: base.headlineLarge?.copyWith(
        fontSize: 32,
        height: 40 / 32,
        fontWeight: FontWeight.w400,
      ),
      headlineMedium: base.headlineMedium?.copyWith(
        fontSize: 28,
        height: 36 / 28,
        fontWeight: FontWeight.w400,
      ),
      headlineSmall: base.headlineSmall?.copyWith(
        fontSize: 24,
        height: 32 / 24,
        fontWeight: FontWeight.w400,
      ),
      titleLarge: base.titleLarge?.copyWith(
        fontSize: 22,
        height: 28 / 22,
        fontWeight: FontWeight.w400,
      ),
      titleMedium: base.titleMedium?.copyWith(
        fontSize: 16,
        height: 24 / 16,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: base.titleSmall?.copyWith(
        fontSize: 14,
        height: 20 / 14,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: base.bodyLarge?.copyWith(
        fontSize: 16,
        height: 24 / 16,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: base.bodyMedium?.copyWith(
        fontSize: 14,
        height: 20 / 14,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: base.bodySmall?.copyWith(
        fontSize: 12,
        height: 16 / 12,
        fontWeight: FontWeight.w400,
      ),
      labelLarge: base.labelLarge?.copyWith(
        fontSize: 14,
        height: 20 / 14,
        fontWeight: FontWeight.w500,
      ),
      labelMedium: base.labelMedium?.copyWith(
        fontSize: 12,
        height: 16 / 12,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: base.labelSmall?.copyWith(
        fontSize: 11,
        height: 16 / 11,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  static InputDecorationTheme _buildInputDecorationTheme() {
    return const InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(BorderRadiusTokens.medium),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(BorderRadiusTokens.medium),
        ),
        borderSide: BorderSide(color: AppColors.surface300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(BorderRadiusTokens.medium),
        ),
        borderSide: BorderSide(color: AppColors.primary500, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(BorderRadiusTokens.medium),
        ),
        borderSide: BorderSide(color: AppColors.error500),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: Spacing.md,
        vertical: Spacing.sm,
      ),
    );
  }

  static ElevatedButtonThemeData _buildElevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: Spacing.md,
          vertical: Spacing.sm,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BorderRadiusTokens.medium),
        ),
        minimumSize: const Size(0, 48),
      ),
    );
  }

  static OutlinedButtonThemeData _buildOutlinedButtonTheme() {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: Spacing.md,
          vertical: Spacing.sm,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BorderRadiusTokens.medium),
        ),
        minimumSize: const Size(0, 48),
      ),
    );
  }

  static TextButtonThemeData _buildTextButtonTheme() {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: Spacing.md,
          vertical: Spacing.sm,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BorderRadiusTokens.medium),
        ),
        minimumSize: const Size(0, 48),
      ),
    );
  }

  static CardThemeData _buildCardTheme() {
    return CardThemeData(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(BorderRadiusTokens.medium),
      ),
      margin: const EdgeInsets.all(Spacing.sm),
    );
  }

  static AppBarTheme _buildAppBarTheme() {
    return const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      scrolledUnderElevation: 1,
    );
  }

  static BottomNavigationBarThemeData _buildBottomNavigationBarTheme() {
    return const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    );
  }

  static FloatingActionButtonThemeData _buildFloatingActionButtonTheme() {
    return const FloatingActionButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(BorderRadiusTokens.large),
        ),
      ),
    );
  }

  static ChipThemeData _buildChipTheme() {
    return ChipThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(BorderRadiusTokens.pill),
      ),
      padding: const EdgeInsets.symmetric(horizontal: Spacing.sm),
    );
  }

  static DividerThemeData _buildDividerTheme() {
    return const DividerThemeData(thickness: 1, space: Spacing.md);
  }

  static IconThemeData _buildIconTheme() {
    return const IconThemeData(size: 24);
  }
}

// Layout constants for property cards
const double kGridCardHeight = 276.0; // Increased from 260 for 130% text scale
const double kListItemHeight = 140.0; // Increased from 136 for better fit
const double kGridSpacing = 12.0;
