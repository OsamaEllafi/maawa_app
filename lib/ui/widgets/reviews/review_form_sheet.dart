import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../../demo/demo_data.dart';

/// A bottom sheet for creating a new review with star rating and comment
class ReviewFormSheet extends StatefulWidget {
  const ReviewFormSheet({
    super.key,
    this.propertyId,
    this.propertyName,
    this.onSubmit,
  });

  final String? propertyId;
  final String? propertyName;
  final Function(double rating, String comment)? onSubmit;

  @override
  State<ReviewFormSheet> createState() => _ReviewFormSheetState();

  /// Show the review form sheet
  static Future<DemoReview?> show(
    BuildContext context, {
    String? propertyId,
    String? propertyName,
    Function(double rating, String comment)? onSubmit,
  }) {
    return showModalBottomSheet<DemoReview?>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ReviewFormSheet(
        propertyId: propertyId,
        propertyName: propertyName,
        onSubmit: onSubmit,
      ),
    );
  }
}

class _ReviewFormSheetState extends State<ReviewFormSheet> {
  final _commentController = TextEditingController();
  final _commentFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  double _rating = 5.0;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _commentController.dispose();
    _commentFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(BorderRadiusTokens.large),
        ),
      ),
      child: SafeArea(
        bottom: false, // Let the keyboard push up naturally
        child: Padding(
          padding: EdgeInsets.only(
            left: Spacing.md,
            right: Spacing.md,
            top: Spacing.md,
            bottom: Spacing.md + mediaQuery.viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Handle bar
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.onSurfaceVariant.withValues(
                          alpha: 0.4,
                        ),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  SizedBox(height: Spacing.md),

                  // Title
                  Text(
                    widget.propertyName != null
                        ? l10n.reviewPropertyTitle(widget.propertyName!)
                        : l10n.writeReview,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: Spacing.lg),

                  // Rating section
                  _buildRatingSection(context, l10n, theme, isRtl),
                  SizedBox(height: Spacing.lg),

                  // Comment section
                  _buildCommentSection(context, l10n, theme),
                  SizedBox(height: Spacing.lg),

                  // Action buttons
                  _buildActionButtons(context, l10n, theme),

                  // Extra padding at bottom for keyboard
                  SizedBox(height: Spacing.md),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRatingSection(
    BuildContext context,
    AppLocalizations l10n,
    ThemeData theme,
    bool isRtl,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.rating,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: Spacing.sm),

        // Star rating slider
        Container(
          padding: EdgeInsets.all(Spacing.md),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(BorderRadiusTokens.medium),
            border: Border.all(
              color: theme.colorScheme.outline.withValues(alpha: 0.2),
            ),
          ),
          child: Column(
            children: [
              // Star display
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                textDirection: TextDirection.ltr, // Stars always LTR
                children: List.generate(5, (index) {
                  final starValue = index + 1;
                  return GestureDetector(
                    onTap: () => setState(() => _rating = starValue.toDouble()),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        starValue <= _rating ? Icons.star : Icons.star_outline,
                        color: starValue <= _rating
                            ? AppColors.warning500
                            : theme.colorScheme.onSurfaceVariant,
                        size: 32,
                        semanticLabel: '$starValue ${l10n.starsLabel}',
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(height: Spacing.md),

              // Rating slider
              Semantics(
                label: l10n.ratingSlider,
                value: '${_rating.toStringAsFixed(1)} ${l10n.outOfFive}',
                child: Slider(
                  value: _rating,
                  min: 1.0,
                  max: 5.0,
                  divisions: 8, // 0.5 increments
                  onChanged: (value) => setState(() => _rating = value),
                  activeColor: AppColors.warning500,
                ),
              ),

              // Rating value display
              Text(
                '${_rating.toStringAsFixed(1)} ${l10n.outOfFive}',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.warning500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCommentSection(
    BuildContext context,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.comment,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: Spacing.sm),

        TextFormField(
          controller: _commentController,
          focusNode: _commentFocusNode,
          maxLines: 4,
          minLines: 3,
          maxLength: 500,
          textInputAction: TextInputAction.newline,
          keyboardType: TextInputType.multiline,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            hintText: l10n.shareYourExperience,
            alignLabelWithHint: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(BorderRadiusTokens.medium),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(BorderRadiusTokens.medium),
              borderSide: BorderSide(
                color: theme.colorScheme.primary,
                width: 2,
              ),
            ),
            contentPadding: EdgeInsets.all(Spacing.md),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return l10n.commentRequired;
            }
            if (value.trim().length < 10) {
              return l10n.commentTooShort;
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildActionButtons(
    BuildContext context,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
    return Row(
      children: [
        // Cancel button
        Expanded(
          child: OutlinedButton(
            onPressed: _isSubmitting ? null : () => Navigator.of(context).pop(),
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: Spacing.md),
            ),
            child: Text(l10n.cancel),
          ),
        ),
        SizedBox(width: Spacing.md),

        // Submit button
        Expanded(
          child: FilledButton(
            onPressed: _isSubmitting ? null : _submitReview,
            style: FilledButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: Spacing.md),
            ),
            child: _isSubmitting
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: theme.colorScheme.onPrimary,
                    ),
                  )
                : Text(l10n.submitReview),
          ),
        ),
      ],
    );
  }

  Future<void> _submitReview() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 800));

    if (!mounted) return;

    setState(() => _isSubmitting = false);

    // Call the provided callback
    widget.onSubmit?.call(_rating, _commentController.text.trim());

    DemoReview? createdReview;

    // Add review to demo data if propertyId is provided
    if (widget.propertyId != null) {
      try {
        createdReview = DemoData.addReview(
          propertyId: widget.propertyId!,
          rating: _rating,
          commentEn: _commentController.text.trim(),
          commentAr: _commentController.text.trim(), // demo: mirror text
        );
      } catch (e) {
        debugPrint('Failed to add review: $e');
      }
    }

    // Close the sheet and return the created review
    Navigator.of(context).pop(createdReview);

    // Show success toast
    final l10n = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: AppColors.success500),
            SizedBox(width: Spacing.sm),
            Expanded(child: Text(l10n.reviewSubmitted)),
          ],
        ),
        duration: const Duration(seconds: 3),
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
      ),
    );
  }
}
