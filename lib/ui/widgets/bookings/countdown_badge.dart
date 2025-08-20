import 'package:flutter/material.dart';
import 'dart:async';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/accessibility_helper.dart';

class CountdownBadge extends StatefulWidget {
  final DateTime endTime;
  final bool reducedMotion;

  const CountdownBadge({
    super.key,
    required this.endTime,
    this.reducedMotion = false,
  });

  @override
  State<CountdownBadge> createState() => _CountdownBadgeState();
}

class _CountdownBadgeState extends State<CountdownBadge> {
  Timer? _timer;
  late int _remaining; // seconds

  int _computeRemaining() {
    final now = DateTime.now();
    final diff = widget.endTime.difference(now).inSeconds;
    return diff <= 0 ? 0 : diff;
  }

  @override
  void initState() {
    super.initState();
    _remaining = _computeRemaining(); // NO setState in initState
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      final next = _computeRemaining();
      if (next != _remaining) {
        setState(() => _remaining = next); // safe: not in build phase
      }
      if (next == 0) {
        _timer?.cancel();
        _timer = null;
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // PURE UI – no setState, no navigation, no dialogs
    final minutes = (_remaining ~/ 60).toString().padLeft(2, '0');
    final seconds = (_remaining % 60).toString().padLeft(2, '0');

    final shouldAnimate = !widget.reducedMotion && _remaining > 0;

    return Semantics(
      label: 'Payment countdown: $minutes minutes and $seconds seconds remaining',
      child: AnimatedScale(
        duration: const Duration(milliseconds: 200),
        scale: shouldAnimate ? 1.0 : 1.0, // keep scale stable if reduced motion
        child: Chip(
          label: Text(
            '$minutes:$seconds',
            style: AccessibilityHelper.ensureTextScaling(
              Theme.of(context).textTheme.labelMedium!,
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.errorContainer,
          labelStyle: TextStyle(
            color: Theme.of(context).colorScheme.onErrorContainer,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
