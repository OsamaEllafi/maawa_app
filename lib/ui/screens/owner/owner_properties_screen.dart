import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/theme/app_theme.dart';

/// Owner properties screen for property management
class OwnerPropertiesScreen extends StatelessWidget {
  const OwnerPropertiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Properties'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // TODO: Add new property
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(Spacing.lg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.business,
                size: 80,
                color: theme.colorScheme.primary,
              ),
              SizedBox(height: Spacing.lg),
              Text(
                'Owner Properties',
                style: theme.textTheme.headlineMedium,
              ),
              SizedBox(height: Spacing.md),
              Text(
                'Manage your property listings and bookings',
                style: theme.textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: Spacing.lg),
              ElevatedButton(
                onPressed: () {
                  // TODO: Navigate to add property
                },
                child: const Text('Add First Property'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
