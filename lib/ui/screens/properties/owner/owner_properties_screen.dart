import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../demo/demo_data.dart';
import '../../../widgets/common/app_top_bar.dart';

import '../../../widgets/common/skeleton_list.dart';

/// Owner properties management screen with segmented tabs
class OwnerPropertiesScreen extends StatefulWidget {
  const OwnerPropertiesScreen({super.key});

  @override
  State<OwnerPropertiesScreen> createState() => _OwnerPropertiesScreenState();
}

class _OwnerPropertiesScreenState extends State<OwnerPropertiesScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _simulateLoading();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _simulateLoading() async {
    await Future.delayed(const Duration(milliseconds: 800));
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppTopBar(
        title: l10n.ownerPropertiesTitle,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.pushNamed('ownerPropertyEditorNew'),
            tooltip: l10n.addProperty,
          ),
        ],
      ),
      body: Column(
        children: [
          // Segmented tabs
          Container(
            margin: EdgeInsets.all(Spacing.md),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(BorderRadiusTokens.medium),
            ),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              indicator: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(BorderRadiusTokens.medium),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: theme.colorScheme.onPrimary,
              unselectedLabelColor: theme.colorScheme.onSurfaceVariant,
              labelStyle: theme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              tabs: [
                _buildTab(l10n.draft, Icons.edit_outlined),
                _buildTab(l10n.pending, Icons.pending_outlined),
                _buildTab(l10n.published, Icons.check_circle_outline),
                _buildTab(l10n.rejected, Icons.cancel_outlined),
              ],
            ),
          ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.3),

          // Tab content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildPropertyList(PropertyStatus.draft),
                _buildPropertyList(PropertyStatus.pending),
                _buildPropertyList(PropertyStatus.published),
                _buildPropertyList(PropertyStatus.rejected),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String label, IconData icon) {
    return Tab(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16),
          SizedBox(width: Spacing.xs),
          Text(label),
        ],
      ),
    );
  }

  Widget _buildPropertyList(PropertyStatus status) {
    final properties = _getPropertiesByStatus(status);

    if (_isLoading) {
      return const SkeletonList();
    }

    if (properties.isEmpty) {
      return _buildEmptyState(status);
    }

    return ListView.builder(
      padding: EdgeInsets.all(Spacing.md),
      itemCount: properties.length,
      itemBuilder: (context, index) {
        final property = properties[index];
        return Padding(
              padding: EdgeInsets.only(bottom: Spacing.md),
              child: _buildPropertyCard(property, status),
            )
            .animate()
            .fadeIn(delay: (index * 100).ms, duration: 400.ms)
            .slideX(begin: 0.3);
      },
    );
  }

  Widget _buildPropertyCard(DemoProperty property, PropertyStatus status) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Card(
      child: InkWell(
        onTap: () => _openPropertyDetails(property),
        borderRadius: BorderRadius.circular(BorderRadiusTokens.medium),
        child: Padding(
          padding: EdgeInsets.all(Spacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with status and actions
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          property.title,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: Spacing.xs),
                        Text(
                          property.location,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  _buildStatusChip(status),
                ],
              ),
              SizedBox(height: Spacing.md),

              // Property image
              Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(BorderRadiusTokens.small),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(BorderRadiusTokens.small),
                  child: Image.asset(
                    property.imageUrls.first,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.image,
                        size: 48,
                        color: theme.colorScheme.onSurfaceVariant,
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: Spacing.md),

              // Property details
              Row(
                children: [
                  Icon(
                    Icons.attach_money,
                    size: 16,
                    color: theme.colorScheme.primary,
                  ),
                  SizedBox(width: Spacing.xs),
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          '${property.pricePerNight}',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            ' / ${l10n.perNight}',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.people,
                    size: 16,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  SizedBox(width: Spacing.xs),
                  Flexible(
                    child: Text(
                      '${property.capacity} ${l10n.guests}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              SizedBox(height: Spacing.md),

              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _editProperty(property),
                      icon: const Icon(Icons.edit, size: 16),
                      label: Text(l10n.edit),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: Spacing.sm),
                      ),
                    ),
                  ),
                  SizedBox(width: Spacing.sm),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _manageMedia(property),
                      icon: const Icon(Icons.photo_library, size: 16),
                      label: Text(l10n.media),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: Spacing.sm),
                      ),
                    ),
                  ),
                  if (status == PropertyStatus.draft) ...[
                    SizedBox(width: Spacing.sm),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => _submitForApproval(property),
                        icon: const Icon(Icons.send, size: 16),
                        label: Text(l10n.submit),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: Spacing.sm),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(PropertyStatus status) {
    final l10n = AppLocalizations.of(context)!;

    Color backgroundColor;
    Color textColor;
    IconData icon;

    switch (status) {
      case PropertyStatus.draft:
        backgroundColor = AppColors.surface500;
        textColor = AppColors.surface700;
        icon = Icons.edit_outlined;
        break;
      case PropertyStatus.pending:
        backgroundColor = AppColors.warning100;
        textColor = AppColors.warning700;
        icon = Icons.pending_outlined;
        break;
      case PropertyStatus.published:
        backgroundColor = AppColors.success100;
        textColor = AppColors.success700;
        icon = Icons.check_circle_outlined;
        break;
      case PropertyStatus.rejected:
        backgroundColor = AppColors.error100;
        textColor = AppColors.error700;
        icon = Icons.cancel_outlined;
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Spacing.sm,
        vertical: Spacing.xs,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(BorderRadiusTokens.small),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: textColor),
          SizedBox(width: Spacing.xs),
          Text(
            status.getLocalizedText(l10n),
            style: TextStyle(
              color: textColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(PropertyStatus status) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    IconData icon;
    String message;

    switch (status) {
      case PropertyStatus.draft:
        icon = Icons.edit_outlined;
        message = l10n.noDraftProperties;
        break;
      case PropertyStatus.pending:
        icon = Icons.pending_outlined;
        message = l10n.noPendingProperties;
        break;
      case PropertyStatus.published:
        icon = Icons.check_circle_outlined;
        message = l10n.noPublishedProperties;
        break;
      case PropertyStatus.rejected:
        icon = Icons.cancel_outlined;
        message = l10n.noRejectedProperties;
        break;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: theme.colorScheme.onSurfaceVariant),
          SizedBox(height: Spacing.md),
          Text(
            message,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          if (status == PropertyStatus.draft) ...[
            SizedBox(height: Spacing.lg),
            ElevatedButton.icon(
              onPressed: () => context.pushNamed('ownerPropertyEditorNew'),
              icon: const Icon(Icons.add),
              label: Text(l10n.addFirstProperty),
            ),
          ],
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).scale(begin: const Offset(0.8, 0.8));
  }

  List<DemoProperty> _getPropertiesByStatus(PropertyStatus status) {
    // Filter demo properties by status
    return DemoData.properties.where((property) {
      // Simulate different statuses based on property ID
      final id = int.tryParse(property.id.replaceAll('prop_', '')) ?? 0;
      switch (status) {
        case PropertyStatus.draft:
          return id % 4 == 0;
        case PropertyStatus.pending:
          return id % 4 == 1;
        case PropertyStatus.published:
          return id % 4 == 2;
        case PropertyStatus.rejected:
          return id % 4 == 3;
      }
    }).toList();
  }

  void _openPropertyDetails(DemoProperty property) {
    context.pushNamed('propertyDetails', pathParameters: {'id': property.id});
  }

  void _editProperty(DemoProperty property) {
    context.pushNamed('ownerPropertyEditorEdit', pathParameters: {'id': property.id});
  }

  void _manageMedia(DemoProperty property) {
    context.pushNamed(
      'propertyMediaManager',
      pathParameters: {'id': property.id},
    );
  }

  void _submitForApproval(DemoProperty property) {
    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.submitForApproval),
        content: Text(l10n.submitForApprovalMessage),
        actions: [
          TextButton(onPressed: () => context.pop(), child: Text(l10n.cancel)),
          ElevatedButton(
            onPressed: () {
              context.pop();
              _showSubmissionSuccess();
            },
            child: Text(l10n.submit),
          ),
        ],
      ),
    );
  }

  void _showSubmissionSuccess() {
    final l10n = AppLocalizations.of(context)!;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.propertySubmittedSuccessfully),
        backgroundColor: AppColors.success500,
        behavior: SnackBarBehavior.floating,
      ),
    );

    // Optimistically move to pending tab
    _tabController.animateTo(1); // Pending tab
  }
}

/// Property status enum
enum PropertyStatus { draft, pending, published, rejected }

/// Extension for localized status text
extension PropertyStatusExtension on PropertyStatus {
  String getLocalizedText(AppLocalizations l10n) {
    switch (this) {
      case PropertyStatus.draft:
        return l10n.draft;
      case PropertyStatus.pending:
        return l10n.pending;
      case PropertyStatus.published:
        return l10n.published;
      case PropertyStatus.rejected:
        return l10n.rejected;
    }
  }
}
