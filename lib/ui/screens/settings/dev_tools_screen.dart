import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/theme/app_theme.dart';
import '../../../app/navigation/app_router.dart';
import '../../../app/models/user_role.dart';
import '../../widgets/debug/layout_debug_panel.dart';
import '../../widgets/common/app_top_bar.dart';

/// Developer tools screen with style guide access and role simulation
class DevToolsScreen extends StatefulWidget {
  const DevToolsScreen({
    super.key,
    required this.onThemeChanged,
    required this.onLocaleChanged,
    required this.currentThemeMode,
    required this.currentLocale,
  });

  final Function(ThemeMode) onThemeChanged;
  final Function(Locale) onLocaleChanged;
  final ThemeMode currentThemeMode;
  final Locale currentLocale;

  @override
  State<DevToolsScreen> createState() => _DevToolsScreenState();
}

class _DevToolsScreenState extends State<DevToolsScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppTopBar(
        title: l10n.devToolsTitle,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Spacing.md),
        child: Column(
          children: [
            _buildSection(
              context,
              title: 'Design System',
              items: [
                _buildListItem(
                  context,
                  icon: Icons.palette_outlined,
                  title: 'Style Guide',
                  subtitle: 'Component library and design tokens',
                  onTap: () => context.go(AppRouter.styleGuide),
                ),
                _buildListItem(
                  context,
                  icon: Icons.color_lens_outlined,
                  title: 'Theme Preview',
                  subtitle: 'Preview light and dark themes',
                  onTap: () {
                    // TODO: Show theme preview
                  },
                ),
              ],
            ),
            SizedBox(height: Spacing.lg),

            _buildSection(
              context,
              title: 'Debug Tools',
              items: [
                _buildListItem(
                  context,
                  icon: Icons.bug_report_outlined,
                  title: 'Layout Debug Panel',
                  subtitle: 'Test overflow scenarios and text scaling',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LayoutDebugPanel(),
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: Spacing.lg),

            _buildSection(
              context,
              title: 'Theme Controls',
              items: [
                ListTile(
                  leading: const Icon(Icons.brightness_6),
                  title: const Text('Theme Mode'),
                  subtitle: Text(_getThemeModeLabel(widget.currentThemeMode)),
                  trailing: DropdownButton<ThemeMode>(
                    value: widget.currentThemeMode,
                    onChanged: (mode) {
                      if (mode != null) {
                        widget.onThemeChanged(mode);
                      }
                    },
                    items: const [
                      DropdownMenuItem(
                        value: ThemeMode.system,
                        child: Text('System'),
                      ),
                      DropdownMenuItem(
                        value: ThemeMode.light,
                        child: Text('Light'),
                      ),
                      DropdownMenuItem(
                        value: ThemeMode.dark,
                        child: Text('Dark'),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.language),
                  title: Text(l10n.language),
                  subtitle: Text(_getLanguageLabel(widget.currentLocale)),
                  trailing: DropdownButton<Locale>(
                    value: widget.currentLocale,
                    onChanged: (locale) {
                      if (locale != null) {
                        widget.onLocaleChanged(locale);
                      }
                    },
                    items: const [
                      DropdownMenuItem(
                        value: Locale('en'),
                        child: Text('English'),
                      ),
                      DropdownMenuItem(
                        value: Locale('ar'),
                        child: Text('العربية'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: Spacing.lg),

            _buildSection(
              context,
              title: 'Role Simulation',
              items: [
                ValueListenableBuilder<UserRole>(
                  valueListenable: AppRouter.currentRole,
                  builder: (context, currentRole, child) {
                    return Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.person_outline),
                          title: const Text('Current Role'),
                          subtitle: Text(currentRole.displayName),
                          trailing: Text(
                            currentRole.description,
                            style: theme.textTheme.bodySmall,
                          ),
                        ),
                        ...UserRole.allRoles.map((role) {
                          final isSelected = role == currentRole;
                          return RadioListTile<UserRole>(
                            title: Text(role.displayName),
                            subtitle: Text(role.description),
                            value: role,
                            groupValue: currentRole,
                            onChanged: (selectedRole) {
                              if (selectedRole != null) {
                                AppRouter.currentRole.value = selectedRole;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Switched to ${selectedRole.displayName} role'),
                                  ),
                                );
                              }
                            },
                          );
                        }),
                      ],
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: Spacing.lg),

            _buildSection(
              context,
              title: 'Navigation Testing',
              items: [
                _buildListItem(
                  context,
                  icon: Icons.home_outlined,
                  title: 'Tenant Routes',
                  subtitle: 'Test tenant navigation flow',
                  onTap: () => context.go(AppRouter.tenantHome),
                ),
                _buildListItem(
                  context,
                  icon: Icons.business_outlined,
                  title: 'Owner Routes',
                  subtitle: 'Test owner property management',
                  onTap: () => context.go(AppRouter.ownerProperties),
                ),
                _buildListItem(
                  context,
                  icon: Icons.admin_panel_settings_outlined,
                  title: 'Admin Routes',
                  subtitle: 'Test admin dashboard',
                  onTap: () => context.go(AppRouter.adminDashboard),
                ),
              ],
            ),
            SizedBox(height: Spacing.lg),

            _buildSection(
              context,
              title: 'Debug Information',
              items: [
                _buildInfoItem('App Version', '1.0.0+1'),
                _buildInfoItem('Flutter Version', '3.8.1'),
                _buildInfoItem('Build Mode', 'Debug'),
                _buildInfoItem('Platform', Theme.of(context).platform.name),
              ],
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

  Widget _buildInfoItem(String label, String value) {
    return ListTile(
      title: Text(label),
      trailing: Text(value),
    );
  }

  String _getThemeModeLabel(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return 'System default';
      case ThemeMode.light:
        return 'Light mode';
      case ThemeMode.dark:
        return 'Dark mode';
    }
  }

  String _getLanguageLabel(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return 'English';
      case 'ar':
        return 'العربية (Arabic)';
      default:
        return locale.languageCode;
    }
  }
}
