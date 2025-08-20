import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../demo/demo_data.dart';
import '../../widgets/common/app_top_bar.dart';

/// Wallet withdrawal screen for withdrawing funds
class WalletWithdrawScreen extends StatefulWidget {
  const WalletWithdrawScreen({super.key});

  @override
  State<WalletWithdrawScreen> createState() => _WalletWithdrawScreenState();
}

class _WalletWithdrawScreenState extends State<WalletWithdrawScreen> {
  final _amountController = TextEditingController();
  final _bankAccountController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _amountController.dispose();
    _bankAccountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppTopBar(title: l10n.withdraw),
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
                            'Available Balance',
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

            // Amount input
            Text('Withdrawal Amount', style: theme.textTheme.titleLarge),
            SizedBox(height: Spacing.md),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: 'Amount',
                prefixText: '${CurrencyFormatter.symbol} ',
                border: const OutlineInputBorder(),
                hintText: 'Enter amount to withdraw',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: Spacing.lg),

            // Bank account details
            Text('Bank Account Details', style: theme.textTheme.titleLarge),
            SizedBox(height: Spacing.md),
            Card(
              child: Padding(
                padding: EdgeInsets.all(Spacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.account_balance,
                          color: theme.colorScheme.primary,
                        ),
                        SizedBox(width: Spacing.sm),
                        Text(
                          'Bank Account',
                          style: theme.textTheme.titleMedium,
                        ),
                      ],
                    ),
                    SizedBox(height: Spacing.md),
                    TextField(
                      controller: _bankAccountController,
                      decoration: InputDecoration(
                        labelText: 'IBAN Number',
                        border: const OutlineInputBorder(),
                        hintText: 'Enter your IBAN number',
                      ),
                      keyboardType: TextInputType.text,
                      textDirection: TextDirection.ltr, // IBAN is always LTR
                    ),
                    SizedBox(height: Spacing.md),
                    Text(
                      'Funds will be transferred to your bank account within 2-3 business days.',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: Spacing.lg),

            // Summary
            Card(
              child: Padding(
                padding: EdgeInsets.all(Spacing.md),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Withdrawal Amount',
                          style: theme.textTheme.bodyMedium,
                        ),
                        Text(
                          _getAmountText(),
                          style: theme.textTheme.titleMedium,
                        ),
                      ],
                    ),
                    SizedBox(height: Spacing.sm),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Processing Fee',
                          style: theme.textTheme.bodyMedium,
                        ),
                        Text(
                          CurrencyFormatter.formatLYD(5),
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'You will receive',
                          style: theme.textTheme.titleMedium,
                        ),
                        Text(
                          _getNetAmountText(),
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
                onPressed: _canWithdraw() && !_isLoading
                    ? _processWithdrawal
                    : null,
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
                        'Withdraw ${_getAmountText()}',
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

  String _getAmountText() {
    final amount = _getAmount();
    if (amount == null || amount <= 0) {
      return CurrencyFormatter.formatLYD(0);
    }
    return CurrencyFormatter.formatLYD(amount);
  }

  String _getNetAmountText() {
    final amount = _getAmount();
    if (amount == null || amount <= 0) {
      return CurrencyFormatter.formatLYD(0);
    }
    final netAmount = amount - 5; // Processing fee
    return CurrencyFormatter.formatLYD(netAmount > 0 ? netAmount : 0);
  }

  double? _getAmount() {
    return double.tryParse(_amountController.text);
  }

  bool _canWithdraw() {
    final amount = _getAmount();
    final iban = _bankAccountController.text.trim();

    return amount != null &&
        amount > 0 &&
        amount <= DemoData.walletBalance &&
        iban.isNotEmpty &&
        _isValidIBAN(iban);
  }

  bool _isValidIBAN(String iban) {
    // Basic IBAN validation (LY format: LY + 2 digits + 3 letters + 16 digits)
    final ibanRegex = RegExp(r'^LY\d{2}[A-Z]{3}\d{16}$');
    return ibanRegex.hasMatch(iban.replaceAll(RegExp(r'\s'), ''));
  }

  void _processWithdrawal() {
    final amount = _getAmount();
    if (amount == null || amount <= 0) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.warning, color: AppColors.warning500),
            SizedBox(width: Spacing.sm),
            Text('Confirm Withdrawal'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Are you sure you want to withdraw ${CurrencyFormatter.formatLYD(amount)}?',
            ),
            SizedBox(height: Spacing.md),
            Text(
              'Processing fee: ${CurrencyFormatter.formatLYD(5)}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            SizedBox(height: Spacing.sm),
            Text(
              'You will receive: ${CurrencyFormatter.formatLYD(amount - 5)}',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _confirmWithdrawal();
            },
            child: Text('Confirm'),
          ),
        ],
      ),
    );
  }

  void _confirmWithdrawal() async {
    final amount = _getAmount();
    if (amount == null || amount <= 0) return;

    setState(() => _isLoading = true);

    // Simulate processing delay
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() => _isLoading = false);

    // Add transaction to demo data
    final newTransaction = DemoTransaction(
      id: 'txn_${DateTime.now().millisecondsSinceEpoch}',
      type: DemoTransactionType.withdrawal,
      title: 'Withdrawal',
      subtitle: 'Bank Transfer',
      amount: -amount, // Negative for withdrawal
      date: DateTime.now(),
      status: DemoTransactionStatus.pending,
    );

    DemoData.addTransaction(newTransaction);

    // Show success message
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.check_circle, color: AppColors.success500),
            SizedBox(width: Spacing.sm),
            Text('Withdrawal Requested'),
          ],
        ),
        content: Text(
          'Your withdrawal request has been submitted. You will receive the funds in 2-3 business days.',
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
}
