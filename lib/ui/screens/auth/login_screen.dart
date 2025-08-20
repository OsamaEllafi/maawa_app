import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/theme/app_theme.dart';
import '../../../app/navigation/app_router.dart';

/// Login screen for existing users with enhanced accessibility
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateForm() {
    final isValid =
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _emailController.text.contains('@');
    setState(() {
      _isFormValid = isValid;
    });
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // Simulate login process
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() => _isLoading = false);
          context.go(AppRouter.tenantHome);
        }
      });
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isReducedMotion = MediaQuery.of(context).accessibleNavigation;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.signIn), elevation: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(Spacing.lg),
          child: FocusTraversalGroup(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header section
                  Text(
                        l10n.signIn,
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
                        l10n.welcomeBack,
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
                        textInputAction: TextInputAction.next,
                        autofillHints: const [AutofillHints.email],
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

                  SizedBox(height: Spacing.md),

                  // Password field
                  TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: l10n.password,
                          hintText: 'Enter your password',
                          prefixIcon: const Icon(Icons.lock_outlined),
                          suffixIcon: Semantics(
                            label: _isPasswordVisible
                                ? 'Hide password'
                                : 'Show password',
                            button: true,
                            child: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: _togglePasswordVisibility,
                              tooltip: _isPasswordVisible
                                  ? 'Hide password'
                                  : 'Show password',
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              BorderRadiusTokens.medium,
                            ),
                          ),
                          filled: true,
                          fillColor: theme.colorScheme.surfaceContainerHighest,
                        ),
                        obscureText: !_isPasswordVisible,
                        textInputAction: TextInputAction.done,
                        autofillHints: const [AutofillHints.password],
                        onFieldSubmitted: (_) => _handleLogin(),
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return l10n.passwordRequired;
                          }
                          if (value!.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
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

                  // Forgot password link
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: TextButton(
                      onPressed: () => context.go(AppRouter.authForgotPassword),
                      child: Text(l10n.forgotPassword),
                    ),
                  ).animate().fadeIn(
                    delay: isReducedMotion ? 0.ms : 800.ms,
                    duration: isReducedMotion ? 0.ms : 600.ms,
                  ),

                  SizedBox(height: Spacing.xl),

                  // Login button
                  SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: _isFormValid && !_isLoading
                              ? _handleLogin
                              : null,
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
                                  label: 'Loading, please wait',
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
                                  l10n.signIn,
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

                  SizedBox(height: Spacing.lg),

                  // Divider
                  Row(
                    children: [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Spacing.md),
                        child: Text(
                          'OR',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ).animate().fadeIn(
                    delay: isReducedMotion ? 0.ms : 1200.ms,
                    duration: isReducedMotion ? 0.ms : 600.ms,
                  ),

                  SizedBox(height: Spacing.lg),

                  // Sign up link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        l10n.dontHaveAccount,
                        style: theme.textTheme.bodyMedium,
                      ),
                      TextButton(
                        onPressed: () => context.go(AppRouter.authRegister),
                        child: Text(l10n.signUp),
                      ),
                    ],
                  ).animate().fadeIn(
                    delay: isReducedMotion ? 0.ms : 1400.ms,
                    duration: isReducedMotion ? 0.ms : 600.ms,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
