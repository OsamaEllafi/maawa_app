import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../demo/demo_data.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../widgets/common/app_top_bar.dart';

/// Admin wallet adjustment screen
class AdminWalletAdjustScreen extends StatefulWidget {
  const AdminWalletAdjustScreen({super.key});

  @override
  State<AdminWalletAdjustScreen> createState() => _AdminWalletAdjustScreenState();
}

class _AdminWalletAdjustScreenState extends State<AdminWalletAdjustScreen> {
  final _formKey = GlobalKey<FormState>();
  final _userIdController = TextEditingController();
  final _amountController = TextEditingController();
  final _reasonController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _userIdController.dispose();
    _amountController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppTopBar(title: 'Wallet Adjustment'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Spacing.md),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                'Adjust User Wallet Balance',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: Spacing.sm),
              Text(
                'Add or subtract funds from a user\'s wallet balance',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              SizedBox(height: Spacing.xl),

              // User ID field
              _buildUserIdField(context, theme),
              SizedBox(height: Spacing.lg),

              // Amount field
              _buildAmountField(context, theme),
              SizedBox(height: Spacing.lg),

              // Reason field
              _buildReasonField(context, theme),
              SizedBox(height: Spacing.xl),

              // Submit button
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _isSubmitting ? null : _submitAdjustment,
                  style: FilledButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: Spacing.md),
                  ),
                  child: _isSubmitting
                      ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: theme.colorScheme.onPrimary,
                          ),
                        )
                      : const Text('Submit Adjustment'),
                ),
              ),
              SizedBox(height: Spacing.xl),

              // Recent adjustments
              _buildRecentAdjustments(context, theme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserIdField(BuildContext context, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'User ID',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: Spacing.sm),
        TextFormField(
          controller: _userIdController,
          decoration: InputDecoration(
            hintText: 'Enter user ID (e.g., user_001)',
            prefixIcon: const Icon(Icons.person),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(BorderRadiusTokens.medium),
            ),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'User ID is required';
            }
            if (!value.trim().startsWith('user_')) {
              return 'User ID must start with "user_"';
            }
            return null;
          },
        ),
        SizedBox(height: Spacing.sm),
        _buildUserPreview(context, theme),
      ],
    );
  }

  Widget _buildUserPreview(BuildContext context, ThemeData theme) {
    final userId = _userIdController.text.trim();
    if (userId.isEmpty || !userId.startsWith('user_')) {
      return const SizedBox.shrink();
    }

    final user = DemoData.users.where((u) => u.id == userId).firstOrNull;
    if (user == null) {
      return Container(
        padding: EdgeInsets.all(Spacing.sm),
        decoration: BoxDecoration(
          color: AppColors.error50,
          borderRadius: BorderRadius.circular(BorderRadiusTokens.small),
        ),
        child: Row(
          children: [
            Icon(Icons.error_outline, size: 16, color: AppColors.error500),
            SizedBox(width: Spacing.xs),
            Text(
              'User not found',
              style: theme.textTheme.bodySmall?.copyWith(
                color: AppColors.error500,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(Spacing.sm),
      decoration: BoxDecoration(
        color: AppColors.success50,
        borderRadius: BorderRadius.circular(BorderRadiusTokens.small),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
            child: Text(
              user.name[0].toUpperCase(),
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: Spacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${user.roleDisplayName} • ${user.statusDisplayName}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Text(
            'Current: ${CurrencyFormatter.formatLYD(DemoData.walletBalance)}',
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.success500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountField(BuildContext context, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Amount',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: Spacing.sm),
        TextFormField(
          controller: _amountController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'Enter amount (e.g., 100.50 or -50.00)',
            prefixIcon: const Icon(Icons.attach_money),
            suffixText: 'LYD',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(BorderRadiusTokens.medium),
            ),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Amount is required';
            }
            final amount = double.tryParse(value);
            if (amount == null) {
              return 'Please enter a valid number';
            }
            if (amount == 0) {
              return 'Amount cannot be zero';
            }
            if (amount.abs() > 10000) {
              return 'Amount cannot exceed د.ل 10,000';
            }
            return null;
          },
          onChanged: (value) {
            setState(() {}); // Trigger rebuild for preview
          },
        ),
        SizedBox(height: Spacing.sm),
        _buildAmountPreview(context, theme),
      ],
    );
  }

  Widget _buildAmountPreview(BuildContext context, ThemeData theme) {
    final amountText = _amountController.text.trim();
    if (amountText.isEmpty) {
      return const SizedBox.shrink();
    }

    final amount = double.tryParse(amountText);
    if (amount == null) {
      return const SizedBox.shrink();
    }

    final isCredit = amount > 0;
    final color = isCredit ? AppColors.success500 : AppColors.error500;
    final icon = isCredit ? Icons.add : Icons.remove;
    final action = isCredit ? 'Credit' : 'Debit';

    return Container(
      padding: EdgeInsets.all(Spacing.sm),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(BorderRadiusTokens.small),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: color),
          SizedBox(width: Spacing.xs),
          Text(
            '$action: ${CurrencyFormatter.formatLYD(amount.abs())}',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReasonField(BuildContext context, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Reason',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: Spacing.sm),
        TextFormField(
          controller: _reasonController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Enter reason for adjustment (e.g., "Compensation for service issue")',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(BorderRadiusTokens.medium),
            ),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Reason is required';
            }
            if (value.trim().length < 10) {
              return 'Reason must be at least 10 characters';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildRecentAdjustments(BuildContext context, ThemeData theme) {
    final recentAdjustments = DemoData.transactions
        .where((t) => t.type == DemoTransactionType.adjustment)
        .take(5)
        .toList();

    if (recentAdjustments.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Adjustments',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: Spacing.md),
        Card(
          child: Column(
            children: recentAdjustments.map((adjustment) {
              final isCredit = adjustment.amount > 0;
              final color = isCredit ? AppColors.success500 : AppColors.error500;
              final icon = isCredit ? Icons.add : Icons.remove;

              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: color.withValues(alpha: 0.1),
                  child: Icon(icon, color: color, size: 20),
                ),
                title: Text(
                  adjustment.title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  adjustment.subtitle,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      CurrencyFormatter.formatLYD(adjustment.amount, withSign: true),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      _formatTimeAgo(adjustment.date),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  void _submitAdjustment() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final userId = _userIdController.text.trim();
    final amount = double.parse(_amountController.text.trim());
    final reason = _reasonController.text.trim();

    setState(() => _isSubmitting = true);

    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 1500));

    if (!mounted) return;

    setState(() => _isSubmitting = false);

    // Show success dialog
    _showSuccessDialog(context, userId, amount, reason);

    // Clear form
    _formKey.currentState!.reset();
    _userIdController.clear();
    _amountController.clear();
    _reasonController.clear();
  }

  void _showSuccessDialog(
    BuildContext context,
    String userId,
    double amount,
    String reason,
  ) {
    final isCredit = amount > 0;
    final action = isCredit ? 'credited' : 'debited';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: AppColors.success500,
              size: 24,
            ),
            SizedBox(width: Spacing.sm),
            const Text('Adjustment Successful'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Wallet adjustment has been processed successfully.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: Spacing.md),
            _buildSuccessDetail('User ID', userId),
            SizedBox(height: Spacing.xs),
            _buildSuccessDetail('Amount', CurrencyFormatter.formatLYD(amount, withSign: true)),
            SizedBox(height: Spacing.xs),
            _buildSuccessDetail('Action', '$action to wallet'),
            SizedBox(height: Spacing.xs),
            _buildSuccessDetail('Reason', reason),
          ],
        ),
        actions: [
          FilledButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessDetail(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            '$label:',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }

  String _formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}
