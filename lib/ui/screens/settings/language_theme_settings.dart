import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/theme/app_theme.dart';
import '../../widgets/common/app_top_bar.dart';

/// Language and theme settings screen
class LanguageThemeSettings extends StatefulWidget {
  const LanguageThemeSettings({super.key});

  @override
  State<LanguageThemeSettings> createState() => _LanguageThemeSettingsState();
}

class _LanguageThemeSettingsState extends State<LanguageThemeSettings> {
  String _selectedLanguage = 'English';
  String _selectedTheme = 'System';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppTopBar(title: 'Language & Theme'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Spacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Language Section
            _buildSection(
              context,
              title: l10n.language,
              items: [
                _buildLanguageOption(
                  context,
                  title: 'English',
                  subtitle: 'English',
                  isSelected: _selectedLanguage == 'English',
                  onTap: () => _updateLanguage('English'),
                ),
                _buildLanguageOption(
                  context,
                  title: 'العربية',
                  subtitle: 'Arabic',
                  isSelected: _selectedLanguage == 'Arabic',
                  onTap: () => _updateLanguage('Arabic'),
                ),
              ],
            ),
            SizedBox(height: Spacing.lg),

            // Theme Section
            _buildSection(
              context,
              title: l10n.theme,
              items: [
                _buildThemeOption(
                  context,
                  icon: Icons.light_mode_outlined,
                  title: 'Light',
                  subtitle: 'Light theme for bright environments',
                  isSelected: _selectedTheme == 'Light',
                  onTap: () => _updateTheme('Light'),
                ),
                _buildThemeOption(
                  context,
                  icon: Icons.dark_mode_outlined,
                  title: 'Dark',
                  subtitle: 'Dark theme for low-light environments',
                  isSelected: _selectedTheme == 'Dark',
                  onTap: () => _updateTheme('Dark'),
                ),
                _buildThemeOption(
                  context,
                  icon: Icons.settings_system_daydream_outlined,
                  title: 'System',
                  subtitle: 'Follow system theme settings',
                  isSelected: _selectedTheme == 'System',
                  onTap: () => _updateTheme('System'),
                ),
              ],
            ),
            SizedBox(height: Spacing.xl),

            // Preview Section
            _buildSection(
              context,
              title: 'Preview',
              items: [
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(Spacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Current Settings',
                          style: theme.textTheme.titleMedium,
                        ),
                        SizedBox(height: Spacing.sm),
                        _buildPreviewItem(
                          context,
                          icon: Icons.language,
                          label: 'Language',
                          value: _selectedLanguage,
                        ),
                        _buildPreviewItem(
                          context,
                          icon: Icons.palette,
                          label: 'Theme',
                          value: _selectedTheme,
                        ),
                      ],
                    ),
                  ),
                ),
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
        Card(child: Column(children: items)),
      ],
    );
  }

  Widget _buildLanguageOption(
    BuildContext context, {
    required String title,
    required String subtitle,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: isSelected
            ? theme.colorScheme.primary
            : theme.colorScheme.surfaceContainerHighest,
        child: Icon(
          Icons.check,
          color: isSelected
              ? theme.colorScheme.onPrimary
              : Colors.transparent,
        ),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: isSelected
          ? Icon(
              Icons.check_circle,
              color: theme.colorScheme.primary,
            )
          : null,
      onTap: onTap,
    );
  }

  Widget _buildThemeOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: isSelected
            ? theme.colorScheme.primary
            : theme.colorScheme.surfaceContainerHighest,
        child: Icon(
          icon,
          color: isSelected
              ? theme.colorScheme.onPrimary
              : theme.colorScheme.onSurfaceVariant,
        ),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: isSelected
          ? Icon(
              Icons.check_circle,
              color: theme.colorScheme.primary,
            )
          : null,
      onTap: onTap,
    );
  }

  Widget _buildPreviewItem(
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
          Icon(
            icon,
            size: 20,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          SizedBox(width: Spacing.md),
          Text(
            '$label: ',
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  void _updateLanguage(String language) {
    setState(() {
      _selectedLanguage = language;
    });
    
    // TODO: Implement actual language switching
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Language changed to $language'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _updateTheme(String theme) {
    setState(() {
      _selectedTheme = theme;
    });
    
    // TODO: Implement actual theme switching
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Theme changed to $theme'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
