import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/theme/app_theme.dart';
import '../../widgets/common/app_top_bar.dart';

/// Wallet history screen showing all transactions
class WalletHistoryScreen extends StatefulWidget {
  const WalletHistoryScreen({super.key});

  @override
  State<WalletHistoryScreen> createState() => _WalletHistoryScreenState();
}

class _WalletHistoryScreenState extends State<WalletHistoryScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction History'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Top-ups'),
            Tab(text: 'Withdrawals'),
            Tab(text: 'Bookings'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTransactionsList('all'),
          _buildTransactionsList('topup'),
          _buildTransactionsList('withdrawal'),
          _buildTransactionsList('booking'),
        ],
      ),
    );
  }

  Widget _buildTransactionsList(String filter) {
    final transactions = _getFilteredTransactions(filter);
    
    return ListView.builder(
      padding: EdgeInsets.all(Spacing.md),
      itemCount: transactions.length,
      itemBuilder: (context, index) => _buildTransactionItem(transactions[index]),
    );
  }

  Widget _buildTransactionItem(Map<String, dynamic> transaction) {
    final theme = Theme.of(context);
    
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
                size: 24,
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
                  SizedBox(height: Spacing.xs),
                  Row(
                    children: [
                      Text(
                        transaction['date'] as String,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      SizedBox(width: Spacing.sm),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: Spacing.xs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(transaction['status']).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(BorderRadiusTokens.small),
                        ),
                        child: Text(
                          transaction['status'] as String,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: _getStatusColor(transaction['status']),
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  transaction['amount'] as String,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: transaction['color'] as Color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (transaction['fee'] != null)
                  Text(
                    'Fee: ${transaction['fee']}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'completed':
        return AppColors.success500;
      case 'pending':
        return AppColors.warning500;
      case 'failed':
        return AppColors.error500;
      default:
        return AppColors.surface500;
    }
  }

  List<Map<String, dynamic>> _getFilteredTransactions(String filter) {
    final allTransactions = [
      {
        'type': 'booking',
        'title': 'Booking Payment',
        'subtitle': 'Downtown Apartment - Booking #BK123',
        'amount': '-\$450.00',
        'date': 'Dec 20, 2024',
        'status': 'completed',
        'icon': Icons.home,
        'color': AppColors.error500,
      },
      {
        'type': 'topup',
        'title': 'Wallet Top-up',
        'subtitle': 'Credit Card ****1234',
        'amount': '+\$500.00',
        'fee': '\$14.50',
        'date': 'Dec 15, 2024',
        'status': 'completed',
        'icon': Icons.add_circle,
        'color': AppColors.success500,
      },
      {
        'type': 'withdrawal',
        'title': 'Bank Withdrawal',
        'subtitle': 'Bank of America ****5678',
        'amount': '-\$300.00',
        'date': 'Dec 10, 2024',
        'status': 'pending',
        'icon': Icons.remove_circle,
        'color': AppColors.error500,
      },
      {
        'type': 'booking',
        'title': 'Booking Refund',
        'subtitle': 'Cancelled booking - Beach Villa',
        'amount': '+\$200.00',
        'date': 'Dec 5, 2024',
        'status': 'completed',
        'icon': Icons.undo,
        'color': AppColors.success500,
      },
      {
        'type': 'topup',
        'title': 'PayPal Top-up',
        'subtitle': 'user@example.com',
        'amount': '+\$100.00',
        'date': 'Dec 1, 2024',
        'status': 'completed',
        'icon': Icons.add_circle,
        'color': AppColors.success500,
      },
      {
        'type': 'booking',
        'title': 'Service Fee',
        'subtitle': 'Monthly maintenance fee',
        'amount': '-\$5.00',
        'date': 'Nov 30, 2024',
        'status': 'completed',
        'icon': Icons.receipt,
        'color': AppColors.error500,
      },
      {
        'type': 'referral',
        'title': 'Referral Bonus',
        'subtitle': 'Friend Sarah joined Maawa',
        'amount': '+\$25.00',
        'date': 'Nov 25, 2024',
        'status': 'completed',
        'icon': Icons.people,
        'color': AppColors.success500,
      },
      {
        'type': 'withdrawal',
        'title': 'Failed Withdrawal',
        'subtitle': 'Insufficient bank account info',
        'amount': '-\$150.00',
        'date': 'Nov 20, 2024',
        'status': 'failed',
        'icon': Icons.error,
        'color': AppColors.error500,
      },
    ];

    if (filter == 'all') {
      return allTransactions;
    }

    return allTransactions.where((transaction) {
      switch (filter) {
        case 'topup':
          return transaction['type'] == 'topup';
        case 'withdrawal':
          return transaction['type'] == 'withdrawal';
        case 'booking':
          return transaction['type'] == 'booking' || transaction['type'] == 'referral';
        default:
          return true;
      }
    }).toList();
  }
}
