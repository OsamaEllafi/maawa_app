import 'package:flutter/material.dart';
import 'dart:async'; // Added for Timer
import '../../../core/theme/app_theme.dart';
import '../../../demo/demo_data.dart';
import '../../widgets/common/app_top_bar.dart';
import '../../widgets/wallet/transaction_item.dart';

/// Wallet history screen showing all transactions
class WalletHistoryScreen extends StatefulWidget {
  const WalletHistoryScreen({super.key});

  @override
  State<WalletHistoryScreen> createState() => _WalletHistoryScreenState();
}

class _WalletHistoryScreenState extends State<WalletHistoryScreen> {
  bool _isLoading = true;
  String _selectedFilter = 'all';
  Timer? _debounceTimer;

  final List<String> _filters = ['all', 'topup', 'withdrawal', 'booking', 'adjustment'];

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _loadTransactions() async {
    // Simulate loading delay
    await Future.delayed(const Duration(milliseconds: 400));
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  void _onFilterChanged(String filter) {
    // Debounce filter changes to prevent skeleton/content overlap
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _selectedFilter = filter;
          _isLoading = true;
        });
        _loadTransactions();
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppTopBar(
        title: 'Transaction History',
      ),
      body: Column(
        children: [
          // Filter chips
          Container(
            padding: EdgeInsets.all(Spacing.md),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _filters.map((filter) {
                  final isSelected = _selectedFilter == filter;
                  return Padding(
                    padding: EdgeInsets.only(right: Spacing.sm),
                    child: FilterChip(
                      label: Text(_getFilterLabel(filter)),
                      selected: isSelected,
                      onSelected: (selected) {
                        if (selected) {
                          _onFilterChanged(filter);
                        }
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          // Transaction list
          Expanded(
            child: _isLoading
                ? _buildSkeletonList()
                : _buildTransactionList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSkeletonList() {
    return ListView.builder(
      padding: EdgeInsets.all(Spacing.md),
      itemCount: 10,
      itemBuilder: (context, index) => _buildSkeletonItem(),
    );
  }

  Widget _buildSkeletonItem() {
    final theme = Theme.of(context);
    return Card(
      margin: EdgeInsets.only(bottom: Spacing.sm),
      child: Padding(
        padding: EdgeInsets.all(Spacing.md),
        child: Row(
          children: [
            // Icon skeleton
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(BorderRadiusTokens.medium),
              ),
            ),
            SizedBox(width: Spacing.md),
            // Content skeleton
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 16,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  SizedBox(height: Spacing.xs),
                  Container(
                    height: 14,
                    width: 120,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  SizedBox(height: Spacing.xs),
                  Container(
                    height: 12,
                    width: 80,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),
            // Amount skeleton
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  height: 16,
                  width: 80,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                SizedBox(height: Spacing.xs),
                Container(
                  height: 12,
                  width: 60,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionList() {
    final filteredTransactions = _getFilteredTransactions();

    if (filteredTransactions.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: EdgeInsets.all(Spacing.md),
      itemCount: filteredTransactions.length,
      itemBuilder: (context, index) {
        final transaction = filteredTransactions[index];
        return TransactionItem(
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
        );
      },
    );
  }

  Widget _buildEmptyState() {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long,
            size: 64,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          SizedBox(height: Spacing.md),
          Text(
            'No transactions found',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: Spacing.sm),
          Text(
            'Your transaction history will appear here',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  List<DemoTransaction> _getFilteredTransactions() {
    if (_selectedFilter == 'all') {
      return DemoData.transactions;
    }

    final filterType = _getFilterType(_selectedFilter);
    return DemoData.filteredTransactions(filterType);
  }

  String _getFilterLabel(String filter) {
    switch (filter) {
      case 'all':
        return 'All';
      case 'topup':
        return 'Top-ups';
      case 'withdrawal':
        return 'Withdrawals';
      case 'booking':
        return 'Bookings';
      case 'adjustment':
        return 'Adjustments';
      default:
        return 'All';
    }
  }

  DemoTransactionType? _getFilterType(String filter) {
    switch (filter) {
      case 'topup':
        return DemoTransactionType.topup;
      case 'withdrawal':
        return DemoTransactionType.withdrawal;
      case 'booking':
        return DemoTransactionType.booking;
      case 'adjustment':
        return DemoTransactionType.adjustment;
      default:
        return null;
    }
  }
}
