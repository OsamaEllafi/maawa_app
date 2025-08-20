import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../l10n/app_localizations.dart';
import '../../../app/navigation/tab_roots.dart';


/// Reusable SliverAppBar with automatic back button logic
///
/// Automatically shows back button on inner screens, but not on:
/// - Tab root screens (Home, My Bookings, Wallet, Profile)
/// - Auth screens (Splash, Onboarding, Login, Register, Forgot/Reset)
///
/// Back button behavior:
/// - If custom onBack is provided, use that
/// - If canPop() is true, use context.pop()
/// - Otherwise, navigate to Home tab as fallback
class AppSliverTopBar extends StatelessWidget {
  const AppSliverTopBar({
    super.key,
    required this.title,
    this.actions,
    this.showBackAutomatically = true,
    this.onBack,
    this.centerTitle = false,
    this.pinned = false,
  });

  final String title;
  final List<Widget>? actions;
  final bool showBackAutomatically;
  final VoidCallback? onBack;
  final bool centerTitle;
  final bool pinned;

  @override
  Widget build(BuildContext context) {
    final routerState = GoRouterState.of(context);
    // Prefer matchedLocation for more reliable detection when redirects/params are involved
    final location = routerState.matchedLocation.isNotEmpty
        ? routerState.matchedLocation
        : routerState.uri.toString();

    // Use centralized tab root detection
    final isTabRoot = isTabRootPath(location);

    // Determine if we should show back button
    final canPopHere = context.canPop();
    final showBack = showBackAutomatically && !isTabRoot;

    void _handleBack() {
      if (onBack != null) {
        onBack!();
      } else if (canPopHere) {
        context.pop();
      } else {
        // Fallback to Home tab when no navigation history
        context.goNamed('tenantHome');
      }
    }

    return SliverAppBar(
      automaticallyImplyLeading: false,
      leading: showBack
          ? IconButton(
              onPressed: _handleBack,
              icon: const BackButtonIcon(),
              tooltip: AppLocalizations.of(context)?.navBack ?? 'Back',
            )
          : null,
      title: Text(title),
      centerTitle: centerTitle,
      actions: actions,
      pinned: pinned,
    );
  }
}
