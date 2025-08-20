import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/theme/app_theme.dart';
import '../../../app/navigation/app_router.dart';

/// Registration screen for new users with enhanced accessibility
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_validateForm);
    _emailController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
    _confirmPasswordController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _validateForm() {
    final isValid =
        _nameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _emailController.text.contains('@') &&
        _passwordController.text.length >= 6 &&
        _confirmPasswordController.text == _passwordController.text;
    setState(() {
      _isFormValid = isValid;
    });
  }

  void _handleRegister() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // Simulate registration process
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

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isReducedMotion = MediaQuery.of(context).accessibleNavigation;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.signUp), elevation: 0),
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
                        l10n.signUp,
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
                        l10n.createAccountMessage,
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

                  // Name field
                  TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: l10n.fullName,
                          hintText: 'Enter your full name',
                          prefixIcon: const Icon(Icons.person_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              BorderRadiusTokens.medium,
                            ),
                          ),
                          filled: true,
                          fillColor: theme.colorScheme.surfaceContainerHighest,
                        ),
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        autofillHints: const [AutofillHints.name],
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return l10n.fullNameRequired;
                          }
                          if (value!.length < 2) {
                            return l10n.nameTooShort;
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
                        delay: isReducedMotion ? 0.ms : 600.ms,
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
                          hintText: 'Create a password',
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
                        textInputAction: TextInputAction.next,
                        autofillHints: const [AutofillHints.newPassword],
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return l10n.passwordRequired;
                          }
                          if (value!.length < 6) {
                            return l10n.passwordTooShort;
                          }
                          return null;
                        },
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

                  SizedBox(height: Spacing.md),

                  // Confirm password field
                  TextFormField(
                        controller: _confirmPasswordController,
                        decoration: InputDecoration(
                          labelText: l10n.confirmPassword,
                          hintText: 'Confirm your password',
                          prefixIcon: const Icon(Icons.lock_outlined),
                          suffixIcon: Semantics(
                            label: _isConfirmPasswordVisible
                                ? 'Hide password'
                                : 'Show password',
                            button: true,
                            child: IconButton(
                              icon: Icon(
                                _isConfirmPasswordVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: _toggleConfirmPasswordVisibility,
                              tooltip: _isConfirmPasswordVisible
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
                        obscureText: !_isConfirmPasswordVisible,
                        textInputAction: TextInputAction.done,
                        autofillHints: const [AutofillHints.newPassword],
                        onFieldSubmitted: (_) => _handleRegister(),
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please confirm your password';
                          }
                          if (value != _passwordController.text) {
                            return l10n.passwordsDontMatch;
                          }
                          return null;
                        },
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

                  SizedBox(height: Spacing.xl),

                  // Register button
                  SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: _isFormValid && !_isLoading
                              ? _handleRegister
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
                                  l10n.signUp,
                                  style: theme.textTheme.titleMedium,
                                ),
                        ),
                      )
                      .animate()
                      .fadeIn(
                        delay: isReducedMotion ? 0.ms : 1200.ms,
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
                    delay: isReducedMotion ? 0.ms : 1400.ms,
                    duration: isReducedMotion ? 0.ms : 600.ms,
                  ),

                  SizedBox(height: Spacing.lg),

                  // Sign in link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        l10n.alreadyHaveAccount,
                        style: theme.textTheme.bodyMedium,
                      ),
                      TextButton(
                        onPressed: () => context.go(AppRouter.authLogin),
                        child: Text(l10n.signIn),
                      ),
                    ],
                  ).animate().fadeIn(
                    delay: isReducedMotion ? 0.ms : 1600.ms,
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
