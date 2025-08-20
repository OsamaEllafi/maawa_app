import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../l10n/app_localizations.dart';
import '../../core/theme/app_theme.dart';
import '../../app/navigation/app_router.dart';

/// Bottom navigation bar for main tenant functionality
class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final location = GoRouterState.of(context).uri.toString();
    final currentIndex = AppRouter.getBottomNavIndex(location);

    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: (index) => _onDestinationSelected(context, index),
      destinations: [
        NavigationDestination(
          icon: const Icon(Icons.home_outlined),
          selectedIcon: const Icon(Icons.home),
          label: l10n.home,
        ),
        NavigationDestination(
          icon: const Icon(Icons.calendar_month_outlined),
          selectedIcon: const Icon(Icons.calendar_month),
          label: l10n.bookings,
        ),
        NavigationDestination(
          icon: const Icon(Icons.wallet_outlined),
          selectedIcon: const Icon(Icons.wallet),
          label: l10n.wallet,
        ),
        NavigationDestination(
          icon: const Icon(Icons.person_outline),
          selectedIcon: const Icon(Icons.person),
          label: l10n.profile,
        ),
      ],
    );
  }

  void _onDestinationSelected(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(AppRouter.tenantHome);
        break;
      case 1:
        context.go(AppRouter.myBookings);
        break;
      case 2:
        context.go(AppRouter.wallet);
        break;
      case 3:
        context.go(AppRouter.profile);
        break;
    }
  }
}
