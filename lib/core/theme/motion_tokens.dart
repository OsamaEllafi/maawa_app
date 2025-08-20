import 'package:flutter/material.dart';

/// Motion tokens for consistent animations across the app
class MotionTokens {
  // Duration tokens
  static const Duration instant = Duration(milliseconds: 0);
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration standard = Duration(milliseconds: 300);
  static const Duration emphasized = Duration(milliseconds: 500);
  static const Duration slow = Duration(milliseconds: 700);

  // Curve tokens
  static const Curve standardCurve = Curves.easeInOut;
  static const Curve emphasizedCurve = Curves.easeOutCubic;
  static const Curve fastCurve = Curves.easeOut;
  static const Curve slowCurve = Curves.easeInOutCubic;

  // Page transition tokens
  static const Duration pageTransitionDuration = standard;
  static const Curve pageTransitionCurve = standardCurve;
  
  // Micro-interaction tokens
  static const Duration buttonPressDuration = fast;
  static const Duration listItemDuration = standard;
  static const Duration sheetOpenDuration = emphasized;
  
  // Skeleton loading tokens
  static const Duration skeletonShimmerDuration = Duration(milliseconds: 1500);
  static const Duration skeletonFadeDuration = standard;
}
