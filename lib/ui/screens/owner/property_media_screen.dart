import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../widgets/common/app_top_bar.dart';

/// Property media management screen for owners
class PropertyMediaScreen extends StatelessWidget {
  const PropertyMediaScreen({super.key, required this.propertyId});

  final String propertyId;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppTopBar(
        title: 'Media',
        actions: [
          IconButton(
            icon: const Icon(Icons.add_a_photo),
            onPressed: () {
              // TODO: Add media
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(Spacing.lg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.photo_library,
                size: 80,
                color: theme.colorScheme.primary,
              ),
              SizedBox(height: Spacing.lg),
              Text('Property Media', style: theme.textTheme.headlineMedium),
              SizedBox(height: Spacing.md),
              Text(
                'Property ID: $propertyId',
                style: theme.textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: Spacing.md),
              Text(
                'Photo and video management will be implemented here',
                style: theme.textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
