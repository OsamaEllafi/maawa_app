import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

/// A reusable snackbar with proper semantics and consistent styling
class AppSnackBar {
  static void showSuccess(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 4),
  }) {
    _showSnackBar(
      context,
      message: message,
      backgroundColor: AppColors.success500,
      icon: Icons.check_circle_outline,
      semanticsLabel: 'Success: $message',
      duration: duration,
    );
  }

  static void showError(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 4),
  }) {
    _showSnackBar(
      context,
      message: message,
      backgroundColor: AppColors.error500,
      icon: Icons.error_outline,
      semanticsLabel: 'Error: $message',
      duration: duration,
    );
  }

  static void showWarning(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 4),
  }) {
    _showSnackBar(
      context,
      message: message,
      backgroundColor: AppColors.warning500,
      icon: Icons.warning_amber_outlined,
      semanticsLabel: 'Warning: $message',
      duration: duration,
    );
  }

  static void showInfo(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 4),
  }) {
    _showSnackBar(
      context,
      message: message,
      backgroundColor: AppColors.primary500,
      icon: Icons.info_outline,
      semanticsLabel: 'Information: $message',
      duration: duration,
    );
  }

  static void _showSnackBar(
    BuildContext context, {
    required String message,
    required Color backgroundColor,
    required IconData icon,
    required String semanticsLabel,
    required Duration duration,
  }) {
    final theme = Theme.of(context);
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Semantics(
          label: semanticsLabel,
          child: Row(
            children: [
              Icon(
                icon,
                color: theme.colorScheme.onError,
                size: 20,
              ),
              SizedBox(width: Spacing.sm),
              Expanded(
                child: Text(
                  message,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onError,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: backgroundColor,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BorderRadiusTokens.medium),
        ),
        margin: EdgeInsets.all(Spacing.md),
        elevation: 4,
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: theme.colorScheme.onError,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}
