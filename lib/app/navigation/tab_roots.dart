/// Centralized tab root path detection
///
/// This file provides a single source of truth for determining
/// which routes are tab roots (screens that should not show back buttons).
///
/// Tab roots are the main screens accessible via bottom navigation:
/// - /tenant/home - Home screen
/// - /tenant/bookings/my - My Bookings screen
/// - /tenant/wallet - Wallet screen
/// - /tenant/profile - Profile screen
///
/// These paths and their subpaths should not show back buttons.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../l10n/app_localizations.dart';

/// Check if the given location is a tab root path
///
/// Returns true if the location starts with any of the tab root paths.
/// This allows for subpaths under tab roots to also be considered tab roots.
///
/// Examples:
/// - isTabRootPath('/tenant/home') → true
/// - isTabRootPath('/tenant/home/some-subpath') → true
/// - isTabRootPath('/tenant/property/123') → false
/// - isTabRootPath('/auth/login') → false
bool isTabRootPath(String location) {
  const tabRootPaths = <String>{
    '/tenant/home',
    '/tenant/bookings/my',
    '/tenant/wallet',
    '/wallet', // Legacy support
    '/tenant/profile',
    '/profile', // Legacy support
  };

  return tabRootPaths.any((rootPath) => location.startsWith(rootPath));
}

/// Centralized helper for building back leading widgets
///
/// This function applies the same logic as AppTopBar/AppSliverTopBar
/// to ensure consistent back button behavior across the app.
///
/// Use this for screens that can't use AppTopBar (e.g., those with TabBar).
///
/// Returns:
/// - null if this is a tab root (no back button should be shown)
/// - IconButton with back functionality if this is an inner screen
Widget? buildBackLeading(BuildContext context) {
  final routerState = GoRouterState.of(context);
  // Prefer matchedLocation for more reliable detection when redirects/params are involved
  final location = routerState.matchedLocation.isNotEmpty
      ? routerState.matchedLocation
      : routerState.uri.toString();

  // Use centralized tab root detection
  final isTabRoot = isTabRootPath(location);

  // Don't show back button on tab roots
  if (isTabRoot) {
    return null;
  }

  // Determine if we can pop
  final canPopHere = context.canPop();

  void _handleBack() {
    if (canPopHere) {
      context.pop();
    } else {
      // Fallback to Home tab when no navigation history
      context.goNamed('tenantHome');
    }
  }

  return IconButton(
    onPressed: _handleBack,
    icon: const BackButtonIcon(),
    tooltip: AppLocalizations.of(context)?.navBack ?? 'Back',
  );
}
