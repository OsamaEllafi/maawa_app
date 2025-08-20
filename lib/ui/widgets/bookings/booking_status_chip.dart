import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/accessibility_helper.dart';

enum BookingStatus {
  requested,
  pendingPayment,
  confirmed,
  completed,
  cancelled,
  expired,
}

class BookingStatusChip extends StatelessWidget {
  final BookingStatus status;
  final bool compact;

  const BookingStatusChip({
    super.key,
    required this.status,
    this.compact = false,
  });

  Color _getStatusColor(BookingStatus status) {
    switch (status) {
      case BookingStatus.requested:
        return AppColors.warning500;
      case BookingStatus.pendingPayment:
        return AppColors.primary500;
      case BookingStatus.confirmed:
        return AppColors.success500;
      case BookingStatus.completed:
        return AppColors.success600;
      case BookingStatus.cancelled:
        return AppColors.error500;
      case BookingStatus.expired:
        return AppColors.textSecondary;
    }
  }

  Color _getTextColor(BuildContext context, BookingStatus status) {
    final theme = Theme.of(context);

    // Use theme-aware colors for better contrast
    switch (status) {
      case BookingStatus.requested:
        return theme.colorScheme.onSurface;
      case BookingStatus.pendingPayment:
        return theme.colorScheme.onPrimary;
      case BookingStatus.confirmed:
        return theme.colorScheme.onSurface;
      case BookingStatus.completed:
        return theme.colorScheme.onSurface;
      case BookingStatus.cancelled:
        return theme.colorScheme.onSurface;
      case BookingStatus.expired:
        return theme.colorScheme.onSurfaceVariant;
    }
  }

  Color _getBackgroundColor(BuildContext context, BookingStatus status) {
    final theme = Theme.of(context);

    // Use theme-aware background colors for better contrast
    switch (status) {
      case BookingStatus.requested:
        return theme.colorScheme.surfaceContainerHighest;
      case BookingStatus.pendingPayment:
        return theme.colorScheme.primary;
      case BookingStatus.confirmed:
        return theme.colorScheme.surfaceContainerHighest;
      case BookingStatus.completed:
        return theme.colorScheme.surfaceContainerHighest;
      case BookingStatus.cancelled:
        return theme.colorScheme.surfaceContainerHighest;
      case BookingStatus.expired:
        return theme.colorScheme.surfaceContainerHighest;
    }
  }

  IconData _getStatusIcon(BookingStatus status) {
    switch (status) {
      case BookingStatus.requested:
        return Icons.schedule;
      case BookingStatus.pendingPayment:
        return Icons.payment;
      case BookingStatus.confirmed:
        return Icons.check_circle;
      case BookingStatus.completed:
        return Icons.done_all;
      case BookingStatus.cancelled:
        return Icons.cancel;
      case BookingStatus.expired:
        return Icons.access_time;
    }
  }

  String _getStatusText(BookingStatus status) {
    switch (status) {
      case BookingStatus.requested:
        return 'Requested';
      case BookingStatus.pendingPayment:
        return 'Pending Payment';
      case BookingStatus.confirmed:
        return 'Confirmed';
      case BookingStatus.completed:
        return 'Completed';
      case BookingStatus.cancelled:
        return 'Cancelled';
      case BookingStatus.expired:
        return 'Expired';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statusColor = _getStatusColor(status);
    final statusIcon = _getStatusIcon(status);
    final statusText = _getStatusText(status);
    final textColor = _getTextColor(context, status);
    final backgroundColor = _getBackgroundColor(context, status);

    if (compact) {
      return Semantics(
        label: 'Booking status: $statusText',
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: Spacing.sm,
            vertical: Spacing.xs,
          ),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(BorderRadiusTokens.pill),
            border: Border.all(color: statusColor.withValues(alpha: 0.3)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(statusIcon, size: 12, color: textColor),
              SizedBox(width: Spacing.xs),
              Text(
                statusText,
                style: AccessibilityHelper.ensureTextScaling(
                  (theme.textTheme.bodySmall ?? theme.textTheme.bodyMedium!)
                      .copyWith(color: textColor, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Semantics(
      label: 'Booking status: $statusText',
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Spacing.md,
          vertical: Spacing.sm,
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(BorderRadiusTokens.pill),
          border: Border.all(color: statusColor.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(statusIcon, size: 16, color: textColor),
            SizedBox(width: Spacing.sm),
            Text(
              statusText,
              style: AccessibilityHelper.ensureTextScaling(
                (theme.textTheme.bodyMedium ?? theme.textTheme.bodyLarge!)
                    .copyWith(color: textColor, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
