import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../l10n/app_localizations.dart';
import '../widgets/common/app_top_bar.dart';

/// Style Guide screen that showcases all design system components
class StyleGuideScreen extends StatelessWidget {
  const StyleGuideScreen({
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
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppTopBar(
        title: l10n.styleGuideTitle,
        actions: [
          // Theme toggle
          PopupMenuButton<ThemeMode>(
            initialValue: currentThemeMode,
            onSelected: onThemeChanged,
            itemBuilder: (context) => [
              const PopupMenuItem(value: ThemeMode.light, child: Text('Light')),
              const PopupMenuItem(value: ThemeMode.dark, child: Text('Dark')),
              const PopupMenuItem(
                value: ThemeMode.system,
                child: Text('System'),
              ),
            ],
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Icon(Icons.brightness_6),
            ),
          ),
          // Language toggle
          PopupMenuButton<Locale>(
            initialValue: currentLocale,
            onSelected: onLocaleChanged,
            itemBuilder: (context) => [
              const PopupMenuItem(value: Locale('en'), child: Text('English')),
              const PopupMenuItem(value: Locale('ar'), child: Text('العربية')),
            ],
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Icon(Icons.language),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Spacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              context,
              l10n.typography,
              _buildTypographySection(context),
            ),
            _buildSection(context, l10n.colors, _buildColorsSection(context)),
            _buildSection(context, l10n.buttons, _buildButtonsSection(context)),
            _buildSection(context, l10n.inputs, _buildInputsSection(context)),
            _buildSection(context, l10n.cards, _buildCardsSection(context)),
            _buildSection(context, l10n.spacing, _buildSpacingSection(context)),
            _buildSection(
              context,
              l10n.animations,
              _buildAnimationsSection(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, Widget content) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: Spacing.lg),
          child: Text(
            title,
            style: theme.textTheme.headlineMedium?.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
        ),
        content,
        const SizedBox(height: Spacing.xl),
      ],
    );
  }

