import 'package:flutter/material.dart';

/// Accessibility helper functions for consistent accessibility features
class AccessibilityHelper {
  /// Minimum touch target size (48dp as per Material Design guidelines)
  static const double minTouchTargetSize = 48.0;

  /// Ensures a widget has a minimum touch target size
  static Widget ensureTouchTarget({
    required Widget child,
    double minSize = minTouchTargetSize,
    EdgeInsets? padding,
  }) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: minSize,
        minHeight: minSize,
      ),
      child: Center(
        child: Padding(
          padding: padding ?? EdgeInsets.zero,
          child: child,
        ),
      ),
    );
  }

  /// Creates a semantic label for better screen reader support
  static String createSemanticLabel({
    required String action,
    required String target,
    String? context,
  }) {
    if (context != null) {
      return '$action $target in $context';
    }
    return '$action $target';
  }

  /// Creates a semantic hint for interactive elements
  static String createSemanticHint({
    required String description,
    String? action,
  }) {
    if (action != null) {
      return '$description. $action';
    }
    return description;
  }

  /// Ensures text has proper contrast by using theme-aware colors
  static Color ensureTextContrast(BuildContext context, Color color) {
    final theme = Theme.of(context);
    final brightness = theme.brightness;
    
    // For light theme, ensure dark text
    if (brightness == Brightness.light) {
      return color.computeLuminance() > 0.5 ? Colors.black87 : color;
    }
    
    // For dark theme, ensure light text
    return color.computeLuminance() > 0.5 ? color : Colors.white.withValues(alpha: 0.87);
  }

  /// Creates a focusable widget with proper semantics
  static Widget makeFocusable({
    required Widget child,
    required String label,
    String? hint,
    VoidCallback? onTap,
    bool enabled = true,
  }) {
    return Semantics(
      label: label,
      hint: hint,
      enabled: enabled,
      button: onTap != null,
      child: GestureDetector(
        onTap: enabled ? onTap : null,
        child: child,
      ),
    );
  }

  /// Creates a list item with proper semantics
  static Widget makeListItem({
    required Widget child,
    required String label,
    String? hint,
    VoidCallback? onTap,
    bool enabled = true,
  }) {
    return Semantics(
      label: label,
      hint: hint,
      enabled: enabled,
      button: onTap != null,
      child: ListTile(
        onTap: enabled ? onTap : null,
        title: child,
      ),
    );
  }

  /// Ensures proper text scaling support
  static TextStyle ensureTextScaling(TextStyle style) {
    return style.copyWith(
      height: style.height ?? 1.2, // Ensure minimum line height
    );
  }

  /// Creates a loading state with proper semantics
  static Widget createLoadingState({
    required String label,
    String? hint,
  }) {
    return Semantics(
      label: label,
      hint: hint ?? 'Loading in progress',
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  /// Creates an error state with proper semantics
  static Widget createErrorState({
    required String label,
    String? hint,
    VoidCallback? onRetry,
  }) {
    return Semantics(
      label: label,
      hint: hint ?? 'Error occurred',
      button: onRetry != null,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48),
            const SizedBox(height: 16),
            Text(label),
            if (onRetry != null) ...[
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: onRetry,
                child: const Text('Retry'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
