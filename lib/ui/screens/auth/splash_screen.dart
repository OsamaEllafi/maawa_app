import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/theme/app_theme.dart';
import '../../../app/navigation/app_router.dart';

/// Splash screen displayed on app launch with brand animation
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  void _navigateToNext() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        // Navigate to onboarding for new users
        context.go(AppRouter.onboarding);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isReducedMotion = MediaQuery.of(context).accessibleNavigation;

    return Scaffold(
      backgroundColor: theme.colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Brand icon with animation
            Icon(
              Icons.home_work,
              size: 80,
              color: theme.colorScheme.onPrimary,
            )
                .animate()
                .fadeIn(duration: isReducedMotion ? 0.ms : 600.ms)
                .scale(begin: isReducedMotion ? const Offset(1.0, 1.0) : const Offset(0.5, 0.5), duration: isReducedMotion ? 0.ms : 800.ms)
                .then()
                .shimmer(duration: isReducedMotion ? 0.ms : 1200.ms, delay: isReducedMotion ? 0.ms : 500.ms),

            SizedBox(height: Spacing.lg),

            // App title with animation
            Text(
              l10n.appTitle,
              style: theme.textTheme.headlineLarge?.copyWith(
                color: theme.colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            )
                .animate()
                .fadeIn(delay: isReducedMotion ? 0.ms : 400.ms, duration: isReducedMotion ? 0.ms : 800.ms)
                .slideY(begin: isReducedMotion ? 0.0 : 0.3, duration: isReducedMotion ? 0.ms : 800.ms),

            SizedBox(height: Spacing.md),

            // Tagline with animation
            Text(
              'Find Your Perfect Stay',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onPrimary.withValues(alpha: 0.8),
              ),
            )
                .animate()
                .fadeIn(delay: isReducedMotion ? 0.ms : 800.ms, duration: isReducedMotion ? 0.ms : 600.ms),

            SizedBox(height: Spacing.xl),

            // Loading indicator with animation
            Semantics(
              label: 'Loading application',
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  theme.colorScheme.onPrimary,
                ),
              )
                  .animate()
                  .fadeIn(delay: isReducedMotion ? 0.ms : 1200.ms, duration: isReducedMotion ? 0.ms : 400.ms)
                  .then()
                  .shimmer(duration: isReducedMotion ? 0.ms : 1500.ms, delay: isReducedMotion ? 0.ms : 200.ms),
            ),
          ],
        ),
      ),
    );
  }
}
