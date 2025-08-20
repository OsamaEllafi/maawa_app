import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/theme/app_theme.dart';
import '../../../app/navigation/app_router.dart';
import '../../widgets/common/app_top_bar.dart';

/// Settings screen with app preferences and options
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppTopBar(title: l10n.settings),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Spacing.md),
        child: Column(
          children: [
            _buildSection(
              context,
              title: 'Preferences',
              items: [
                _buildListItem(
                  context,
                  icon: Icons.notifications_outlined,
                  title: 'Notifications',
                  subtitle: 'Manage your notification preferences',
                  onTap: () {
                    // TODO: Navigate to notification settings
                  },
                ),
                _buildListItem(
                  context,
                  icon: Icons.language_outlined,
                  title: l10n.language,
                  subtitle: 'English',
                  onTap: () {
                    // TODO: Show language picker
                  },
                ),
                _buildListItem(
                  context,
                  icon: Icons.dark_mode_outlined,
                  title: l10n.theme,
                  subtitle: 'System default',
                  onTap: () {
                    // TODO: Show theme picker
                  },
                ),
                _buildListItem(
                  context,
                  icon: Icons.location_on_outlined,
                  title: 'Location Services',
                  subtitle: 'Help us find properties near you',
                  trailing: Switch(
                    value: true,
                    onChanged: (value) {
                      // TODO: Toggle location services
                    },
                  ),
                  onTap: () {
                    // TODO: Navigate to location settings
                  },
                ),
              ],
            ),
            SizedBox(height: Spacing.lg),

            _buildSection(
              context,
              title: 'Privacy & Security',
              items: [
                _buildListItem(
                  context,
                  icon: Icons.security_outlined,
                  title: 'Privacy Policy',
                  subtitle: 'Read our privacy policy',
                  onTap: () {
                    // TODO: Open privacy policy
                  },
                ),
                _buildListItem(
                  context,
                  icon: Icons.description_outlined,
                  title: 'Terms of Service',
                  subtitle: 'Read our terms and conditions',
                  onTap: () {
                    // TODO: Open terms of service
                  },
                ),
                _buildListItem(
                  context,
                  icon: Icons.lock_outlined,
                  title: 'Change Password',
                  subtitle: 'Update your account password',
                  onTap: () {
                    // TODO: Navigate to change password
                  },
                ),
                _buildListItem(
                  context,
                  icon: Icons.delete_outline,
                  title: 'Delete Account',
                  subtitle: 'Permanently delete your account',
                  onTap: () => _showDeleteAccountDialog(context),
                ),
              ],
            ),
            SizedBox(height: Spacing.lg),

            _buildSection(
              context,
              title: 'Support',
              items: [
                _buildListItem(
                  context,
                  icon: Icons.help_outline,
                  title: 'Help Center',
                  subtitle: 'Get help and support',
                  onTap: () {
                    // TODO: Navigate to help center
                  },
                ),
                _buildListItem(
                  context,
                  icon: Icons.feedback_outlined,
                  title: 'Send Feedback',
                  subtitle: 'Help us improve the app',
                  onTap: () {
                    // TODO: Open feedback form
                  },
                ),
                _buildListItem(
                  context,
                  icon: Icons.star_outline,
                  title: 'Rate the App',
                  subtitle: 'Rate us on the app store',
                  onTap: () {
                    // TODO: Open app store rating
                  },
                ),
              ],
            ),
            SizedBox(height: Spacing.lg),

            _buildSection(
              context,
              title: 'Developer',
              items: [
                _buildListItem(
                  context,
                  icon: Icons.developer_mode,
                  title: 'Dev Tools',
                  subtitle: 'Style guide and development tools',
                  onTap: () => context.go(AppRouter.devTools),
                ),
                _buildListItem(
                  context,
                  icon: Icons.info_outline,
                  title: 'About',
                  subtitle: 'App version and information',
                  onTap: () => context.go(AppRouter.about),
                ),
              ],
            ),
            SizedBox(height: Spacing.xl),

            // App version
            Text(
              'Version 1.0.0',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required List<Widget> items,
  }) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Spacing.sm),
          child: Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
        ),
        SizedBox(height: Spacing.sm),
        Card(
          child: Column(children: items),
        ),
      ],
    );
  }

  Widget _buildListItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: trailing ?? const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
          'Are you sure you want to delete your account? This action cannot be undone and all your data will be permanently removed.',
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.pop();
              // TODO: Implement account deletion
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Account deletion requested'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
