import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../demo/demo_data.dart';
import '../../../app/navigation/app_router.dart';
import '../../widgets/wallet/transaction_item.dart';

/// Wallet screen showing balance and recent transactions
class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.wallet),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => context.pushNamed(AppRouter.walletHistory),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Spacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Balance card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(Spacing.lg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    theme.colorScheme.primary,
                    theme.colorScheme.primary.withValues(alpha: 0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(BorderRadiusTokens.large),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Available Balance',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onPrimary.withValues(alpha: 0.9),
                    ),
                  ),
                  SizedBox(height: Spacing.sm),
                  Text(
                    CurrencyFormatter.formatLYD(DemoData.walletBalance),
                    style: theme.textTheme.displaySmall?.copyWith(
                      color: theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: Spacing.lg),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => context.pushNamed(AppRouter.walletTopup),
                          icon: const Icon(Icons.add),
                          label: const Text('Top Up'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.onPrimary,
                            foregroundColor: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                      SizedBox(width: Spacing.md),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () =>
                              context.pushNamed(AppRouter.walletWithdraw),
                          icon: const Icon(Icons.remove),
                          label: const Text('Withdraw'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: theme.colorScheme.onPrimary,
                            side: BorderSide(
                              color: theme.colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: Spacing.xl),

            // Quick stats
            Text('Overview', style: theme.textTheme.titleLarge),
            SizedBox(height: Spacing.md),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    context,
                    title: 'This Month',
                    amount: CurrencyFormatter.formatLYD(850),
                    subtitle: 'Spent on bookings',
                    icon: Icons.trending_down,
                    color: theme.colorScheme.error,
                  ),
                ),
                SizedBox(width: Spacing.md),
                Expanded(
                  child: _buildStatCard(
                    context,
                    title: 'Earned',
                    amount: CurrencyFormatter.formatLYD(320),
                    subtitle: 'From referrals',
                    icon: Icons.trending_up,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
            SizedBox(height: Spacing.lg),

            // Recent transactions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Recent Transactions', 
                    style: theme.textTheme.titleLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                TextButton(
                  onPressed: () => context.pushNamed(AppRouter.walletHistory),
                  child: const Text('View All'),
                ),
              ],
            ),
            SizedBox(height: Spacing.md),

            // Transaction list
            ...DemoData.transactions.take(5).map((transaction) => 
              TransactionItem(
                transaction: transaction,
                onTap: () {
                  // Could navigate to transaction detail in the future
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Transaction: ${transaction.title}'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
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
    required String amount,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: EdgeInsets.all(Spacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 20),
                SizedBox(width: Spacing.sm),
                Expanded(
                  child: Text(
                    title, 
                    style: theme.textTheme.bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: Spacing.sm),
            Text(
              amount,
              style: theme.textTheme.titleLarge?.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              subtitle, 
              style: theme.textTheme.bodySmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
