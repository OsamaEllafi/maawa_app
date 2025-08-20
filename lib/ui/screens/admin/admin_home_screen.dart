import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../demo/demo_data.dart';
import '../../widgets/common/app_top_bar.dart';
import '../../../app/navigation/app_router.dart';

/// Admin home screen with system overview and quick actions
class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppTopBar(title: 'Admin Dashboard'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Spacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              'System Overview',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: Spacing.lg),

            // Stats cards
            _buildStatsGrid(context, theme),
            SizedBox(height: Spacing.xl),

            // Quick Actions
            Text(
              'Quick Actions',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: Spacing.md),

            _buildQuickActions(context, theme),
            SizedBox(height: Spacing.xl),

            // Recent Activity
            Text(
              'Recent Activity',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: Spacing.md),

            _buildRecentActivity(context, theme),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsGrid(BuildContext context, ThemeData theme) {
    return Column(
      children: [
        // First row
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                context,
                title: 'Active Users',
                value: DemoData.activeUsersCount.toString(),
                icon: Icons.people,
                color: theme.colorScheme.primary,
                onTap: () => context.pushNamed(AppRouter.adminUsers),
              ),
            ),
            SizedBox(width: Spacing.md),
            Expanded(
              child: _buildStatCard(
                context,
                title: 'Properties',
                value: DemoData.properties.length.toString(),
                icon: Icons.home,
                color: AppColors.success500,
                onTap: () => context.pushNamed(AppRouter.adminProperties),
              ),
            ),
          ],
        ),
        SizedBox(height: Spacing.md),

        // Second row
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                context,
                title: 'Pending Approvals',
                value: DemoData.pendingPropertyApprovalsCount.toString(),
                icon: Icons.pending_actions,
                color: AppColors.warning500,
                onTap: () => context.pushNamed(AppRouter.adminProperties),
              ),
            ),
            SizedBox(width: Spacing.md),
            Expanded(
              child: _buildStatCard(
                context,
                title: 'Total Bookings',
                value: DemoData.totalBookingsCount.toString(),
                icon: Icons.calendar_month,
                color: AppColors.primary500,
                onTap: () => context.pushNamed(AppRouter.adminBookings),
              ),
            ),
          ],
        ),
        SizedBox(height: Spacing.md),

        // Third row
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                context,
                title: 'Total Revenue',
                value: 'د.ل ${DemoData.totalRevenue.toStringAsFixed(0)}',
                icon: Icons.attach_money,
                color: AppColors.success500,
                onTap: () => context.pushNamed(AppRouter.adminWalletAdjust),
              ),
            ),
            SizedBox(width: Spacing.md),
            Expanded(
              child: _buildStatCard(
                context,
                title: 'Mock Emails',
                value: DemoData.mockEmails.length.toString(),
                icon: Icons.email,
                color: AppColors.error500,
                onTap: () => context.pushNamed(AppRouter.adminMockEmails),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    VoidCallback? onTap,
  }) {
    final theme = Theme.of(context);
    
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(BorderRadiusTokens.medium),
        child: Padding(
          padding: EdgeInsets.all(Spacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(Spacing.sm),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(BorderRadiusTokens.small),
                    ),
                    child: Icon(
                      icon,
                      color: color,
                      size: 24,
                    ),
                  ),
                  Spacer(),
                  if (onTap != null)
                    Icon(
                      Icons.chevron_right,
                      color: theme.colorScheme.onSurfaceVariant,
                      size: 20,
                    ),
                ],
              ),
              SizedBox(height: Spacing.md),
              Text(
                value,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              SizedBox(height: Spacing.xs),
              Text(
                title,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context, ThemeData theme) {
    return Card(
      child: Column(
        children: [
                      _buildActionTile(
              context,
              icon: Icons.pending_actions,
              title: 'Property Approvals',
              subtitle: '${DemoData.pendingPropertyApprovalsCount} pending',
              color: AppColors.warning500,
              onTap: () => context.pushNamed(AppRouter.adminProperties),
            ),
          Divider(height: 1, indent: 56),
          _buildActionTile(
            context,
            icon: Icons.people,
            title: 'User Management',
            subtitle: '${DemoData.users.length} total users',
            color: theme.colorScheme.primary,
            onTap: () => context.pushNamed(AppRouter.adminUsers),
          ),
          Divider(height: 1, indent: 56),
                      _buildActionTile(
              context,
              icon: Icons.calendar_month,
              title: 'Booking Management',
              subtitle: '${DemoData.totalBookingsCount} total bookings',
              color: AppColors.primary500,
              onTap: () => context.pushNamed(AppRouter.adminBookings),
            ),
          Divider(height: 1, indent: 56),
          _buildActionTile(
            context,
            icon: Icons.account_balance_wallet,
            title: 'Wallet Adjustments',
            subtitle: 'Manage user balances',
            color: AppColors.success500,
            onTap: () => context.pushNamed(AppRouter.adminWalletAdjust),
          ),
          Divider(height: 1, indent: 56),
          _buildActionTile(
            context,
            icon: Icons.email,
            title: 'Mock Emails',
            subtitle: '${DemoData.mockEmails.length} emails',
            color: AppColors.error500,
            onTap: () => context.pushNamed(AppRouter.adminMockEmails),
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(Spacing.sm),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(BorderRadiusTokens.small),
        ),
        child: Icon(icon, color: color, size: 20),
      ),
      title: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: theme.colorScheme.onSurfaceVariant,
      ),
      onTap: onTap,
    );
  }

  Widget _buildRecentActivity(BuildContext context, ThemeData theme) {
    final recentApprovals = DemoData.propertyApprovals
        .where((p) => p.status == DemoPropertyApprovalStatus.pending)
        .take(3)
        .toList();

    if (recentApprovals.isEmpty) {
      return Card(
        child: Padding(
          padding: EdgeInsets.all(Spacing.lg),
          child: Center(
            child: Column(
              children: [
                Icon(
                  Icons.check_circle_outline,
                  size: 48,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                SizedBox(height: Spacing.md),
                Text(
                  'No pending approvals',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Card(
      child: Column(
        children: recentApprovals.map((approval) {
          return Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppColors.warning500.withValues(alpha: 0.1),
                  child: Icon(
                    Icons.pending_actions,
                    color: AppColors.warning500,
                    size: 20,
                  ),
                ),
                title: Text(
                  approval.propertyTitle,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  'Submitted by ${approval.ownerName}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                trailing: Text(
                  _formatTimeAgo(approval.submittedAt),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                onTap: () => context.pushNamed(AppRouter.adminProperties),
              ),
              if (approval != recentApprovals.last)
                Divider(height: 1, indent: 56),
            ],
          );
        }).toList(),
      ),
    );
  }

  String _formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}
