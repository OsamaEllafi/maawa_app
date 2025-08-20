import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/theme/app_theme.dart';
import '../../widgets/common/app_top_bar.dart';

/// Admin dashboard screen with system overview
class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppTopBar(title: 'Admin Dashboard'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Spacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('System Overview', style: theme.textTheme.headlineMedium),
            SizedBox(height: Spacing.lg),

            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    context,
                    title: 'Total Users',
                    value: '12,345',
                    icon: Icons.people,
                    color: theme.colorScheme.primary,
                  ),
                ),
                SizedBox(width: Spacing.md),
                Expanded(
                  child: _buildStatCard(
                    context,
                    title: 'Properties',
                    value: '1,234',
                    icon: Icons.home,
                    color: AppColors.success500,
                  ),
                ),
              ],
            ),
            SizedBox(height: Spacing.md),

            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    context,
                    title: 'Bookings',
                    value: '5,678',
                    icon: Icons.calendar_month,
                    color: AppColors.warning500,
                  ),
                ),
                SizedBox(width: Spacing.md),
                Expanded(
                  child: _buildStatCard(
                    context,
                    title: 'Revenue',
                    value: '\$123K',
                    icon: Icons.attach_money,
                    color: AppColors.error500,
                  ),
                ),
              ],
            ),
            SizedBox(height: Spacing.lg),

            Text('Quick Actions', style: theme.textTheme.titleLarge),
            SizedBox(height: Spacing.md),

            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.people),
                    title: const Text('Manage Users'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      // TODO: Navigate to user management
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('Manage Properties'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      // TODO: Navigate to property management
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.account_balance_wallet),
                    title: const Text('Wallet Adjustments'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      // TODO: Navigate to wallet adjustments
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: EdgeInsets.all(Spacing.md),
        child: Column(
          children: [
            Icon(icon, size: 32, color: color),
            SizedBox(height: Spacing.sm),
            Text(
              value,
              style: theme.textTheme.titleLarge?.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(title, style: theme.textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
