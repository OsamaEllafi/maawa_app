import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/theme/app_theme.dart';
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
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppTopBar(
        title: 'Top Up Wallet',
      ),
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
                    Icon(Icons.account_balance_wallet, color: theme.colorScheme.primary),
                    SizedBox(width: Spacing.md),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Current Balance', style: theme.textTheme.bodyMedium),
                        Text('\$2,450.00', style: theme.textTheme.titleLarge),
                      ],
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
                  label: Text('\$${amount.toInt()}'),
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
                prefixText: '\$ ',
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
            
            RadioListTile<String>(
              title: Row(
                children: [
                  Icon(Icons.credit_card),
                  SizedBox(width: Spacing.sm),
                  const Text('Credit/Debit Card'),
                ],
              ),
              subtitle: const Text('****1234'),
              value: 'card',
              groupValue: _selectedPaymentMethod,
              onChanged: (value) => setState(() => _selectedPaymentMethod = value!),
            ),
            
            RadioListTile<String>(
              title: Row(
                children: [
                  Icon(Icons.account_balance),
                  SizedBox(width: Spacing.sm),
                  const Text('Bank Transfer'),
                ],
              ),
              subtitle: const Text('Bank of America ****5678'),
              value: 'bank',
              groupValue: _selectedPaymentMethod,
              onChanged: (value) => setState(() => _selectedPaymentMethod = value!),
            ),
            
            RadioListTile<String>(
              title: Row(
                children: [
                  Icon(Icons.payment),
                  SizedBox(width: Spacing.sm),
                  const Text('PayPal'),
                ],
              ),
              subtitle: const Text('user@example.com'),
              value: 'paypal',
              groupValue: _selectedPaymentMethod,
              onChanged: (value) => setState(() => _selectedPaymentMethod = value!),
            ),
            SizedBox(height: Spacing.lg),

            // Summary
            Card(
              child: Padding(
                padding: EdgeInsets.all(Spacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Summary', style: theme.textTheme.titleMedium),
                    SizedBox(height: Spacing.md),
                    _buildSummaryRow('Amount', '\$${_selectedAmount.toStringAsFixed(2)}'),
                    _buildSummaryRow('Processing Fee', '\$${(_selectedAmount * 0.029).toStringAsFixed(2)}'),
                    Divider(),
                    _buildSummaryRow(
                      'Total', 
                      '\$${(_selectedAmount + (_selectedAmount * 0.029)).toStringAsFixed(2)}',
                      isTotal: true,
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
            onPressed: _selectedAmount > 0 && !_isLoading ? _processTopUp : null,
            child: _isLoading
                ? const CircularProgressIndicator()
                : Text('Add \$${_selectedAmount.toStringAsFixed(2)}'),
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String amount, {bool isTotal = false}) {
    final theme = Theme.of(context);
    final style = isTotal 
        ? theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)
        : theme.textTheme.bodyMedium;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: Spacing.xs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text(amount, style: style),
        ],
      ),
    );
  }

  void _processTopUp() {
    setState(() => _isLoading = true);
    
    // Simulate payment processing
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _isLoading = false);
        
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Top-up Successful'),
            content: Text('Your wallet has been topped up with \$${_selectedAmount.toStringAsFixed(2)}'),
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
