import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../l10n/app_localizations.dart';
import '../../core/theme/app_theme.dart';
import 'bottom_nav.dart';
import '../../app/navigation/app_router.dart';

/// Main scaffold layout that wraps authenticated screens
class MainScaffold extends StatelessWidget {
  const MainScaffold({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final showBottomNav = _shouldShowBottomNav(location);

    return Scaffold(
      body: SafeArea(
        child: child,
      ),
      bottomNavigationBar: showBottomNav ? const BottomNav() : null,
    );
  }

  /// Determine if bottom navigation should be shown
  bool _shouldShowBottomNav(String location) {
    // Show bottom nav for main tenant screens
    const bottomNavRoutes = [
      '/tenant/home',
      '/tenant/property',
      '/bookings/my',
      '/bookings/request',
      '/bookings/',
      '/wallet',
      '/wallet/topup',
      '/wallet/withdraw',
      '/wallet/history',
      '/profile',
      '/settings',
    ];

    // Don't show bottom nav for these routes
    const excludedRoutes = [
      '/owner/',
      '/admin/',
      '/profile/kyc',
      '/settings/dev-tools',
      '/settings/about',
      '/style-guide',
      '/auth/',
      '/onboarding',
    ];

    // Check if location starts with any excluded route
    for (final excluded in excludedRoutes) {
      if (location.startsWith(excluded)) {
        return false;
      }
    }

    // Check if location starts with any bottom nav route
    for (final route in bottomNavRoutes) {
      if (location.startsWith(route)) {
        return true;
      }
    }

    return false;
  }
}
