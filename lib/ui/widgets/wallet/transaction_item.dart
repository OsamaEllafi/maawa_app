import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/utils/accessibility_helper.dart';
import '../../../demo/demo_data.dart';

/// Widget for displaying a single transaction item
class TransactionItem extends StatelessWidget {
  final DemoTransaction transaction;
  final VoidCallback? onTap;

  const TransactionItem({super.key, required this.transaction, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Semantics(
      label: 'Transaction: ${transaction.title}',
      hint: onTap != null ? 'Tap to view transaction details' : null,
      button: onTap != null,
      child: Card(
        margin: EdgeInsets.only(bottom: Spacing.sm),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(BorderRadiusTokens.medium),
          child: Container(
            padding: EdgeInsets.all(Spacing.md),
            child: Row(
              children: [
                // Transaction icon
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: _getTransactionColor(
                      transaction.type,
                      theme,
                    ).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(
                      BorderRadiusTokens.medium,
                    ),
                  ),
                  child: Icon(
                    _getTransactionIcon(transaction.type),
                    color: _getTransactionColor(transaction.type, theme),
                    size: 24,
                  ),
                ),
                SizedBox(width: Spacing.md),

                // Transaction details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transaction.title,
                        style: AccessibilityHelper.ensureTextScaling(
                          (theme.textTheme.titleMedium ??
                                  theme.textTheme.bodyLarge!)
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: Spacing.xs),
                      Text(
                        transaction.subtitle,
                        style: AccessibilityHelper.ensureTextScaling(
                          (theme.textTheme.bodyMedium ??
                                  theme.textTheme.bodyLarge!)
                              .copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: Spacing.xs),
                      Text(
                        _formatDate(transaction.date),
                        style: AccessibilityHelper.ensureTextScaling(
                          (theme.textTheme.bodySmall ??
                                  theme.textTheme.bodyMedium!)
                              .copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                // Amount - right/trailing aligned
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        _getFormattedAmount(),
                        style: AccessibilityHelper.ensureTextScaling(
                          (theme.textTheme.titleMedium ??
                                  theme.textTheme.bodyLarge!)
                              .copyWith(
                                color: _getAmountColor(theme),
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        textAlign: TextAlign.end,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: Spacing.xs),
                      _buildStatusChip(theme),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getFormattedAmount() {
    final isCredit =
        transaction.type == DemoTransactionType.topup ||
        (transaction.type == DemoTransactionType.adjustment &&
            transaction.amount > 0);

    if (isCredit) {
      return CurrencyFormatter.formatLYD(transaction.amount, withSign: true);
    } else {
      return CurrencyFormatter.formatLYD(transaction.amount.abs());
    }
  }

  Color _getAmountColor(ThemeData theme) {
    final isCredit =
        transaction.type == DemoTransactionType.topup ||
        (transaction.type == DemoTransactionType.adjustment &&
            transaction.amount > 0);

    if (isCredit) {
      return theme
          .colorScheme
          .primary; // Use primary for credits (AA compliant)
    } else {
      return theme.colorScheme.onSurface; // Use default for debits
    }
  }

  IconData _getTransactionIcon(DemoTransactionType type) {
    switch (type) {
      case DemoTransactionType.topup:
        return Icons.add_circle;
      case DemoTransactionType.withdrawal:
        return Icons.remove_circle;
      case DemoTransactionType.booking:
        return Icons.home;
      case DemoTransactionType.adjustment:
        return Icons.tune;
    }
  }

  Color _getTransactionColor(DemoTransactionType type, ThemeData theme) {
    switch (type) {
      case DemoTransactionType.topup:
        return theme.colorScheme.primary;
      case DemoTransactionType.withdrawal:
        return theme.colorScheme.error;
      case DemoTransactionType.booking:
        return theme.colorScheme.primary;
      case DemoTransactionType.adjustment:
        return theme.colorScheme.tertiary;
    }
  }

  Widget _buildStatusChip(ThemeData theme) {
    Color statusColor;
    String statusText;
    Color backgroundColor;

    switch (transaction.status) {
      case DemoTransactionStatus.completed:
        statusColor = theme.colorScheme.onPrimaryContainer;
        backgroundColor = theme.colorScheme.primaryContainer;
        statusText = 'Completed';
        break;
      case DemoTransactionStatus.pending:
        statusColor = theme.colorScheme.onTertiaryContainer;
        backgroundColor = theme.colorScheme.tertiaryContainer;
        statusText = 'Pending';
        break;
      case DemoTransactionStatus.failed:
        statusColor = theme.colorScheme.onErrorContainer;
        backgroundColor = theme.colorScheme.errorContainer;
        statusText = 'Failed';
        break;
      case DemoTransactionStatus.cancelled:
        statusColor = theme.colorScheme.onSurfaceVariant;
        backgroundColor = theme.colorScheme.surfaceContainerHighest;
        statusText = 'Cancelled';
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        statusText,
        style: AccessibilityHelper.ensureTextScaling(
          (theme.textTheme.bodySmall ?? theme.textTheme.bodyMedium!).copyWith(
            color: statusColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
