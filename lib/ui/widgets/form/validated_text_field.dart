import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';

/// A TextFormField with built-in validation shake animation
class ValidatedTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<String>? autofillHints;
  final String? Function(String?)? validator;
  final VoidCallback? onFieldSubmitted;
  final bool obscureText;
  final TextDirection? textDirection;
  final bool enabled;
  final int animationDelay;

  const ValidatedTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.textInputAction,
    this.autofillHints,
    this.validator,
    this.onFieldSubmitted,
    this.obscureText = false,
    this.textDirection,
    this.enabled = true,
    this.animationDelay = 0,
  });

  @override
  State<ValidatedTextField> createState() => _ValidatedTextFieldState();
}

class _ValidatedTextFieldState extends State<ValidatedTextField> {
  final GlobalKey _fieldKey = GlobalKey();
  bool _hasError = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isReducedMotion = MediaQuery.of(context).accessibleNavigation;

    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) {
        // Check for validation errors
        final currentError = widget.validator?.call(widget.controller.text);
        final hasError = currentError != null && widget.controller.text.isNotEmpty;
        
        // Trigger shake animation when error state changes
        if (hasError != _hasError) {
          _hasError = hasError;
          if (hasError && !isReducedMotion) {
            // Trigger shake animation
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _fieldKey.currentState?.setState(() {});
            });
          }
        }

        return Container(
          key: _fieldKey,
          child: TextFormField(
            controller: widget.controller,
            decoration: InputDecoration(
              labelText: widget.labelText,
              hintText: widget.hintText,
              prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
              suffixIcon: widget.suffixIcon,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(BorderRadiusTokens.medium),
              ),
              filled: true,
              fillColor: theme.colorScheme.surfaceContainerHighest,
              errorStyle: TextStyle(
                color: theme.colorScheme.error,
                fontSize: theme.textTheme.bodySmall?.fontSize,
              ),
            ),
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            autofillHints: widget.autofillHints,
            validator: widget.validator,
            onFieldSubmitted: widget.onFieldSubmitted != null ? (_) => widget.onFieldSubmitted!() : null,
            obscureText: widget.obscureText,
            textDirection: widget.textDirection,
            enabled: widget.enabled,
          ),
        )
            .animate()
            .fadeIn(
              delay: Duration(milliseconds: isReducedMotion ? 0 : widget.animationDelay),
              duration: isReducedMotion ? 0.ms : 600.ms,
            )
            .slideY(
              begin: isReducedMotion ? 0.0 : 0.3,
              duration: isReducedMotion ? 0.ms : 600.ms,
            )
            .then()
            .shake(
              duration: isReducedMotion ? 0.ms : 400.ms,
              delay: isReducedMotion ? 0.ms : 100.ms,
              hz: isReducedMotion ? 0 : 4,
              rotation: isReducedMotion ? 0 : 0.02,
              curve: isReducedMotion ? Curves.linear : Curves.easeInOut,
            );
      },
    );
  }
}
