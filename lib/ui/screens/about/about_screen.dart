import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/theme/app_theme.dart';
import '../../widgets/common/app_top_bar.dart';

/// About screen with app information and legal links
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppTopBar(title: 'About'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Spacing.lg),
        child: Column(
          children: [
            // App logo and info
            Icon(
              Icons.home_work,
              size: 100,
              color: theme.colorScheme.primary,
            ),
            SizedBox(height: Spacing.lg),
            Text(
              l10n.appTitle,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: Spacing.sm),
            Text(
              'Version 1.0.0',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: Spacing.xl),

            // Description
            Card(
              child: Padding(
                padding: EdgeInsets.all(Spacing.lg),
                child: Column(
                  children: [
                    Text(
                      'Welcome to Maawa',
                      style: theme.textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: Spacing.md),
                    Text(
                      'Maawa is your trusted platform for discovering and booking amazing properties. '
                      'Whether you\'re looking for a cozy apartment, a luxury villa, or a unique stay, '
                      'we connect you with the perfect accommodation for your needs.',
                      style: theme.textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: Spacing.lg),

            // Features
            Card(
              child: Padding(
                padding: EdgeInsets.all(Spacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Features',
                      style: theme.textTheme.titleLarge,
                    ),
                    SizedBox(height: Spacing.md),
                    _buildFeatureItem(
                      context,
                      icon: Icons.search,
                      title: 'Smart Search',
                      description: 'Find properties with advanced filters and AI recommendations',
                    ),
                    _buildFeatureItem(
                      context,
                      icon: Icons.security,
                      title: 'Secure Booking',
                      description: 'Safe and secure payment processing with instant confirmation',
                    ),
                    _buildFeatureItem(
                      context,
                      icon: Icons.support_agent,
                      title: '24/7 Support',
                      description: 'Round-the-clock customer support for all your needs',
                    ),
                    _buildFeatureItem(
                      context,
                      icon: Icons.verified,
                      title: 'Verified Properties',
                      description: 'All properties are verified and reviewed by our team',
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: Spacing.lg),

            // Legal links
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.description_outlined),
                    title: const Text('Terms of Service'),
                    trailing: const Icon(Icons.open_in_new),
                    onTap: () {
                      // TODO: Open terms of service
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.privacy_tip_outlined),
                    title: const Text('Privacy Policy'),
                    trailing: const Icon(Icons.open_in_new),
                    onTap: () {
                      // TODO: Open privacy policy
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.gavel_outlined),
                    title: const Text('Legal Information'),
                    trailing: const Icon(Icons.open_in_new),
                    onTap: () {
                      // TODO: Open legal information
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: Spacing.lg),

            // Contact info
            Card(
              child: Padding(
                padding: EdgeInsets.all(Spacing.lg),
                child: Column(
                  children: [
                    Text(
                      'Contact Us',
                      style: theme.textTheme.titleLarge,
                    ),
                    SizedBox(height: Spacing.md),
                    _buildContactItem(
                      context,
                      icon: Icons.email_outlined,
                      label: 'Email',
                      value: 'support@maawa.com',
                    ),
                    _buildContactItem(
                      context,
                      icon: Icons.phone_outlined,
                      label: 'Phone',
                      value: '+1 (555) 123-4567',
                    ),
                    _buildContactItem(
                      context,
                      icon: Icons.language_outlined,
                      label: 'Website',
                      value: 'www.maawa.com',
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: Spacing.xl),

            // Copyright
            Text(
              '© 2024 Maawa. All rights reserved.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
  }) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Spacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: theme.colorScheme.primary),
          SizedBox(width: Spacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: theme.textTheme.titleSmall),
                Text(
                  description,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Spacing.xs),
      child: Row(
        children: [
          Icon(icon, color: theme.colorScheme.primary, size: 20),
          SizedBox(width: Spacing.md),
          Text(
            '$label: ',
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(value, style: theme.textTheme.bodyMedium),
        ],
      ),
    );
  }
}
