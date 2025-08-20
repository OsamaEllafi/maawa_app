import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:math' as math;
import '../../../core/theme/app_theme.dart';
import '../../../demo/demo_data.dart';
import '../../../core/data/amenities_data.dart';
import '../../widgets/media/media_carousel.dart';
import '../../widgets/common/skeleton_list.dart';
import '../../widgets/common/app_top_bar.dart';
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
    final isReducedMotion = MediaQuery.of(context).accessibleNavigation;

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
                              queryParameters: {'propertyId': _property!.id},
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
                  Text(
                    'Reviews',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: Spacing.md),
                  ..._property!.reviews
                      .take(3)
                      .map(
                        (review) => Container(
                          margin: EdgeInsets.only(bottom: Spacing.md),
                          padding: EdgeInsets.all(Spacing.md),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(
                              BorderRadiusTokens.medium,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 16,
                                    backgroundColor: theme.colorScheme.primary,
                                    child: Text(
                                      review.userName[0].toUpperCase(),
                                      style: theme.textTheme.bodySmall
                                          ?.copyWith(
                                            color: theme.colorScheme.onPrimary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                  SizedBox(width: Spacing.sm),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          review.userName,
                                          style: theme.textTheme.bodyMedium
                                              ?.copyWith(
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                        Row(
                                          children: [
                                            ...List.generate(
                                              5,
                                              (index) => Icon(
                                                Icons.star_rounded,
                                                size: 16,
                                                color: index < review.rating
                                                    ? AppColors.warning500
                                                    : theme
                                                          .colorScheme
                                                          .onSurfaceVariant,
                                              ),
                                            ),
                                            SizedBox(width: Spacing.xs),
                                            Text(
                                              review.rating.toString(),
                                              style: theme.textTheme.bodySmall
                                                  ?.copyWith(
                                                    color: theme
                                                        .colorScheme
                                                        .onSurfaceVariant,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: Spacing.sm),
                              Text(
                                review.getLocalizedComment(l10n),
                                style: theme.textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
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
