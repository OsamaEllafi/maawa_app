import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../../demo/demo_data.dart';
import 'rating_badge.dart';
import 'review_form_sheet.dart';

/// A widget that displays a list of reviews with average rating
class ReviewsList extends StatelessWidget {
  const ReviewsList({
    super.key,
    required this.propertyId,
    this.showWriteReviewButton = true,
    this.maxHeight,
  });

  final String propertyId;
  final bool showWriteReviewButton;
  final double? maxHeight;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final property = DemoData.getPropertyById(propertyId);
    final reviews = property?.reviews ?? [];
    
    if (property == null) {
      return const SizedBox.shrink();
    }

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Header with average rating and write review button
        _buildHeader(context, l10n, theme, property, reviews),
        
        if (reviews.isNotEmpty) ...[
          SizedBox(height: Spacing.lg),
          // Reviews list
          _buildReviewsList(context, l10n, theme, reviews),
        ] else
          _buildEmptyState(context, l10n, theme),
      ],
    );

    // Wrap in constrained height if specified
    if (maxHeight != null) {
      return SizedBox(
        height: maxHeight,
        child: SingleChildScrollView(
          child: content,
        ),
      );
    }

    return content;
  }

  Widget _buildHeader(BuildContext context, AppLocalizations l10n, 
      ThemeData theme, DemoProperty property, List<DemoReview> reviews) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Reviews title and rating badge
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.reviews,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (reviews.isNotEmpty) ...[
                SizedBox(height: Spacing.xs),
                RatingBadge(
                  rating: property.rating,
                  reviewCount: property.reviewCount,
                  size: RatingBadgeSize.medium,
                ),
              ],
            ],
          ),
        ),
        
        // Write review button
        if (showWriteReviewButton) ...[
          SizedBox(width: Spacing.md),
          OutlinedButton.icon(
            onPressed: () => _showReviewForm(context, property),
            icon: Icon(Icons.rate_review, size: 18),
            label: Text(
              l10n.writeReview,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: Spacing.md,
                vertical: Spacing.sm,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildReviewsList(BuildContext context, AppLocalizations l10n, 
      ThemeData theme, List<DemoReview> reviews) {
    return Column(
      children: reviews.map((review) => 
        Padding(
          padding: EdgeInsets.only(bottom: Spacing.md),
          child: ReviewItem(review: review),
        ),
      ).toList(),
    );
  }

  Widget _buildEmptyState(BuildContext context, AppLocalizations l10n, 
      ThemeData theme) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Spacing.xl),
      margin: EdgeInsets.only(top: Spacing.lg),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(BorderRadiusTokens.medium),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.rate_review_outlined,
            size: 48,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          SizedBox(height: Spacing.md),
          Text(
            l10n.noReviewsYet,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Spacing.sm),
          Text(
            l10n.beTheFirstToReview,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (showWriteReviewButton) ...[
            SizedBox(height: Spacing.lg),
            FilledButton.icon(
              onPressed: () => _showReviewForm(context, 
                DemoData.getPropertyById(propertyId)!),
              icon: Icon(Icons.rate_review),
              label: Text(l10n.writeFirstReview),
            ),
          ],
        ],
      ),
    );
  }

  void _showReviewForm(BuildContext context, DemoProperty property) {
    ReviewFormSheet.show(
      context,
      propertyName: property.title,
      onSubmit: (rating, comment) {
        // In a real app, this would save to the backend
        debugPrint('Review submitted: $rating stars, "$comment"');
      },
    );
  }
}

/// Individual review item widget
class ReviewItem extends StatelessWidget {
  const ReviewItem({
    super.key,
    required this.review,
  });

  final DemoReview review;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).languageCode;

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: EdgeInsets.all(Spacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with user info and rating
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User avatar
                CircleAvatar(
                  radius: 20,
                  backgroundColor: theme.colorScheme.surfaceContainerHigh,
                  child: review.userAvatar != null
                      ? ClipOval(
                          child: Image.asset(
                            review.userAvatar!,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                _buildDefaultAvatar(theme),
                          ),
                        )
                      : _buildDefaultAvatar(theme),
                ),
                SizedBox(width: Spacing.md),
                
                // User name and date
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review.getLocalizedName(locale),
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: Spacing.xs),
                      Text(
                        review.formattedDate,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                
                // Rating
                CompactRatingBadge(rating: review.rating),
              ],
            ),
            
            SizedBox(height: Spacing.md),
            
            // Review comment
            Text(
              review.getLocalizedComment(locale),
              style: theme.textTheme.bodyMedium,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDefaultAvatar(ThemeData theme) {
    return Icon(
      Icons.person,
      color: theme.colorScheme.onSurfaceVariant,
      size: 24,
    );
  }
}

/// Compact reviews summary widget for use in property cards
class ReviewsSummary extends StatelessWidget {
  const ReviewsSummary({
    super.key,
    required this.rating,
    required this.reviewCount,
    this.size = RatingBadgeSize.small,
  });

  final double rating;
  final int reviewCount;
  final RatingBadgeSize size;

  @override
  Widget build(BuildContext context) {
    if (reviewCount == 0) {
      final l10n = AppLocalizations.of(context)!;
      final theme = Theme.of(context);
      
      return Text(
        l10n.noReviews,
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
    }

    return RatingBadge(
      rating: rating,
      reviewCount: reviewCount,
      size: size,
    );
  }
}
