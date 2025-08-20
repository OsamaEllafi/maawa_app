import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/theme/app_theme.dart';

/// Owner bookings screen for managing property bookings
class OwnerBookingsScreen extends StatelessWidget {
  const OwnerBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.bookings),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(Spacing.lg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.calendar_month,
                size: 80,
                color: theme.colorScheme.primary,
              ),
              SizedBox(height: Spacing.lg),
              Text(
                'Property Bookings',
                style: theme.textTheme.headlineMedium,
              ),
              SizedBox(height: Spacing.md),
              Text(
                'Manage bookings for all your properties',
                style: theme.textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