  Widget _buildTypographySection(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.displayLarge, style: theme.textTheme.displayLarge),
        const SizedBox(height: Spacing.sm),
        Text(l10n.displayMedium, style: theme.textTheme.displayMedium),
        const SizedBox(height: Spacing.sm),
        Text(l10n.displaySmall, style: theme.textTheme.displaySmall),
        const SizedBox(height: Spacing.sm),
        Text(l10n.headlineLarge, style: theme.textTheme.headlineLarge),
        const SizedBox(height: Spacing.sm),
        Text(l10n.headlineMedium, style: theme.textTheme.headlineMedium),
        const SizedBox(height: Spacing.sm),
        Text(l10n.headlineSmall, style: theme.textTheme.headlineSmall),
        const SizedBox(height: Spacing.sm),
        Text(l10n.titleLarge, style: theme.textTheme.titleLarge),
        const SizedBox(height: Spacing.sm),
        Text(l10n.titleMedium, style: theme.textTheme.titleMedium),
        const SizedBox(height: Spacing.sm),
        Text(l10n.titleSmall, style: theme.textTheme.titleSmall),
        const SizedBox(height: Spacing.sm),
        Text(l10n.bodyLarge, style: theme.textTheme.bodyLarge),
        const SizedBox(height: Spacing.sm),
        Text(l10n.bodyMedium, style: theme.textTheme.bodyMedium),
        const SizedBox(height: Spacing.sm),
        Text(l10n.bodySmall, style: theme.textTheme.bodySmall),
        const SizedBox(height: Spacing.sm),
        Text(l10n.labelLarge, style: theme.textTheme.labelLarge),
        const SizedBox(height: Spacing.sm),
        Text(l10n.labelMedium, style: theme.textTheme.labelMedium),
        const SizedBox(height: Spacing.sm),
        Text(l10n.labelSmall, style: theme.textTheme.labelSmall),
      ],
    );
  }

  Widget _buildColorsSection(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Wrap(
      spacing: Spacing.sm,
      runSpacing: Spacing.sm,
      children: [
        _buildColorChip(context, l10n.primary, theme.colorScheme.primary),
        _buildColorChip(context, l10n.secondary, theme.colorScheme.secondary),
        _buildColorChip(context, l10n.surface, theme.colorScheme.surface),
                 _buildColorChip(context, l10n.background, Theme.of(context).colorScheme.surface),
        _buildColorChip(context, l10n.error, theme.colorScheme.error),
        _buildColorChip(context, l10n.success, AppColors.success500),
        _buildColorChip(context, l10n.warning, AppColors.warning500),
      ],
    );
  }

  Widget _buildColorChip(BuildContext context, String label, Color color) {
    return Container(
      width: 100,
      height: 60,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(BorderRadiusTokens.medium),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: color.computeLuminance() > 0.5 ? Colors.black : Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildButtonsSection(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                child: Text(l10n.primaryButton),
              ),
            ),
            SizedBox(width: Spacing.sm),
            Expanded(
              child: OutlinedButton(
                onPressed: () {},
                child: Text(l10n.secondaryButton),
              ),
            ),
          ],
        ),
        const SizedBox(height: Spacing.sm),
        Row(
          children: [
            Expanded(
              child: TextButton(onPressed: () {}, child: Text(l10n.textButton)),
            ),
            SizedBox(width: Spacing.sm),
            Expanded(
              child: ElevatedButton(
                onPressed: null,
                child: Text(l10n.disabledButton),
              ),
            ),
          ],
        ),
        const SizedBox(height: Spacing.sm),
                 Row(
           children: [
             IconButton(onPressed: () {}, icon: const Icon(Icons.favorite)),
             SizedBox(width: Spacing.sm),
             FloatingActionButton(
               onPressed: () {},
               child: const Icon(Icons.add),
             ),
           ],
         ),
      ],
    );
  }

  Widget _buildInputsSection(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: l10n.textField,
            hintText: l10n.placeholder,
          ),
        ),
        const SizedBox(height: Spacing.sm),
        TextField(
          decoration: InputDecoration(
            labelText: l10n.emailField,
            hintText: 'Enter email...',
            prefixIcon: const Icon(Icons.email),
          ),
        ),
        const SizedBox(height: Spacing.sm),
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            labelText: l10n.passwordField,
            hintText: 'Enter password...',
            prefixIcon: const Icon(Icons.lock),
          ),
        ),
        const SizedBox(height: Spacing.sm),
        TextField(
          decoration: InputDecoration(
            labelText: l10n.searchField,
            hintText: 'Search...',
            prefixIcon: const Icon(Icons.search),
          ),
        ),
      ],
    );
  }

  Widget _buildCardsSection(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(Spacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.basicCard,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: Spacing.sm),
                Text(l10n.cardContent),
              ],
            ),
          ),
        ),
        const SizedBox(height: Spacing.sm),
        Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(Spacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.elevatedCard,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: Spacing.sm),
                const Text(
                  'This card has higher elevation for more prominent content.',
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: Spacing.sm),
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(BorderRadiusTokens.medium),
            side: BorderSide(color: Colors.grey.shade300),
          ),
          child: Padding(
            padding: const EdgeInsets.all(Spacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.outlinedCard,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: Spacing.sm),
                const Text(
                  'This card has a border outline instead of elevation.',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSpacingSection(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        _buildSpacingExample(l10n.xs, Spacing.xs),
        _buildSpacingExample(l10n.sm, Spacing.sm),
        _buildSpacingExample(l10n.md, Spacing.md),
        _buildSpacingExample(l10n.lg, Spacing.lg),
        _buildSpacingExample(l10n.xl, Spacing.xl),
        _buildSpacingExample(l10n.xxl, Spacing.xxl),
      ],
    );
  }

     Widget _buildSpacingExample(String label, double spacing) {
     return Padding(
       padding: EdgeInsets.symmetric(vertical: Spacing.xs),
       child: Row(
         children: [
           SizedBox(width: 200, child: Text(label)),
           Container(width: spacing, height: 20, color: Colors.blue),
         ],
       ),
     );
   }

  Widget _buildAnimationsSection(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        ElevatedButton(onPressed: () {}, child: Text(l10n.fadeIn)),
        const SizedBox(height: Spacing.sm),
        ElevatedButton(onPressed: () {}, child: Text(l10n.slideIn)),
        const SizedBox(height: Spacing.sm),
        ElevatedButton(onPressed: () {}, child: Text(l10n.scaleIn)),
        const SizedBox(height: Spacing.sm),
        ElevatedButton(onPressed: () {}, child: Text(l10n.bounce)),
        const SizedBox(height: Spacing.sm),
        ElevatedButton(onPressed: () {}, child: Text(l10n.stagger)),
      ],
    );
  }
}
