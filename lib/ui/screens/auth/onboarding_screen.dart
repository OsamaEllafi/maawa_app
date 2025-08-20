import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/theme/app_theme.dart';
import '../../../app/navigation/app_router.dart';

/// Onboarding screen with multiple slides for new users
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingSlide> _slides = [
    OnboardingSlide(
      icon: Icons.search_rounded,
      title: 'Find Your Perfect Stay',
      description: 'Discover amazing properties that match your preferences and budget.',
      color: Colors.blue,
    ),
    OnboardingSlide(
      icon: Icons.calendar_today_rounded,
      title: 'Easy Booking Process',
      description: 'Book your stay with just a few taps. No hidden fees, transparent pricing.',
      color: Colors.green,
    ),
    OnboardingSlide(
      icon: Icons.star_rounded,
      title: 'Verified Properties',
      description: 'All properties are verified and reviewed by our community of travelers.',
      color: Colors.orange,
    ),
    OnboardingSlide(
      icon: Icons.support_agent_rounded,
      title: '24/7 Support',
      description: 'Get help anytime with our dedicated customer support team.',
      color: Colors.purple,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _finishOnboarding();
    }
  }

  void _skipOnboarding() {
    _finishOnboarding();
  }

  void _finishOnboarding() {
    context.go(AppRouter.authRegister);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isReducedMotion = MediaQuery.of(context).accessibleNavigation;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: TextButton(
                onPressed: _skipOnboarding,
                child: Text(l10n.skip),
              ),
            ),

            // Page content
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _slides.length,
                itemBuilder: (context, index) {
                  final slide = _slides[index];
                  return _buildSlide(context, slide, index, isReducedMotion);
                },
              ),
            ),

            // Page indicator
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Spacing.lg),
              child: Row(
                children: [
                  // Page dots
                  ...List.generate(_slides.length, (index) {
                    return Container(
                      margin: EdgeInsetsDirectional.only(end: Spacing.xs),
                      width: _currentPage == index ? 24 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? theme.colorScheme.primary
                            : theme.colorScheme.outline,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ).animate().scale(
                      duration: isReducedMotion ? 0.ms : 200.ms,
                      curve: Curves.easeInOut,
                    );
                  }),

                  const Spacer(),

                  // Next/Get Started button
                  FilledButton(
                    onPressed: _nextPage,
                    child: Text(
                      _currentPage == _slides.length - 1 ? l10n.getStarted : l10n.next,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: Spacing.lg),
          ],
        ),
      ),
    );
  }

  Widget _buildSlide(BuildContext context, OnboardingSlide slide, int index, bool isReducedMotion) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.all(Spacing.lg),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon with animation
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: slide.color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(60),
            ),
            child: Icon(
              slide.icon,
              size: 60,
              color: slide.color,
            ),
          )
              .animate()
              .fadeIn(delay: isReducedMotion ? 0.ms : (index * 200).ms, duration: isReducedMotion ? 0.ms : 600.ms)
              .scale(begin: isReducedMotion ? const Offset(1.0, 1.0) : const Offset(0.8, 0.8), duration: isReducedMotion ? 0.ms : 600.ms),

          SizedBox(height: Spacing.xl),

          // Title with animation
          Text(
            slide.title,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          )
              .animate()
              .fadeIn(delay: isReducedMotion ? 0.ms : (index * 200 + 300).ms, duration: isReducedMotion ? 0.ms : 600.ms)
              .slideY(begin: isReducedMotion ? 0.0 : 0.3, duration: isReducedMotion ? 0.ms : 600.ms),

          SizedBox(height: Spacing.md),

          // Description with animation
          Text(
            slide.description,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          )
              .animate()
              .fadeIn(delay: isReducedMotion ? 0.ms : (index * 200 + 500).ms, duration: isReducedMotion ? 0.ms : 600.ms)
              .slideY(begin: isReducedMotion ? 0.0 : 0.3, duration: isReducedMotion ? 0.ms : 600.ms),
        ],
      ),
    );
  }
}

class OnboardingSlide {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  OnboardingSlide({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });
}
