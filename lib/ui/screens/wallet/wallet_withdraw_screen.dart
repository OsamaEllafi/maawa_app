import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/theme/app_theme.dart';
import '../../widgets/common/app_top_bar.dart';

/// Wallet withdraw screen for withdrawing funds
class WalletWithdrawScreen extends StatefulWidget {
  const WalletWithdrawScreen({super.key});

  @override
  State<WalletWithdrawScreen> createState() => _WalletWithdrawScreenState();
}

class _WalletWithdrawScreenState extends State<WalletWithdrawScreen> {
  final _amountController = TextEditingController();
  String _selectedMethod = 'bank';
  bool _isLoading = false;
  final double _availableBalance = 2450.0;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppTopBar(
        title: 'Withdraw Funds',
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Spacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Available balance
            Card(
              color: theme.colorScheme.primaryContainer,
              child: Padding(
                padding: EdgeInsets.all(Spacing.md),
                child: Row(
                  children: [
                    Icon(
                      Icons.account_balance_wallet,
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                    SizedBox(width: Spacing.md),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Available to Withdraw',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onPrimaryContainer,
                          ),
                        ),
                        Text(
                          '\$${_availableBalance.toStringAsFixed(2)}',
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: theme.colorScheme.onPrimaryContainer,
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

            // Amount input
            Text('Amount to Withdraw', style: theme.textTheme.titleLarge),
            SizedBox(height: Spacing.md),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: 'Enter amount',
                prefixText: '\$ ',
                border: const OutlineInputBorder(),
                helperText: 'Minimum withdrawal: \$10.00',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: Spacing.lg),

            // Withdrawal method
            Text('Withdrawal Method', style: theme.textTheme.titleLarge),
            SizedBox(height: Spacing.md),
            
            RadioListTile<String>(
              title: Row(
                children: [
                  Icon(Icons.account_balance),
                  SizedBox(width: Spacing.sm),
                  const Text('Bank Transfer'),
                ],
              ),
              subtitle: const Text('Bank of America ****5678 • 1-3 business days'),
              value: 'bank',
              groupValue: _selectedMethod,
              onChanged: (value) => setState(() => _selectedMethod = value!),
            ),
            
            RadioListTile<String>(
              title: Row(
                children: [
                  Icon(Icons.payment),
                  SizedBox(width: Spacing.sm),
                  const Text('PayPal'),
                ],
              ),
              subtitle: const Text('user@example.com • Instant'),
              value: 'paypal',
              groupValue: _selectedMethod,
              onChanged: (value) => setState(() => _selectedMethod = value!),
            ),
            SizedBox(height: Spacing.lg),

            // Important info
            Card(
              color: theme.colorScheme.surfaceVariant,
              child: Padding(
                padding: EdgeInsets.all(Spacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        SizedBox(width: Spacing.sm),
                        Text(
                          'Important Information',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Spacing.sm),
                    Text(
                      '• Minimum withdrawal amount is \$10.00\n'
                      '• Bank transfers take 1-3 business days\n'
                      '• PayPal transfers are instant\n'
                      '• No fees for withdrawals over \$50',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(Spacing.md),
        child: SafeArea(
          child: ElevatedButton(
            onPressed: _canWithdraw() && !_isLoading ? _processWithdraw : null,
            child: _isLoading
                ? const CircularProgressIndicator()
                : const Text('Withdraw Funds'),
          ),
        ),
      ),
    );
  }

  bool _canWithdraw() {
    final amount = double.tryParse(_amountController.text) ?? 0;
    return amount >= 10 && amount <= _availableBalance;
  }

  void _processWithdraw() {
    setState(() => _isLoading = true);
    
    // Simulate withdrawal processing
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _isLoading = false);
        
        final amount = double.parse(_amountController.text);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Withdrawal Initiated'),
            content: Text(
              'Your withdrawal of \$${amount.toStringAsFixed(2)} has been initiated. '
              'You will receive the funds in your selected account within the specified timeframe.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  context.pop(); // Close dialog
                  context.pop(); // Go back to wallet
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    });
  }
}
