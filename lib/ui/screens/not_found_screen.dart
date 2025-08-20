import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_theme.dart';
import '../../l10n/app_localizations.dart';
import '../../app/navigation/app_router.dart';
import '../widgets/common/app_top_bar.dart';

class NotFoundScreen extends StatelessWidget {
  final String? routeType;
  final String? invalidId;
  
  const NotFoundScreen({
    super.key,
    this.routeType,
    this.invalidId,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isReducedMotion = MediaQuery.of(context).accessibleNavigation;
    
    // Determine if this is an invalid ID case
    final isInvalidId = routeType != null && invalidId != null;
    
    return Scaffold(
      appBar: AppTopBar(
        title: isInvalidId ? l10n.invalidIdTitle : l10n.notFoundTitle,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(Spacing.lg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon with animation
              Semantics(
                label: isInvalidId ? 'Invalid ID error' : 'Page not found',
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.errorContainer,
                    borderRadius: BorderRadius.circular(60),
                  ),
                  child: Icon(
                    isInvalidId ? Icons.error_outline : Icons.search_off_rounded,
                    size: 60,
                    color: theme.colorScheme.onErrorContainer,
                  ),
                ),
              )
                  .animate()
                  .fadeIn(duration: isReducedMotion ? 0.ms : 600.ms)
                  .scale(
                    begin: isReducedMotion ? const Offset(1.0, 1.0) : const Offset(0.8, 0.8),
                    duration: isReducedMotion ? 0.ms : 800.ms,
                  ),
              
              SizedBox(height: Spacing.lg),
              
              // Title
              Text(
                isInvalidId ? l10n.invalidIdTitle : l10n.notFoundMessage,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              )
                  .animate()
                  .fadeIn(delay: isReducedMotion ? 0.ms : 200.ms, duration: isReducedMotion ? 0.ms : 600.ms)
                  .slideY(begin: isReducedMotion ? 0.0 : 0.3, duration: isReducedMotion ? 0.ms : 600.ms),
              
              SizedBox(height: Spacing.md),
              
              // Subtitle with specific context
              Text(
                _getSubtitle(l10n, isInvalidId, routeType, invalidId),
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              )
                  .animate()
                  .fadeIn(delay: isReducedMotion ? 0.ms : 400.ms, duration: isReducedMotion ? 0.ms : 600.ms)
                  .slideY(begin: isReducedMotion ? 0.0 : 0.3, duration: isReducedMotion ? 0.ms : 600.ms),
              
              SizedBox(height: Spacing.xl),
              
              // Action buttons
              Column(
                children: [
                  // Primary action
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () => context.go('/'),
                      icon: const Icon(Icons.home_rounded),
                      label: Text(l10n.goHome),
                      style: FilledButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: Spacing.md),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(BorderRadiusTokens.medium),
                        ),
                      ),
                    ),
                  )
                      .animate()
                      .fadeIn(delay: isReducedMotion ? 0.ms : 600.ms, duration: isReducedMotion ? 0.ms : 600.ms)
                      .slideY(begin: isReducedMotion ? 0.0 : 0.3, duration: isReducedMotion ? 0.ms : 600.ms),
                  
                  SizedBox(height: Spacing.sm),
                  
                  // Secondary action
                  TextButton.icon(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.arrow_back_rounded),
                    label: Text(l10n.goBack),
                  )
                      .animate()
                      .fadeIn(delay: isReducedMotion ? 0.ms : 800.ms, duration: isReducedMotion ? 0.ms : 600.ms)
                      .slideY(begin: isReducedMotion ? 0.0 : 0.3, duration: isReducedMotion ? 0.ms : 600.ms),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  String _getSubtitle(AppLocalizations l10n, bool isInvalidId, String? routeType, String? invalidId) {
    if (!isInvalidId) {
      return l10n.notFoundSubtitle;
    }
    
    // Provide specific context for invalid IDs
    switch (routeType) {
      case 'property':
        return l10n.invalidPropertyIdMessage(invalidId!);
      case 'booking':
        return l10n.invalidBookingIdMessage(invalidId!);
      default:
        return l10n.invalidIdMessage(invalidId!);
    }
  }
}
