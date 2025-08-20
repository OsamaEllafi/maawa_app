import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';
import '../../../demo/demo_data.dart';

/// Property card widget for displaying property information
class PropertyCard extends StatelessWidget {
  final DemoProperty property;
  final bool isGridView;
  final VoidCallback? onTap;
  final int animationDelay;

  const PropertyCard({
    super.key,
    required this.property,
    required this.isGridView,
    this.onTap,
    this.animationDelay = 0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = Localizations.localeOf(context).languageCode;
    final isReducedMotion = MediaQuery.of(context).accessibleNavigation;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        key: ValueKey(property.id),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(BorderRadiusTokens.medium),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.shadow.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: isGridView ? _buildGridView(theme, l10n) : _buildListView(theme, l10n),
      ),
    )
        .animate()
        .fadeIn(
          delay: isReducedMotion ? 0.ms : animationDelay.ms,
          duration: isReducedMotion ? 0.ms : 400.ms,
        )
        .slideY(
          begin: isReducedMotion ? 0.0 : 0.3,
          delay: isReducedMotion ? 0.ms : animationDelay.ms,
          duration: isReducedMotion ? 0.ms : 400.ms,
        );
  }

  Widget _buildGridView(ThemeData theme, String l10n) {
    return SizedBox(
      height: kGridCardHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image section with fixed height
          SizedBox(
            height: 120,
            width: double.infinity,
            child: Stack(
              children: [
                // Property image
                Container(
                  width: double.infinity,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(BorderRadiusTokens.medium),
                      topRight: Radius.circular(BorderRadiusTokens.medium),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(BorderRadiusTokens.medium),
                      topRight: Radius.circular(BorderRadiusTokens.medium),
                    ),
                    child: Image.asset(
                      property.imageUrls.first,
                      fit: BoxFit.cover,
                      cacheWidth: 600,
                      cacheHeight: 400,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: theme.colorScheme.surfaceContainerLow,
                          child: Icon(
                            Icons.home_outlined,
                            size: 48,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                
                // Video indicator
                if (property.videoUrl != null)
                  Positioned(
                    top: Spacing.sm,
                    right: Spacing.sm,
                    child: Container(
                      padding: EdgeInsets.all(Spacing.xs),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Icon(
                        Icons.play_arrow_rounded,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                
                // Featured badge
                if (property.isFeatured)
                  Positioned(
                    top: Spacing.sm,
                    left: Spacing.sm,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Spacing.sm,
                        vertical: Spacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Featured',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                
                // Availability badge
                if (!property.isAvailable)
                  Positioned(
                    top: Spacing.sm,
                    left: property.isFeatured ? 80 : Spacing.sm,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Spacing.sm,
                        vertical: Spacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.error,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Unavailable',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onError,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          
          // Content section with fixed height
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(Spacing.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Property type badge
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Spacing.sm,
                      vertical: Spacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      property.getLocalizedType(l10n),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  
                  SizedBox(height: Spacing.xs),
                  
                  // Title
                  Text(
                    property.getLocalizedTitle(l10n),
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  SizedBox(height: Spacing.xs),
                  
                  // Location
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 12,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      SizedBox(width: Spacing.xs),
                      Expanded(
                        child: Text(
                          property.getLocalizedLocation(l10n),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: Spacing.xs),
                  
                  // Rating and reviews
                  Row(
                    children: [
                      Icon(
                        Icons.star_rounded,
                        size: 14,
                        color: AppColors.warning500,
                      ),
                      SizedBox(width: Spacing.xs),
                      Text(
                        property.rating.toString(),
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: Spacing.xs),
                      Text(
                        '(${property.reviewCount})',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  
                  const Spacer(),
                  
                  // Price
                  Row(
                    children: [
                      Text(
                        property.formattedPrice,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      SizedBox(width: Spacing.xs),
                      Text(
                        '/night',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListView(ThemeData theme, String l10n) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 128),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image section with fixed size
          SizedBox(
            width: 160,
            height: 120,
            child: Stack(
              children: [
                // Property image
                Container(
                  width: 160,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(BorderRadiusTokens.medium),
                      bottomLeft: Radius.circular(BorderRadiusTokens.medium),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(BorderRadiusTokens.medium),
                      bottomLeft: Radius.circular(BorderRadiusTokens.medium),
                    ),
                    child: Image.asset(
                      property.imageUrls.first,
                      fit: BoxFit.cover,
                      cacheWidth: 320,
                      cacheHeight: 240,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: theme.colorScheme.surfaceContainerLow,
                          child: Icon(
                            Icons.home_outlined,
                            size: 48,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                
                // Video indicator
                if (property.videoUrl != null)
                  Positioned(
                    top: Spacing.sm,
                    right: Spacing.sm,
                    child: Container(
                      padding: EdgeInsets.all(Spacing.xs),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Icon(
                        Icons.play_arrow_rounded,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                
                // Featured badge
                if (property.isFeatured)
                  Positioned(
                    top: Spacing.sm,
                    left: Spacing.sm,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Spacing.sm,
                        vertical: Spacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Featured',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                
                // Availability badge
                if (!property.isAvailable)
                  Positioned(
                    top: Spacing.sm,
                    left: property.isFeatured ? 80 : Spacing.sm,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Spacing.sm,
                        vertical: Spacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.error,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Unavailable',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onError,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          
          // Content section - only Expanded widget in the Row
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(Spacing.md),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Property type badge
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Spacing.sm,
                      vertical: Spacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      property.getLocalizedType(l10n),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  
                  SizedBox(height: Spacing.sm),
                  
                  // Title
                  Text(
                    property.getLocalizedTitle(l10n),
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  SizedBox(height: Spacing.xs),
                  
                  // Location
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 14,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      SizedBox(width: Spacing.xs),
                      Expanded(
                        child: Text(
                          property.getLocalizedLocation(l10n),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: Spacing.sm),
                  
                  // Price + rating row
                  Row(
                    children: [
                      // Price (expanded to allow ellipsis)
                      Expanded(
                        child: Text(
                          property.formattedPrice,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      // Rating (compact)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.star_rounded,
                            size: 16,
                            color: AppColors.warning500,
                          ),
                          SizedBox(width: Spacing.xs),
                          Text(
                            property.rating.toString(),
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
