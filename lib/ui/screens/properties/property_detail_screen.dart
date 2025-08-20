import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:math' as math;
import '../../../core/theme/app_theme.dart';
import '../../../demo/demo_data.dart';
import '../../../core/data/amenities_data.dart';
import '../../../l10n/app_localizations.dart';
import '../../widgets/media/media_carousel.dart';
import '../../widgets/common/skeleton_list.dart';
import '../../widgets/common/app_top_bar.dart';
import '../../widgets/reviews/reviews_list.dart';
import '../../widgets/reviews/review_form_sheet.dart';
import '../../widgets/reviews/rating_badge.dart';
import '../../../app/navigation/app_router.dart';

/// Property detail screen
class PropertyDetailScreen extends StatefulWidget {
  final String propertyId;

  const PropertyDetailScreen({super.key, required this.propertyId});

  @override
  State<PropertyDetailScreen> createState() => _PropertyDetailScreenState();
}

class _PropertyDetailScreenState extends State<PropertyDetailScreen> {
  DemoProperty? _property;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProperty();
  }

  void _loadProperty() {
    // Simulate loading delay
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _property = DemoData.getPropertyById(widget.propertyId);
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = Localizations.localeOf(context).languageCode;

    // Compute bounded media height
    final mediaHeight = math.min(
      320.0,
      MediaQuery.sizeOf(context).height * 0.45,
    );
    debugPrint('mediaHeight=$mediaHeight');

    if (_isLoading) {
      return Scaffold(
        appBar: AppTopBar(title: 'Property Details'),
        body: const PropertyDetailSkeleton(),
      );
    }

    if (_property == null) {
      return Scaffold(
        appBar: AppTopBar(title: 'Property Not Found'),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: theme.colorScheme.error,
              ),
              SizedBox(height: Spacing.lg),
              Text(
                'Property not found',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: Spacing.md),
              Text(
                'The property you are looking for does not exist.',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: Spacing.xl),
              FilledButton.icon(
                onPressed: () => context.go(AppRouter.tenantHome),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Back to Home'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Media carousel with bounded height
          SliverToBoxAdapter(
            child: SizedBox(
              height: mediaHeight,
              child: MediaCarousel(
                imageUrls: _property!.imageUrls,
                videoUrl: _property!.videoUrl,
              ),
            ),
          ),

          // Property content
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(Spacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Property header
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _property!.getLocalizedTitle(l10n),
                              style: theme.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: Spacing.xs),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  size: 16,
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                                SizedBox(width: Spacing.xs),
                                Expanded(
                                  child: Text(
                                    _property!.getLocalizedLocation(l10n),
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: theme.colorScheme.onSurfaceVariant,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
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
                          _property!.getLocalizedType(l10n),
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: theme.colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: Spacing.md),

                  // Rating and reviews
                  Row(
                    children: [
                      Icon(
                        Icons.star_rounded,
                        size: 20,
                        color: AppColors.warning500,
                      ),
                      SizedBox(width: Spacing.xs),
                      Text(
                        _property!.rating.toString(),
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: Spacing.xs),
                      Text(
                        '(${_property!.reviewCount} reviews)',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: Spacing.lg),

                  // Price section
                  Container(
                    padding: EdgeInsets.all(Spacing.lg),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(
                        BorderRadiusTokens.medium,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Price per night',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                              SizedBox(height: Spacing.xs),
                              Text(
                                _property!.formattedPrice,
                                style: theme.textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        FilledButton.icon(
                          onPressed: () {
                            debugPrint(
                              'PUSH → bookingRequest (shell nav) for property: ${_property!.id}',
                            );
                            context.pushNamed(
                              'bookingRequest',
                              pathParameters: {'id': _property!.id},
                            );
                          },
                          icon: const Icon(Icons.calendar_today),
                          label: const Text('Request Booking'),
                          style: FilledButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal: Spacing.lg,
                              vertical: Spacing.md,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: Spacing.xl),

                  // Description
                  Text(
                    'Description',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: Spacing.md),
                  Text(
                    _property!.getLocalizedDescription(l10n),
                    style: theme.textTheme.bodyLarge,
                  ),

                  SizedBox(height: Spacing.xl),

                  // Amenities
                  Text(
                    'Amenities',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: Spacing.md),
                  Wrap(
                    spacing: Spacing.sm,
                    runSpacing: Spacing.sm,
                    children: _property!.amenityIds.map((amenityId) {
                      final amenity = AmenitiesData.allAmenities.firstWhere(
                        (a) => a.id == amenityId,
                      );
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: Spacing.md,
                          vertical: Spacing.sm,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              amenity.icon,
                              size: 16,
                              color: theme.colorScheme.primary,
                            ),
                            SizedBox(width: Spacing.xs),
                            Text(
                              amenity.getLocalizedName(l10n),
                              style: theme.textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),

                  SizedBox(height: Spacing.xl),

                  // Reviews section
                  _ReviewsSection(propertyId: _property!.id),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Reviews section widget
class _ReviewsSection extends StatefulWidget {
  const _ReviewsSection({required this.propertyId});
  final String propertyId;

  @override
  State<_ReviewsSection> createState() => _ReviewsSectionState();
}

class _ReviewsSectionState extends State<_ReviewsSection> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final (avg: avg, count: count) = DemoData.reviewsAggregate(
      widget.propertyId,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header row: title + average badge + Write button
        Row(
          children: [
            Expanded(
              child: Text(
                l10n.reviews,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (count > 0)
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 8),
                child: RatingBadge(
                  rating: avg,
                  reviewCount: count,
                  size: RatingBadgeSize.small,
                ),
              ),
            FilledButton.icon(
              onPressed: _onWriteReviewPressed,
              icon: const Icon(Icons.rate_review),
              label: Text(l10n.writeReview),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ReviewsList(
          propertyId: widget.propertyId,
          showWriteReviewButton: false,
        ),
      ],
    );
  }

  Future<void> _onWriteReviewPressed() async {
    final property = DemoData.getPropertyById(widget.propertyId);
    if (property == null) return;

    final review = await ReviewFormSheet.show(
      context,
      propertyId: widget.propertyId,
      propertyName: property.title,
    );

    // When the sheet returns a review (success), refresh aggregates/list
    if (review != null && mounted) setState(() {});
  }
}
