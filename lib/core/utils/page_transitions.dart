import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/motion_tokens.dart';

/// Page transition utilities for consistent animations
class PageTransitions {
  /// Standard page transition for most navigation
  static Page<T> standard<T extends Object>({
    required Widget child,
    String? name,
    Object? arguments,
    String? restorationId,
  }) {
    return CustomTransitionPage<T>(
      key: ValueKey(name ?? child.runtimeType.toString()),
      child: child,
      name: name,
      arguments: arguments,
      restorationId: restorationId,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = MotionTokens.pageTransitionCurve;

        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      transitionDuration: MotionTokens.pageTransitionDuration,
      reverseTransitionDuration: MotionTokens.pageTransitionDuration,
    );
  }

  /// Emphasized transition for important navigation (e.g., Home ↔ Detail)
  static Page<T> emphasized<T extends Object>({
    required Widget child,
    String? name,
    Object? arguments,
    String? restorationId,
  }) {
    return CustomTransitionPage<T>(
      key: ValueKey(name ?? child.runtimeType.toString()),
      child: child,
      name: name,
      arguments: arguments,
      restorationId: restorationId,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 0.3);
        const end = Offset.zero;
        const curve = MotionTokens.emphasizedCurve;

        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
      transitionDuration: MotionTokens.emphasized,
      reverseTransitionDuration: MotionTokens.emphasized,
    );
  }

  /// Fade transition for dialogs and sheets
  static Page<T> fade<T extends Object>({
    required Widget child,
    String? name,
    Object? arguments,
    String? restorationId,
  }) {
    return CustomTransitionPage<T>(
      key: ValueKey(name ?? child.runtimeType.toString()),
      child: child,
      name: name,
      arguments: arguments,
      restorationId: restorationId,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween<double>(
              begin: 0.95,
              end: 1.0,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: MotionTokens.fastCurve,
            )),
            child: child,
          ),
        );
      },
      transitionDuration: MotionTokens.sheetOpenDuration,
      reverseTransitionDuration: MotionTokens.standard,
    );
  }

  /// Scale transition for modal dialogs
  static Page<T> scale<T extends Object>({
    required Widget child,
    String? name,
    Object? arguments,
    String? restorationId,
  }) {
    return CustomTransitionPage<T>(
      key: ValueKey(name ?? child.runtimeType.toString()),
      child: child,
      name: name,
      arguments: arguments,
      restorationId: restorationId,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: Tween<double>(
            begin: 0.8,
            end: 1.0,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: MotionTokens.emphasizedCurve,
          )),
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
      transitionDuration: MotionTokens.sheetOpenDuration,
      reverseTransitionDuration: MotionTokens.standard,
    );
  }

  /// No transition for tab changes and similar
  static Page<T> none<T extends Object>({
    required Widget child,
    String? name,
    Object? arguments,
    String? restorationId,
  }) {
    return NoTransitionPage<T>(
      child: child,
      name: name,
      arguments: arguments,
      restorationId: restorationId,
    );
  }
}
