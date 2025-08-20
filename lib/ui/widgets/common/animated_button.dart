import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/motion_tokens.dart';
import '../../../core/utils/accessibility_helper.dart';

/// Animated button widget with proper accessibility and micro-interactions
class AnimatedButton extends StatefulWidget {
  final String label;
  final String? semanticLabel;
  final String? semanticHint;
  final VoidCallback? onPressed;
  final bool enabled;
  final bool isLoading;
  final IconData? icon;
  final ButtonStyle? style;
  final double? width;
  final double? height;

  const AnimatedButton({
    super.key,
    required this.label,
    this.semanticLabel,
    this.semanticHint,
    this.onPressed,
    this.enabled = true,
    this.isLoading = false,
    this.icon,
    this.style,
    this.width,
    this.height,
  });

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: MotionTokens.buttonPressDuration,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.enabled && !widget.isLoading) {
      setState(() => _isPressed = true);
      _controller.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.enabled && !widget.isLoading) {
      setState(() => _isPressed = false);
      _controller.reverse();
    }
  }

  void _handleTapCancel() {
    if (widget.enabled && !widget.isLoading) {
      setState(() => _isPressed = false);
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isEnabled = widget.enabled && !widget.isLoading;

    return Semantics(
      label: widget.semanticLabel ?? widget.label,
      hint: widget.semanticHint,
      enabled: isEnabled,
      button: true,
      child: GestureDetector(
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        onTap: isEnabled ? widget.onPressed : null,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final scale = 1.0 - (_controller.value * 0.05);
            
            return Transform.scale(
              scale: scale,
              child: Container(
                width: widget.width,
                height: widget.height ?? AccessibilityHelper.minTouchTargetSize,
                constraints: BoxConstraints(
                  minWidth: AccessibilityHelper.minTouchTargetSize,
                  minHeight: AccessibilityHelper.minTouchTargetSize,
                ),
                child: ElevatedButton(
                  onPressed: isEnabled ? widget.onPressed : null,
                  style: widget.style ?? _getDefaultStyle(theme),
                  child: _buildButtonContent(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildButtonContent() {
    if (widget.isLoading) {
      return SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ).animate().fadeIn(duration: MotionTokens.fast);
    }

    final children = <Widget>[];
    
    if (widget.icon != null) {
      children.addAll([
        Icon(widget.icon, size: 18),
        SizedBox(width: Spacing.xs),
      ]);
    }
    
    children.add(
      Flexible(
        child: Text(
          widget.label,
          style: AccessibilityHelper.ensureTextScaling(
            Theme.of(context).textTheme.labelLarge!,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }

  ButtonStyle _getDefaultStyle(ThemeData theme) {
    return ElevatedButton.styleFrom(
      backgroundColor: theme.colorScheme.primary,
      foregroundColor: theme.colorScheme.onPrimary,
      disabledBackgroundColor: theme.colorScheme.surfaceContainerHighest,
      disabledForegroundColor: theme.colorScheme.onSurfaceVariant,
      elevation: _isPressed ? 2 : 4,
      shadowColor: theme.colorScheme.shadow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(BorderRadiusTokens.medium),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: Spacing.lg,
        vertical: Spacing.md,
      ),
    );
  }
}

/// Animated icon button with proper accessibility
class AnimatedIconButton extends StatefulWidget {
  final IconData icon;
  final String semanticLabel;
  final String? semanticHint;
  final VoidCallback? onPressed;
  final bool enabled;
  final Color? iconColor;
  final double? iconSize;
  final double? buttonSize;

  const AnimatedIconButton({
    super.key,
    required this.icon,
    required this.semanticLabel,
    this.semanticHint,
    this.onPressed,
    this.enabled = true,
    this.iconColor,
    this.iconSize,
    this.buttonSize,
  });

  @override
  State<AnimatedIconButton> createState() => _AnimatedIconButtonState();
}

class _AnimatedIconButtonState extends State<AnimatedIconButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: MotionTokens.buttonPressDuration,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.enabled) {
      setState(() => _isPressed = true);
      _controller.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.enabled) {
      setState(() => _isPressed = false);
      _controller.reverse();
    }
  }

  void _handleTapCancel() {
    if (widget.enabled) {
      setState(() => _isPressed = false);
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final buttonSize = widget.buttonSize ?? AccessibilityHelper.minTouchTargetSize;
    final iconSize = widget.iconSize ?? 24.0;

    return Semantics(
      label: widget.semanticLabel,
      hint: widget.semanticHint,
      enabled: widget.enabled,
      button: true,
      child: GestureDetector(
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        onTap: widget.enabled ? widget.onPressed : null,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final scale = 1.0 - (_controller.value * 0.1);
            
            return Transform.scale(
              scale: scale,
              child: Container(
                width: buttonSize,
                height: buttonSize,
                constraints: BoxConstraints(
                  minWidth: AccessibilityHelper.minTouchTargetSize,
                  minHeight: AccessibilityHelper.minTouchTargetSize,
                ),
                child: IconButton(
                  onPressed: widget.enabled ? widget.onPressed : null,
                  icon: Icon(
                    widget.icon,
                    size: iconSize,
                    color: widget.iconColor ?? theme.colorScheme.onSurface,
                  ),
                  style: IconButton.styleFrom(
                    backgroundColor: _isPressed 
                        ? theme.colorScheme.surfaceContainerHighest
                        : Colors.transparent,
                    elevation: _isPressed ? 2 : 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(BorderRadiusTokens.small),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
