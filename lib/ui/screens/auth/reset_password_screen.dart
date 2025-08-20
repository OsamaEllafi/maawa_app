import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/theme/app_theme.dart';
import '../../../app/navigation/app_router.dart';

/// Reset password screen (accessed via email link)
class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // Simulate password reset process
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() => _isLoading = false);

          // Show success message and navigate to login
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Password reset successfully!'),
              backgroundColor: AppColors.success500,
            ),
          );

          Future.delayed(const Duration(seconds: 1), () {
            if (mounted) {
              context.go(AppRouter.authLogin);
            }
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.resetPassword)),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(Spacing.lg),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.resetPassword, style: theme.textTheme.headlineMedium),
                SizedBox(height: Spacing.md),
                Text(
                  'Please enter your new password.',
                  style: theme.textTheme.bodyLarge,
                ),
                SizedBox(height: Spacing.xl),

                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'New ${l10n.password}',
                    prefixIcon: const Icon(Icons.lock_outlined),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  obscureText: !_isPasswordVisible,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return l10n.passwordRequired;
                    }
                    if (value!.length < 8) {
                      return l10n.passwordTooShort;
                    }
                    return null;
                  },
                ),
                SizedBox(height: Spacing.md),

                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: l10n.confirmPassword,
                    prefixIcon: const Icon(Icons.lock_outlined),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isConfirmPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _isConfirmPasswordVisible =
                              !_isConfirmPasswordVisible;
                        });
                      },
                    ),
                  ),
                  obscureText: !_isConfirmPasswordVisible,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please confirm your password';
                    }
                    if (value != _passwordController.text) {
                      return l10n.passwordsDontMatch;
                    }
                    return null;
                  },
                ),
                SizedBox(height: Spacing.lg),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleSubmit,
                    child: _isLoading
                        ? const CircularProgressIndicator()
                        : Text(l10n.resetPassword),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
