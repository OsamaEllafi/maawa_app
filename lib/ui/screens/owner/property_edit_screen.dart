import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/theme/app_theme.dart';
import '../../widgets/common/app_top_bar.dart';

/// Property edit screen for owners
class PropertyEditScreen extends StatelessWidget {
  const PropertyEditScreen({
    super.key,
    required this.propertyId,
  });

  final String propertyId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppTopBar(
        title: l10n.edit,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(Spacing.lg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.edit,
                size: 80,
                color: theme.colorScheme.primary,
              ),
              SizedBox(height: Spacing.lg),
              Text(
                'Edit Property',
                style: theme.textTheme.headlineMedium,
              ),
              SizedBox(height: Spacing.md),
              Text(
                'Property ID: $propertyId',
                style: theme.textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: Spacing.md),
              Text(
                'Property editing form will be implemented here',
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
