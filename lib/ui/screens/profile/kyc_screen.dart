import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/theme/app_theme.dart';
import '../../widgets/common/app_snackbar.dart';
import '../../widgets/common/app_top_bar.dart';

/// KYC (Know Your Customer) verification screen with enhanced form fields
class KYCScreen extends StatefulWidget {
  const KYCScreen({super.key});

  @override
  State<KYCScreen> createState() => _KYCScreenState();
}

class _KYCScreenState extends State<KYCScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _idNumberController = TextEditingController();
  final _ibanController = TextEditingController();
  
  KYCStatus _kycStatus = KYCStatus.pending;
  bool _isSubmitting = false;
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _fullNameController.addListener(_validateForm);
    _idNumberController.addListener(_validateForm);
    _ibanController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _idNumberController.dispose();
    _ibanController.dispose();
    super.dispose();
  }

  void _validateForm() {
    final isValid = _fullNameController.text.isNotEmpty && 
                   _idNumberController.text.isNotEmpty &&
                   _ibanController.text.isNotEmpty;
    setState(() {
      _isFormValid = isValid;
    });
  }

  void _submitVerification() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isSubmitting = true);
      
      // Simulate verification process
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          setState(() {
            _isSubmitting = false;
            _kycStatus = KYCStatus.verified;
          });
          
          AppSnackBar.showSuccess(
            context,
            message: 'KYC verification submitted successfully!',
          );
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
      appBar: AppTopBar(
        title: l10n.identityVerification,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status indicator
            _buildStatusCard(theme)
                .animate()
                .fadeIn(duration: isReducedMotion ? 0.ms : 600.ms)
                .slideY(begin: isReducedMotion ? 0.0 : 0.3, duration: isReducedMotion ? 0.ms : 600.ms),
            
            SizedBox(height: Spacing.lg),
            
            // Form
            FocusTraversalGroup(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Personal Information',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                        .animate()
                        .fadeIn(delay: isReducedMotion ? 0.ms : 200.ms, duration: isReducedMotion ? 0.ms : 600.ms)
                        .slideY(begin: isReducedMotion ? 0.0 : 0.3, duration: isReducedMotion ? 0.ms : 600.ms),
                    
                    SizedBox(height: Spacing.md),
                    
                    Text(
                      'Please provide accurate information for identity verification.',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    )
                        .animate()
                        .fadeIn(delay: isReducedMotion ? 0.ms : 300.ms, duration: isReducedMotion ? 0.ms : 600.ms)
                        .slideY(begin: isReducedMotion ? 0.0 : 0.3, duration: isReducedMotion ? 0.ms : 600.ms),
                    
                    SizedBox(height: Spacing.xl),
                    
                    // Full Name field
                    TextFormField(
                      controller: _fullNameController,
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        hintText: 'Enter your full legal name',
                        prefixIcon: const Icon(Icons.person_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(BorderRadiusTokens.medium),
                        ),
                        filled: true,
                        fillColor: theme.colorScheme.surfaceContainerHighest,
                      ),
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      autofillHints: const [AutofillHints.name],
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Full name is required';
                        }
                        if (value!.length < 2) {
                          return 'Name must be at least 2 characters';
                        }
                        return null;
                      },
                    )
                        .animate()
                        .fadeIn(delay: isReducedMotion ? 0.ms : 400.ms, duration: isReducedMotion ? 0.ms : 600.ms)
                        .slideY(begin: isReducedMotion ? 0.0 : 0.3, duration: isReducedMotion ? 0.ms : 600.ms),
                    
                    SizedBox(height: Spacing.md),
                    
                    // ID Number field
                    TextFormField(
                      controller: _idNumberController,
                      decoration: InputDecoration(
                        labelText: 'ID Number',
                        hintText: 'Enter your national ID or passport number',
                        prefixIcon: const Icon(Icons.badge_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(BorderRadiusTokens.medium),
                        ),
                        filled: true,
                        fillColor: theme.colorScheme.surfaceContainerHighest,
                      ),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      textDirection: TextDirection.ltr, // Force LTR for ID numbers
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'ID number is required';
                        }
                        if (value!.length < 5) {
                          return 'ID number must be at least 5 characters';
                        }
                        return null;
                      },
                    )
                        .animate()
                        .fadeIn(delay: isReducedMotion ? 0.ms : 600.ms, duration: isReducedMotion ? 0.ms : 600.ms)
                        .slideY(begin: isReducedMotion ? 0.0 : 0.3, duration: isReducedMotion ? 0.ms : 600.ms),
                    
                    SizedBox(height: Spacing.md),
                    
                    // IBAN field
                    TextFormField(
                      controller: _ibanController,
                      decoration: InputDecoration(
                        labelText: 'IBAN',
                        hintText: 'Enter your bank account IBAN',
                        prefixIcon: const Icon(Icons.account_balance_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(BorderRadiusTokens.medium),
                        ),
                        filled: true,
                        fillColor: theme.colorScheme.surfaceContainerHighest,
                      ),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      textDirection: TextDirection.ltr, // Force LTR for IBAN
                      autofillHints: const [AutofillHints.creditCardNumber], // Closest autofill hint
                      onFieldSubmitted: (_) => _submitVerification(),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'IBAN is required';
                        }
                        if (value!.length < 10) {
                          return 'IBAN must be at least 10 characters';
                        }
                        // Basic IBAN format validation
                        if (!RegExp(r'^[A-Z]{2}[0-9]{2}[A-Z0-9]{4}[0-9]{7}([A-Z0-9]?){0,16}$').hasMatch(value.toUpperCase())) {
                          return 'Please enter a valid IBAN format';
                        }
                        return null;
                      },
                    )
                        .animate()
                        .fadeIn(delay: isReducedMotion ? 0.ms : 800.ms, duration: isReducedMotion ? 0.ms : 600.ms)
                        .slideY(begin: isReducedMotion ? 0.0 : 0.3, duration: isReducedMotion ? 0.ms : 600.ms),
                    
                    SizedBox(height: Spacing.xl),
                    
                    // Submit button
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: _isFormValid && !_isSubmitting ? _submitVerification : null,
                        style: FilledButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: Spacing.md),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(BorderRadiusTokens.medium),
                          ),
                        ),
                        child: _isSubmitting
                            ? Semantics(
                                label: 'Submitting verification, please wait',
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
                                'Submit Verification',
                                style: theme.textTheme.titleMedium,
                              ),
                      ),
                    )
                        .animate()
                        .fadeIn(delay: isReducedMotion ? 0.ms : 1000.ms, duration: isReducedMotion ? 0.ms : 600.ms)
                        .slideY(begin: isReducedMotion ? 0.0 : 0.3, duration: isReducedMotion ? 0.ms : 600.ms),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(ThemeData theme) {
    Color statusColor;
    IconData statusIcon;
    String statusText;
    String statusDescription;

    switch (_kycStatus) {
      case KYCStatus.pending:
        statusColor = AppColors.warning500;
        statusIcon = Icons.pending_outlined;
        statusText = 'Pending Verification';
        statusDescription = 'Your verification is pending review';
        break;
      case KYCStatus.verified:
        statusColor = AppColors.success500;
        statusIcon = Icons.verified_outlined;
        statusText = 'Verified';
        statusDescription = 'Your identity has been verified';
        break;
      case KYCStatus.rejected:
        statusColor = AppColors.error500;
        statusIcon = Icons.error_outline;
        statusText = 'Rejected';
        statusDescription = 'Your verification was rejected';
        break;
    }

    return Card(
      child: Padding(
        padding: EdgeInsets.all(Spacing.md),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(Spacing.sm),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(BorderRadiusTokens.medium),
              ),
              child: Icon(
                statusIcon,
                color: statusColor,
                size: 24,
              ),
            ),
            SizedBox(width: Spacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    statusText,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                    ),
                  ),
                  Text(
                    statusDescription,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 600.ms)
        .slideY(begin: 0.3, duration: 600.ms);
  }
}

enum KYCStatus {
  pending,
  verified,
  rejected,
}
