import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../demo/demo_data.dart';
import '../../widgets/common/app_top_bar.dart';
import '../../widgets/common/skeleton_list.dart';

/// Admin property approvals screen
class AdminPropertyApprovalsScreen extends StatefulWidget {
  const AdminPropertyApprovalsScreen({super.key});

  @override
  State<AdminPropertyApprovalsScreen> createState() => _AdminPropertyApprovalsScreenState();
}

class _AdminPropertyApprovalsScreenState extends State<AdminPropertyApprovalsScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppTopBar(title: 'Property Approvals'),
      body: _isLoading
          ? const SkeletonList()
          : _buildContent(context, theme),
    );
  }

  Widget _buildContent(BuildContext context, ThemeData theme) {
    final pendingApprovals = DemoData.propertyApprovals
        .where((p) => p.status == DemoPropertyApprovalStatus.pending)
        .toList();

    final otherApprovals = DemoData.propertyApprovals
        .where((p) => p.status != DemoPropertyApprovalStatus.pending)
        .toList();

    return CustomScrollView(
      slivers: [
        // Pending approvals section
        if (pendingApprovals.isNotEmpty) ...[
          SliverPadding(
            padding: EdgeInsets.all(Spacing.md),
            sliver: SliverToBoxAdapter(
              child: Text(
                'Pending Approvals (${pendingApprovals.length})',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SliverList.builder(
            itemCount: pendingApprovals.length,
            itemBuilder: (context, index) {
              return _buildApprovalCard(
                context,
                approval: pendingApprovals[index],
                isPending: true,
              );
            },
          ),
        ],

        // Other approvals section
        if (otherApprovals.isNotEmpty) ...[
          SliverPadding(
            padding: EdgeInsets.all(Spacing.md),
            sliver: SliverToBoxAdapter(
              child: Text(
                'Other Approvals',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SliverList.builder(
            itemCount: otherApprovals.length,
            itemBuilder: (context, index) {
              return _buildApprovalCard(
                context,
                approval: otherApprovals[index],
                isPending: false,
              );
            },
          ),
        ],

        // Empty state
        if (DemoData.propertyApprovals.isEmpty)
          SliverFillRemaining(
            child: _buildEmptyState(context, theme),
          ),
      ],
    );
  }

  Widget _buildApprovalCard(
    BuildContext context, {
    required DemoPropertyApproval approval,
    required bool isPending,
  }) {
    final theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.symmetric(horizontal: Spacing.md, vertical: Spacing.xs),
      child: Padding(
        padding: EdgeInsets.all(Spacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        approval.propertyTitle,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: Spacing.xs),
                      Text(
                        'Submitted by ${approval.ownerName}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildStatusChip(approval.status, theme),
              ],
            ),
            SizedBox(height: Spacing.md),

            // Details
            Row(
              children: [
                Icon(
                  Icons.email_outlined,
                  size: 16,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                SizedBox(width: Spacing.xs),
                Expanded(
                  child: Text(
                    approval.ownerEmail,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: Spacing.xs),
            Row(
              children: [
                Icon(
                  Icons.schedule_outlined,
                  size: 16,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                SizedBox(width: Spacing.xs),
                Text(
                  _formatTimeAgo(approval.submittedAt),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),

            // Rejection reason (if rejected)
            if (approval.status == DemoPropertyApprovalStatus.rejected &&
                approval.rejectionReason != null) ...[
              SizedBox(height: Spacing.md),
              Container(
                padding: EdgeInsets.all(Spacing.sm),
                decoration: BoxDecoration(
                  color: AppColors.error50,
                  borderRadius: BorderRadius.circular(BorderRadiusTokens.small),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 16,
                      color: AppColors.error500,
                    ),
                    SizedBox(width: Spacing.xs),
                    Expanded(
                      child: Text(
                        'Reason: ${approval.rejectionReason}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: AppColors.error500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            // Action buttons (for pending approvals)
            if (isPending) ...[
              SizedBox(height: Spacing.md),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _showRejectDialog(context, approval),
                      icon: const Icon(Icons.close, size: 18),
                      label: const Text('Reject'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.error500,
                        side: BorderSide(color: AppColors.error500),
                      ),
                    ),
                  ),
                  SizedBox(width: Spacing.md),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () => _approveProperty(context, approval),
                      icon: const Icon(Icons.check, size: 18),
                      label: const Text('Approve'),
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.success500,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(DemoPropertyApprovalStatus status, ThemeData theme) {
    Color color;
    String label;
    IconData icon;

    switch (status) {
      case DemoPropertyApprovalStatus.pending:
        color = AppColors.warning500;
        label = 'Pending';
        icon = Icons.pending_actions;
        break;
      case DemoPropertyApprovalStatus.approved:
        color = AppColors.success500;
        label = 'Approved';
        icon = Icons.check_circle;
        break;
      case DemoPropertyApprovalStatus.rejected:
        color = AppColors.error500;
        label = 'Rejected';
        icon = Icons.cancel;
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: Spacing.sm, vertical: Spacing.xs),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(BorderRadiusTokens.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          SizedBox(width: Spacing.xs),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle_outline,
            size: 64,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          SizedBox(height: Spacing.lg),
          Text(
            'No property approvals',
            style: theme.textTheme.titleLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: Spacing.sm),
          Text(
            'All properties have been reviewed',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _approveProperty(BuildContext context, DemoPropertyApproval approval) {
    setState(() => _isLoading = true);

    // Simulate API call
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() => _isLoading = false);
        
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: AppColors.success500),
                SizedBox(width: Spacing.sm),
                Expanded(
                  child: Text('Property "${approval.propertyTitle}" approved'),
                ),
              ],
            ),
            backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
          ),
        );
      }
    });
  }

  void _showRejectDialog(BuildContext context, DemoPropertyApproval approval) {
    final reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reject Property'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Are you sure you want to reject "${approval.propertyTitle}"?',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: Spacing.md),
            TextField(
              controller: reasonController,
              decoration: const InputDecoration(
                labelText: 'Reason for rejection',
                hintText: 'Enter the reason for rejection...',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop();
              _rejectProperty(context, approval, reasonController.text.trim());
            },
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.error500,
              foregroundColor: Colors.white,
            ),
            child: const Text('Reject'),
          ),
        ],
      ),
    );
  }

  void _rejectProperty(
    BuildContext context,
    DemoPropertyApproval approval,
    String reason,
  ) {
    if (reason.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please provide a reason for rejection'),
          backgroundColor: AppColors.error500,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    // Simulate API call
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() => _isLoading = false);
        
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.cancel, color: AppColors.error500),
                SizedBox(width: Spacing.sm),
                Expanded(
                  child: Text('Property "${approval.propertyTitle}" rejected'),
                ),
              ],
            ),
            backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
          ),
        );
      }
    });
  }

  String _formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }
}
