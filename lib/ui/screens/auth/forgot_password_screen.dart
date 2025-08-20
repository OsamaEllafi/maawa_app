import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/theme/app_theme.dart';
import '../../../app/navigation/app_router.dart';

/// Forgot password screen with enhanced success feedback
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;
  bool _emailSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // Simulate email sending process
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _isLoading = false;
            _emailSent = true;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isReducedMotion = MediaQuery.of(context).accessibleNavigation;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.forgotPassword), elevation: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(Spacing.lg),
          child: _emailSent
              ? _buildSuccessView(l10n, theme, isReducedMotion)
              : _buildFormView(l10n, theme, isReducedMotion),
        ),
      ),
    );
  }

  Widget _buildFormView(
    AppLocalizations l10n,
    ThemeData theme,
    bool isReducedMotion,
  ) {
    return FocusTraversalGroup(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section
            Text(
                  l10n.forgotPassword,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                )
                .animate()
                .fadeIn(duration: isReducedMotion ? 0.ms : 600.ms)
                .slideY(
                  begin: isReducedMotion ? 0.0 : 0.3,
                  duration: isReducedMotion ? 0.ms : 600.ms,
                ),

            SizedBox(height: Spacing.sm),

            Text(
                  l10n.forgotPasswordMessage,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                )
                .animate()
                .fadeIn(
                  delay: isReducedMotion ? 0.ms : 200.ms,
                  duration: isReducedMotion ? 0.ms : 600.ms,
                )
                .slideY(
                  begin: isReducedMotion ? 0.0 : 0.3,
                  duration: isReducedMotion ? 0.ms : 600.ms,
                ),

            SizedBox(height: Spacing.xl),

            // Email field
            TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: l10n.email,
                    hintText: 'Enter your email address',
                    prefixIcon: const Icon(Icons.email_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        BorderRadiusTokens.medium,
                      ),
                    ),
                    filled: true,
                    fillColor: theme.colorScheme.surfaceContainerHighest,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  autofillHints: const [AutofillHints.email],
                  onFieldSubmitted: (_) => _handleSubmit(),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return l10n.emailRequired;
                    }
                    if (!RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    ).hasMatch(value!)) {
                      return l10n.invalidEmail;
                    }
                    return null;
                  },
                )
                .animate()
                .fadeIn(
                  delay: isReducedMotion ? 0.ms : 400.ms,
                  duration: isReducedMotion ? 0.ms : 600.ms,
                )
                .slideY(
                  begin: isReducedMotion ? 0.0 : 0.3,
                  duration: isReducedMotion ? 0.ms : 600.ms,
                ),

            SizedBox(height: Spacing.xl),

            // Submit button
            SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _isLoading ? null : _handleSubmit,
                    style: FilledButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: Spacing.md),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          BorderRadiusTokens.medium,
                        ),
                      ),
                    ),
                    child: _isLoading
                        ? Semantics(
                            label: 'Sending reset link, please wait',
                            child: SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  theme.colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          )
                        : Text(
                            l10n.sendResetLink,
                            style: theme.textTheme.titleMedium,
                          ),
                  ),
                )
                .animate()
                .fadeIn(
                  delay: isReducedMotion ? 0.ms : 600.ms,
                  duration: isReducedMotion ? 0.ms : 600.ms,
                )
                .slideY(
                  begin: isReducedMotion ? 0.0 : 0.3,
                  duration: isReducedMotion ? 0.ms : 600.ms,
                ),

            SizedBox(height: Spacing.lg),

            // Back to login link
            Center(
              child: TextButton(
                onPressed: () => context.go(AppRouter.authLogin),
                child: Text(l10n.backToSignIn),
              ),
            ).animate().fadeIn(
              delay: isReducedMotion ? 0.ms : 800.ms,
              duration: isReducedMotion ? 0.ms : 600.ms,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessView(
    AppLocalizations l10n,
    ThemeData theme,
    bool isReducedMotion,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Success icon with animation
        Semantics(
          label: 'Email sent successfully',
          child:
              Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: AppColors.success100,
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: Icon(
                      Icons.mark_email_read_outlined,
                      size: 60,
                      color: AppColors.success600,
                    ),
                  )
                  .animate()
                  .fadeIn(duration: isReducedMotion ? 0.ms : 600.ms)
                  .scale(
                    begin: isReducedMotion
                        ? const Offset(1.0, 1.0)
                        : const Offset(0.5, 0.5),
                    duration: isReducedMotion ? 0.ms : 800.ms,
                  )
                  .then()
                  .shimmer(
                    duration: isReducedMotion ? 0.ms : 1200.ms,
                    delay: isReducedMotion ? 0.ms : 500.ms,
                  ),
        ),

        SizedBox(height: Spacing.xl),

        // Success title
        Text(
              l10n.checkYourEmail,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            )
            .animate()
            .fadeIn(
              delay: isReducedMotion ? 0.ms : 400.ms,
              duration: isReducedMotion ? 0.ms : 600.ms,
            )
            .slideY(
              begin: isReducedMotion ? 0.0 : 0.3,
              duration: isReducedMotion ? 0.ms : 600.ms,
            ),

        SizedBox(height: Spacing.md),

        // Success message
        Text(
              l10n.emailSentMessage,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            )
            .animate()
            .fadeIn(
              delay: isReducedMotion ? 0.ms : 600.ms,
              duration: isReducedMotion ? 0.ms : 600.ms,
            )
            .slideY(
              begin: isReducedMotion ? 0.0 : 0.3,
              duration: isReducedMotion ? 0.ms : 600.ms,
            ),

        SizedBox(height: Spacing.sm),

        // Email address
        Container(
              padding: EdgeInsets.symmetric(
                horizontal: Spacing.md,
                vertical: Spacing.sm,
              ),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(BorderRadiusTokens.medium),
              ),
              child: Text(
                _emailController.text,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.primary,
                ),
              ),
            )
            .animate()
            .fadeIn(
              delay: isReducedMotion ? 0.ms : 800.ms,
              duration: isReducedMotion ? 0.ms : 600.ms,
            )
            .slideY(
              begin: isReducedMotion ? 0.0 : 0.3,
              duration: isReducedMotion ? 0.ms : 600.ms,
            ),

        SizedBox(height: Spacing.xl),

        // Action buttons
        SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => context.go(AppRouter.authLogin),
                style: FilledButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: Spacing.md),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      BorderRadiusTokens.medium,
                    ),
                  ),
                ),
                child: Text(
                  l10n.backToSignIn,
                  style: theme.textTheme.titleMedium,
                ),
              ),
            )
            .animate()
            .fadeIn(
              delay: isReducedMotion ? 0.ms : 1000.ms,
              duration: isReducedMotion ? 0.ms : 600.ms,
            )
            .slideY(
              begin: isReducedMotion ? 0.0 : 0.3,
              duration: isReducedMotion ? 0.ms : 600.ms,
            ),

        SizedBox(height: Spacing.sm),

        // Try different email button
        TextButton(
          onPressed: () {
            setState(() {
              _emailSent = false;
              _emailController.clear();
            });
          },
          child: Text(l10n.tryDifferentEmail),
        ).animate().fadeIn(
          delay: isReducedMotion ? 0.ms : 1200.ms,
          duration: isReducedMotion ? 0.ms : 600.ms,
        ),
      ],
    );
  }
}
