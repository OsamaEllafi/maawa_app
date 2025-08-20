import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/theme/app_theme.dart';
import '../../../app/navigation/app_router.dart';

/// Home screen with property search and recommendations
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.home),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.home_rounded,
              size: 64,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              l10n.home,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Tenant Home Screen',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(BorderRadiusTokens.medium),
        child: Padding(
          padding: EdgeInsets.all(Spacing.md),
          child: Column(
            children: [
              Icon(icon, size: 32, color: theme.colorScheme.primary),
              SizedBox(height: Spacing.sm),
              Text(title, style: theme.textTheme.titleMedium),
              Text(subtitle, style: theme.textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPropertyCard(BuildContext context, int index) {
    final theme = Theme.of(context);
    
    return Container(
      width: 200,
      margin: EdgeInsetsDirectional.only(end: Spacing.sm),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => AppRouter.goToProperty(context, 'property_$index'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 120,
                color: theme.colorScheme.surfaceVariant,
                child: Center(
                  child: Icon(
                    Icons.image,
                    size: 40,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(Spacing.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Beautiful Property ${index + 1}',
                      style: theme.textTheme.titleSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: Spacing.xs),
                    Text(
                      'Downtown Area',
                      style: theme.textTheme.bodySmall,
                    ),
                    SizedBox(height: Spacing.xs),
                    Row(
                      children: [
                        Icon(Icons.star, size: 16, color: AppColors.warning500),
                        SizedBox(width: Spacing.xs),
                        Text('4.${5 + index}', style: theme.textTheme.bodySmall),
                        const Spacer(),
                        Text(
                          '\$${100 + index * 50}/night',
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchChip(String label) {
    return ActionChip(
      label: Text(label),
      onPressed: () {
        // TODO: Implement search functionality
      },
    );
  }
}
