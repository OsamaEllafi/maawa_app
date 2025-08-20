import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../l10n/app_localizations.dart';
import '../../../app/navigation/app_router.dart';

/// Reusable app bar with automatic back button logic
class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBackAutomatically;
  final VoidCallback? onBack;
  final bool centerTitle;

  const AppTopBar({
    super.key,
    required this.title,
    this.actions,
    this.showBackAutomatically = true,
    this.onBack,
    this.centerTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    final loc = GoRouterState.of(context).uri.toString();
    final isTabRoot = _isTabRoot(loc);
    final canPopHere = context.canPop();
    final showBack = showBackAutomatically && !isTabRoot && canPopHere;

    return AppBar(
      automaticallyImplyLeading: false,
      leading: showBack
          ? IconButton(
              onPressed: onBack ?? () => context.pop(),
              icon: const BackButtonIcon(),
              tooltip: AppLocalizations.of(context)?.navBack ?? 'Back',
            )
          : null,
      title: Text(title),
      centerTitle: centerTitle,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  /// Check if current location is a tab root
  bool _isTabRoot(String location) {
    const tabRootPaths = [
      '/tenant/home',
      '/tenant/bookings/my',
      '/tenant/wallet',
      '/tenant/profile',
    ];

    return tabRootPaths.any((path) => location.startsWith(path));
  }
}
