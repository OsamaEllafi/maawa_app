import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/theme/app_theme.dart';

/// Skeleton loading widget for property lists
class SkeletonList extends StatelessWidget {
  final bool isGridView;
  final int itemCount;
  final double itemHeight;
  final double itemWidth;

  const SkeletonList({
    super.key,
    this.isGridView = false,
    this.itemCount = 6,
    this.itemHeight = 280,
    this.itemWidth = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isReducedMotion = MediaQuery.of(context).accessibleNavigation;

    if (isReducedMotion) {
      return _buildStaticSkeleton(theme);
    }

    return Shimmer.fromColors(
      baseColor: theme.colorScheme.surfaceContainerHighest,
      highlightColor: theme.colorScheme.surface,
      child: _buildSkeletonContent(theme),
    );
  }

  Widget _buildStaticSkeleton(ThemeData theme) {
    return _buildSkeletonContent(theme);
  }

  Widget _buildSkeletonContent(ThemeData theme) {
    if (isGridView) {
      return GridView.builder(
        padding: EdgeInsets.all(Spacing.lg),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: Spacing.md,
          mainAxisSpacing: Spacing.md,
        ),
        itemCount: itemCount,
        itemBuilder: (context, index) => _buildGridSkeletonItem(theme),
      );
    } else {
      return ListView.builder(
        padding: EdgeInsets.all(Spacing.lg),
        itemCount: itemCount,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(bottom: Spacing.md),
          child: _buildListSkeletonItem(theme),
        ),
      );
    }
  }

  Widget _buildListSkeletonItem(ThemeData theme) {
    return Container(
      height: 120, // Fixed height for list items
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(BorderRadiusTokens.medium),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image skeleton
          Container(
            width: 160,
            height: 120,
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerLow,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(BorderRadiusTokens.medium),
                bottomLeft: Radius.circular(BorderRadiusTokens.medium),
              ),
            ),
          ),
          
          // Content skeleton
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(Spacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title skeleton
                  Container(
                    height: 16,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  
                  SizedBox(height: Spacing.sm),
                  
                  // Location skeleton
                  Container(
                    height: 14,
                    width: 120,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  
                  SizedBox(height: Spacing.sm),
                  
                  // Rating skeleton
                  Row(
                    children: [
                      Container(
                        height: 12,
                        width: 60,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceContainerLow,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      SizedBox(width: Spacing.sm),
                      Container(
                        height: 12,
                        width: 40,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceContainerLow,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                  
                  const Spacer(),
                  
                  // Price skeleton
                  Container(
                    height: 18,
                    width: 80,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(4),
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

  Widget _buildGridSkeletonItem(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(BorderRadiusTokens.medium),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image skeleton
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerLow,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(BorderRadiusTokens.medium),
                  topRight: Radius.circular(BorderRadiusTokens.medium),
                ),
              ),
            ),
          ),
          
          // Content skeleton
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(Spacing.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title skeleton
                  Container(
                    height: 14,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  
                  SizedBox(height: Spacing.xs),
                  
                  // Location skeleton
                  Container(
                    height: 12,
                    width: 80,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  
                  SizedBox(height: Spacing.xs),
                  
                  // Rating skeleton
                  Row(
                    children: [
                      Container(
                        height: 10,
                        width: 40,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceContainerLow,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      SizedBox(width: Spacing.xs),
                      Container(
                        height: 10,
                        width: 30,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceContainerLow,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                  
                  const Spacer(),
                  
                  // Price skeleton
                  Container(
                    height: 16,
                    width: 60,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(4),
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

/// Skeleton loading widget for property details
class PropertyDetailSkeleton extends StatelessWidget {
  const PropertyDetailSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isReducedMotion = MediaQuery.of(context).accessibleNavigation;

    if (isReducedMotion) {
      return _buildStaticSkeleton(theme);
    }

    return Shimmer.fromColors(
      baseColor: theme.colorScheme.surfaceContainerHighest,
      highlightColor: theme.colorScheme.surface,
      child: _buildSkeletonContent(theme),
    );
  }

  Widget _buildStaticSkeleton(ThemeData theme) {
    return _buildSkeletonContent(theme);
  }

  Widget _buildSkeletonContent(ThemeData theme) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image skeleton
          Container(
            height: 300,
            width: double.infinity,
            color: theme.colorScheme.surfaceContainerLow,
          ),
          
          Padding(
            padding: EdgeInsets.all(Spacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title skeleton
                Container(
                  height: 24,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                
                SizedBox(height: Spacing.sm),
                
                // Location skeleton
                Container(
                  height: 16,
                  width: 150,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                
                SizedBox(height: Spacing.md),
                
                // Rating skeleton
                Row(
                  children: [
                    Container(
                      height: 16,
                      width: 80,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    SizedBox(width: Spacing.sm),
                    Container(
                      height: 16,
                      width: 60,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: Spacing.lg),
                
                // Price skeleton
                Container(
                  height: 28,
                  width: 120,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                
                SizedBox(height: Spacing.lg),
                
                // Description skeleton
                ...List.generate(3, (index) => Padding(
                  padding: EdgeInsets.only(bottom: Spacing.sm),
                  child: Container(
                    height: 16,
                    width: index == 2 ? 200 : double.infinity,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                )),
                
                SizedBox(height: Spacing.lg),
                
                // Amenities skeleton
                Container(
                  height: 20,
                  width: 100,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                
                SizedBox(height: Spacing.md),
                
                // Amenity chips skeleton
                Wrap(
                  spacing: Spacing.sm,
                  runSpacing: Spacing.sm,
                  children: List.generate(6, (index) => Container(
                    height: 32,
                    width: 80,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
