import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../app/navigation/app_router.dart';

/// Property details screen with booking option
class PropertyDetailsScreen extends StatefulWidget {
  const PropertyDetailsScreen({
    super.key,
    required this.propertyId,
  });

  final String propertyId;

  @override
  State<PropertyDetailsScreen> createState() => _PropertyDetailsScreenState();
}

class _PropertyDetailsScreenState extends State<PropertyDetailsScreen> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Image gallery app bar
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: theme.colorScheme.surfaceContainerHighest,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.image,
                        size: 80,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      SizedBox(height: Spacing.sm),
                      Text(
                        'Property Images',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(_isFavorite ? Icons.favorite : Icons.favorite_border),
                onPressed: () {
                  setState(() {
                    _isFavorite = !_isFavorite;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(_isFavorite ? 'Added to favorites' : 'Removed from favorites'),
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {
                  // TODO: Implement share
                },
              ),
            ],
          ),

          // Property details
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(Spacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and rating
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Beautiful Property ${widget.propertyId}',
                              style: theme.textTheme.headlineSmall,
                            ),
                            SizedBox(height: Spacing.xs),
                            Text(
                              'Downtown Area, City Center',
                              style: theme.textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.star, color: AppColors.warning500),
                              SizedBox(width: Spacing.xs),
                              Text('4.8', style: theme.textTheme.titleMedium),
                            ],
                          ),
                          Text('(124 reviews)', style: theme.textTheme.bodySmall),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: Spacing.lg),

                  // Quick info
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(Spacing.md),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildInfoItem(context, Icons.bed, '3 Beds'),
                          _buildInfoItem(context, Icons.bathroom, '2 Baths'),
                          _buildInfoItem(context, Icons.square_foot, '1,200 sqft'),
                          _buildInfoItem(context, Icons.people, '6 Guests'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: Spacing.lg),

                  // Description
                  Text('Description', style: theme.textTheme.titleLarge),
                  SizedBox(height: Spacing.sm),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.',
                    style: theme.textTheme.bodyLarge,
                  ),
                  SizedBox(height: Spacing.lg),

                  // Amenities
                  Text('Amenities', style: theme.textTheme.titleLarge),
                  SizedBox(height: Spacing.sm),
                  Wrap(
                    spacing: Spacing.sm,
                    runSpacing: Spacing.sm,
                    children: [
                      _buildAmenityChip('WiFi', Icons.wifi),
                      _buildAmenityChip('Pool', Icons.pool),
                      _buildAmenityChip('Parking', Icons.local_parking),
                      _buildAmenityChip('Kitchen', Icons.kitchen),
                      _buildAmenityChip('AC', Icons.ac_unit),
                      _buildAmenityChip('Pet Friendly', Icons.pets),
                    ],
                  ),
                  SizedBox(height: Spacing.lg),

                  // Host info
                  Text('Host Information', style: theme.textTheme.titleLarge),
                  SizedBox(height: Spacing.sm),
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(Spacing.md),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: theme.colorScheme.primary,
                            child: Text(
                              'JD',
                              style: TextStyle(color: theme.colorScheme.onPrimary),
                            ),
                          ),
                          SizedBox(width: Spacing.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('John Doe', style: theme.textTheme.titleMedium),
                                Text('Superhost • 5 years hosting', style: theme.textTheme.bodySmall),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // TODO: Contact host
                            },
                            child: const Text('Contact'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: Spacing.xl * 2), // Space for bottom button
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(Spacing.md),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          border: Border(
            top: BorderSide(color: theme.colorScheme.outline),
          ),
        ),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '\$150/night',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    Text('+ \$25 fees', style: theme.textTheme.bodySmall),
                  ],
                ),
              ),
              SizedBox(width: Spacing.md),
              ElevatedButton(
                onPressed: () => AppRouter.goToBookingRequest(context, widget.propertyId),
                child: const Text('Book Now'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem(BuildContext context, IconData icon, String label) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Icon(icon, color: theme.colorScheme.primary),
        SizedBox(height: Spacing.xs),
        Text(label, style: theme.textTheme.bodySmall),
      ],
    );
  }

  Widget _buildAmenityChip(String label, IconData icon) {
    return Chip(
      avatar: Icon(icon, size: 16),
      label: Text(label),
    );
  }
}
