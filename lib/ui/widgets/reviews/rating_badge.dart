import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

/// A widget that displays a rating badge with stars and average score
class RatingBadge extends StatelessWidget {
  const RatingBadge({
    super.key,
    required this.rating,
    required this.reviewCount,
    this.size = RatingBadgeSize.medium,
    this.showCount = true,
  });

  final double rating;
  final int reviewCount;
  final RatingBadgeSize size;
  final bool showCount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    
    // Size configurations
    final config = _getSizeConfig(size);
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
      children: [
        // Star rating display
        Row(
          mainAxisSize: MainAxisSize.min,
          textDirection: TextDirection.ltr, // Stars always LTR
          children: List.generate(5, (index) {
            final starRating = index + 1;
            return Icon(
              starRating <= rating.floor()
                  ? Icons.star
                  : starRating == rating.floor() + 1 && rating % 1 >= 0.5
                      ? Icons.star_half
                      : Icons.star_outline,
              color: AppColors.warning500,
              size: config.starSize,
            );
          }),
        ),
        
        SizedBox(width: config.spacing),
        
        // Rating value
        Text(
          rating.toStringAsFixed(1),
          style: config.textStyle(theme),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        
        // Review count
        if (showCount && reviewCount > 0) ...[
          SizedBox(width: config.spacing / 2),
          Text(
            '($reviewCount)',
            style: config.countStyle(theme),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ],
    );
  }

  _RatingBadgeConfig _getSizeConfig(RatingBadgeSize size) {
    switch (size) {
      case RatingBadgeSize.small:
        return _RatingBadgeConfig(
          starSize: 16,
          spacing: 4,
          textStyle: (theme) => theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          countStyle: (theme) => theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        );
      case RatingBadgeSize.medium:
        return _RatingBadgeConfig(
          starSize: 20,
          spacing: 6,
          textStyle: (theme) => theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          countStyle: (theme) => theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        );
      case RatingBadgeSize.large:
        return _RatingBadgeConfig(
          starSize: 24,
          spacing: 8,
          textStyle: (theme) => theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          countStyle: (theme) => theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        );
    }
  }
}

enum RatingBadgeSize {
  small,
  medium,
  large,
}

class _RatingBadgeConfig {
  const _RatingBadgeConfig({
    required this.starSize,
    required this.spacing,
    required this.textStyle,
    required this.countStyle,
  });

  final double starSize;
  final double spacing;
  final TextStyle? Function(ThemeData) textStyle;
  final TextStyle? Function(ThemeData) countStyle;
}

/// A more compact rating display for use in lists
class CompactRatingBadge extends StatelessWidget {
  const CompactRatingBadge({
    super.key,
    required this.rating,
    this.showValue = true,
  });

  final double rating;
  final bool showValue;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.star,
          color: AppColors.warning500,
          size: 16,
        ),
        if (showValue) ...[
          SizedBox(width: 4),
          Text(
            rating.toStringAsFixed(1),
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ],
    );
  }
}
