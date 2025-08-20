import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/motion_tokens.dart';

/// Skeleton loader widget with proper accessibility and animation
class SkeletonLoader extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final EdgeInsets? margin;

  const SkeletonLoader({
    super.key,
    this.width = double.infinity,
    required this.height,
    this.borderRadius = BorderRadiusTokens.small,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Semantics(
      label: 'Loading content',
      excludeSemantics: true,
      child: Container(
        width: width,
        height: height,
        margin: margin,
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Container()
            .animate(onPlay: (controller) => controller.repeat())
            .shimmer(
              duration: MotionTokens.skeletonShimmerDuration,
              color: theme.colorScheme.surfaceContainerHigh,
            ),
      ),
    );
  }
}

/// Skeleton list widget for loading states
class SkeletonList extends StatelessWidget {
  final int itemCount;
  final double itemHeight;
  final EdgeInsets? itemMargin;
  final double borderRadius;

  const SkeletonList({
    super.key,
    this.itemCount = 5,
    this.itemHeight = 80,
    this.itemMargin,
    this.borderRadius = BorderRadiusTokens.medium,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(Spacing.md),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return SkeletonLoader(
          height: itemHeight,
          borderRadius: borderRadius,
          margin: itemMargin ?? EdgeInsets.only(bottom: Spacing.md),
        );
      },
    );
  }
}

/// Skeleton card widget for loading property cards
class SkeletonCard extends StatelessWidget {
  final double height;
  final EdgeInsets? margin;

  const SkeletonCard({
    super.key,
    this.height = 200,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.all(Spacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image skeleton
          SkeletonLoader(
            height: height * 0.6,
            borderRadius: BorderRadiusTokens.medium,
          ),
          SizedBox(height: Spacing.sm),
          // Title skeleton
          SkeletonLoader(
            height: 16,
            width: 200,
            borderRadius: BorderRadiusTokens.small,
          ),
          SizedBox(height: Spacing.xs),
          // Subtitle skeleton
          SkeletonLoader(
            height: 14,
            width: 150,
            borderRadius: BorderRadiusTokens.small,
          ),
          SizedBox(height: Spacing.xs),
          // Price skeleton
          SkeletonLoader(
            height: 18,
            width: 100,
            borderRadius: BorderRadiusTokens.small,
          ),
        ],
      ),
    );
  }
}

/// Skeleton grid widget for loading property grids
class SkeletonGrid extends StatelessWidget {
  final int crossAxisCount;
  final int itemCount;
  final double itemHeight;
  final EdgeInsets? padding;

  const SkeletonGrid({
    super.key,
    this.crossAxisCount = 2,
    this.itemCount = 6,
    this.itemHeight = 200,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: padding ?? EdgeInsets.all(Spacing.md),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 0.75,
        crossAxisSpacing: Spacing.sm,
        mainAxisSpacing: Spacing.sm,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return SkeletonCard(height: itemHeight);
      },
    );
  }
}
