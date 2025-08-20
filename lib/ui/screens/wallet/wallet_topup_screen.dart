import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../demo/demo_data.dart';
import '../../widgets/common/app_top_bar.dart';

/// Wallet top-up screen for adding funds
class WalletTopupScreen extends StatefulWidget {
  const WalletTopupScreen({super.key});

  @override
  State<WalletTopupScreen> createState() => _WalletTopupScreenState();
}

class _WalletTopupScreenState extends State<WalletTopupScreen> {
  double _selectedAmount = 50.0;
  final _customAmountController = TextEditingController();
  String _selectedPaymentMethod = 'card';
  bool _isLoading = false;

  final List<double> _quickAmounts = [25, 50, 100, 200, 500];

  @override
  void dispose() {
    _customAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppTopBar(title: 'Top Up Wallet'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Spacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current balance
            Card(
              child: Padding(
                padding: EdgeInsets.all(Spacing.md),
                child: Row(
                  children: [
                    Icon(
                      Icons.account_balance_wallet,
                      color: theme.colorScheme.primary,
                    ),
                    SizedBox(width: Spacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Current Balance',
                            style: theme.textTheme.bodyMedium,
                          ),
                          Text(
                            CurrencyFormatter.formatLYD(DemoData.walletBalance),
                            style: theme.textTheme.titleLarge,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: Spacing.lg),

            // Amount selection
            Text('Select Amount', style: theme.textTheme.titleLarge),
            SizedBox(height: Spacing.md),
            Wrap(
              spacing: Spacing.sm,
              runSpacing: Spacing.sm,
              children: _quickAmounts.map((amount) {
                final isSelected = _selectedAmount == amount;
                return ChoiceChip(
                  label: Text(CurrencyFormatter.formatLYD(amount)),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        _selectedAmount = amount;
                        _customAmountController.clear();
                      });
                    }
                  },
                );
              }).toList(),
            ),
            SizedBox(height: Spacing.md),

            // Custom amount
            TextField(
              controller: _customAmountController,
              decoration: InputDecoration(
                labelText: 'Custom Amount',
                prefixText: '${CurrencyFormatter.symbol} ',
                border: const OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                final amount = double.tryParse(value);
                if (amount != null) {
                  setState(() => _selectedAmount = amount);
                }
              },
            ),
            SizedBox(height: Spacing.lg),

            // Payment method
            Text('Payment Method', style: theme.textTheme.titleLarge),
            SizedBox(height: Spacing.md),
            Card(
              child: Column(
                children: [
                  RadioListTile<String>(
                    title: Row(
                      children: [
                        Icon(
                          Icons.credit_card,
                          color: theme.colorScheme.primary,
                        ),
                        SizedBox(width: Spacing.sm),
                        Text('Credit/Debit Card'),
                      ],
                    ),
                    subtitle: Text('Visa, Mastercard, American Express'),
                    value: 'card',
                    groupValue: _selectedPaymentMethod,
                    onChanged: (value) {
                      setState(() => _selectedPaymentMethod = value!);
                    },
                  ),
                  Divider(height: 1),
                  RadioListTile<String>(
                    title: Row(
                      children: [
                        Icon(
                          Icons.account_balance,
                          color: theme.colorScheme.primary,
                        ),
                        SizedBox(width: Spacing.sm),
                        Text('Bank Transfer'),
                      ],
                    ),
                    subtitle: Text('Direct bank transfer'),
                    value: 'bank',
                    groupValue: _selectedPaymentMethod,
                    onChanged: (value) {
                      setState(() => _selectedPaymentMethod = value!);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: Spacing.xl),

            // Summary
            Card(
              child: Padding(
                padding: EdgeInsets.all(Spacing.md),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Amount', style: theme.textTheme.bodyMedium),
                        Text(
                          CurrencyFormatter.formatLYD(_selectedAmount),
                          style: theme.textTheme.titleMedium,
                        ),
                      ],
                    ),
                    SizedBox(height: Spacing.sm),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Fee', style: theme.textTheme.bodyMedium),
                        Text(
                          CurrencyFormatter.formatLYD(0),
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total', style: theme.textTheme.titleMedium),
                        Text(
                          CurrencyFormatter.formatLYD(_selectedAmount),
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: Spacing.lg),

            // Submit button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _canSubmit() && !_isLoading ? _processTopup : null,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: Spacing.md),
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                ),
                child: _isLoading
                    ? SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          color: theme.colorScheme.onPrimary,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        'Top Up ${CurrencyFormatter.formatLYD(_selectedAmount)}',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _canSubmit() {
    return _selectedAmount > 0;
  }

  void _processTopup() async {
    if (!_canSubmit()) return;

    setState(() => _isLoading = true);

    // Show mock processing dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(width: Spacing.md),
            Text('Processing...'),
          ],
        ),
        content: Text('Please wait while we process your top-up request.'),
      ),
    );

    // Simulate processing delay
    await Future.delayed(const Duration(milliseconds: 700));

    if (!mounted) return;

    // Close processing dialog
    Navigator.of(context).pop();

    setState(() => _isLoading = false);

    // Simulate success/failure (90% success rate for demo)
    final isSuccess = DateTime.now().millisecond % 10 != 0;

    if (isSuccess) {
      // Add transaction to demo data
      final newTransaction = DemoTransaction(
        id: 'txn_${DateTime.now().millisecondsSinceEpoch}',
        type: DemoTransactionType.topup,
        title: 'Wallet Top-up',
        subtitle: _selectedPaymentMethod == 'card'
            ? 'Credit Card'
            : 'Bank Transfer',
        amount: _selectedAmount,
        date: DateTime.now(),
        status: DemoTransactionStatus.completed,
      );

      DemoData.addTransaction(newTransaction);

      _showSuccessDialog();
    } else {
      _showFailureDialog();
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.check_circle, color: AppColors.success500),
            SizedBox(width: Spacing.sm),
            Text('Top-up Successful'),
          ],
        ),
        content: Text(
          'Your wallet has been topped up with ${CurrencyFormatter.formatLYD(_selectedAmount)}.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showFailureDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.error, color: AppColors.error500),
            SizedBox(width: Spacing.sm),
            Text('Top-up Failed'),
          ],
        ),
        content: Text(
          'Unable to process your top-up request. Please try again or contact support.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Try Again'),
          ),
        ],
      ),
    );
  }
}
