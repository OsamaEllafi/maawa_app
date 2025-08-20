import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/theme/app_theme.dart';
import '../../../app/navigation/app_router.dart';

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
            onPressed: () => context.go(AppRouter.walletHistory),
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
                    theme.colorScheme.primary.withOpacity(0.8),
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
                      color: theme.colorScheme.onPrimary.withOpacity(0.9),
                    ),
                  ),
                  SizedBox(height: Spacing.sm),
                  Text(
                    '\$2,450.00',
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
                          onPressed: () => context.go(AppRouter.walletTopup),
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
                          onPressed: () => context.go(AppRouter.walletWithdraw),
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
                    amount: '\$850',
                    subtitle: 'Spent on bookings',
                    icon: Icons.trending_down,
                    color: AppColors.error500,
                  ),
                ),
                SizedBox(width: Spacing.md),
                Expanded(
                  child: _buildStatCard(
                    context,
                    title: 'Earned',
                    amount: '\$320',
                    subtitle: 'From referrals',
                    icon: Icons.trending_up,
                    color: AppColors.success500,
                  ),
                ),
              ],
            ),
            SizedBox(height: Spacing.lg),

            // Recent transactions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recent Transactions', style: theme.textTheme.titleLarge),
                TextButton(
                  onPressed: () => context.go(AppRouter.walletHistory),
                  child: const Text('View All'),
                ),
              ],
            ),
            SizedBox(height: Spacing.md),

            ...List.generate(
              5,
              (index) => _buildTransactionItem(context, index),
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
                Text(title, style: theme.textTheme.bodyMedium),
              ],
            ),
            SizedBox(height: Spacing.sm),
            Text(
              amount,
              style: theme.textTheme.titleLarge?.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(subtitle, style: theme.textTheme.bodySmall),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionItem(BuildContext context, int index) {
    final theme = Theme.of(context);
    final transactions = [
      {
        'type': 'booking',
        'title': 'Booking Payment',
        'subtitle': 'Downtown Apartment',
        'amount': '-\$450.00',
        'date': '2 days ago',
        'icon': Icons.home,
        'color': AppColors.error500,
      },
      {
        'type': 'topup',
        'title': 'Wallet Top-up',
        'subtitle': 'Credit Card ****1234',
        'amount': '+\$500.00',
        'date': '1 week ago',
        'icon': Icons.add_circle,
        'color': AppColors.success500,
      },
      {
        'type': 'refund',
        'title': 'Booking Refund',
        'subtitle': 'Cancelled booking',
        'amount': '+\$200.00',
        'date': '2 weeks ago',
        'icon': Icons.undo,
        'color': AppColors.success500,
      },
      {
        'type': 'fee',
        'title': 'Service Fee',
        'subtitle': 'Monthly fee',
        'amount': '-\$5.00',
        'date': '3 weeks ago',
        'icon': Icons.receipt,
        'color': AppColors.error500,
      },
      {
        'type': 'referral',
        'title': 'Referral Bonus',
        'subtitle': 'Friend joined Maawa',
        'amount': '+\$25.00',
        'date': '1 month ago',
        'icon': Icons.people,
        'color': AppColors.success500,
      },
    ];

    final transaction = transactions[index];

    return Card(
      margin: EdgeInsets.only(bottom: Spacing.sm),
      child: Padding(
        padding: EdgeInsets.all(Spacing.md),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(Spacing.sm),
              decoration: BoxDecoration(
                color: (transaction['color'] as Color).withOpacity(0.1),
                borderRadius: BorderRadius.circular(BorderRadiusTokens.small),
              ),
              child: Icon(
                transaction['icon'] as IconData,
                color: transaction['color'] as Color,
                size: 20,
              ),
            ),
            SizedBox(width: Spacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction['title'] as String,
                    style: theme.textTheme.titleSmall,
                  ),
                  Text(
                    transaction['subtitle'] as String,
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  transaction['amount'] as String,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: transaction['color'] as Color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  transaction['date'] as String,
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
