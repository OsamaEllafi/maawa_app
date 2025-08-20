import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../demo/demo_data.dart';
import '../../widgets/common/app_top_bar.dart';
import '../../widgets/common/skeleton_list.dart';

/// Admin users management screen
class AdminUsersScreen extends StatefulWidget {
  const AdminUsersScreen({super.key});

  @override
  State<AdminUsersScreen> createState() => _AdminUsersScreenState();
}

class _AdminUsersScreenState extends State<AdminUsersScreen> {
  bool _isLoading = false;
  String _searchQuery = '';
  DemoUserRole? _roleFilter;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppTopBar(title: 'User Management'),
      body: _isLoading
          ? const SkeletonList()
          : Column(
              children: [
                // Search and filter bar
                _buildSearchAndFilterBar(context, theme),
                
                // Users list
                Expanded(
                  child: _buildUsersList(context, theme),
                ),
              ],
            ),
    );
  }

  Widget _buildSearchAndFilterBar(BuildContext context, ThemeData theme) {
    return Container(
      padding: EdgeInsets.all(Spacing.md),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: theme.colorScheme.outline.withValues(alpha: 0.2),
          ),
        ),
      ),
      child: Column(
        children: [
          // Search field
          TextField(
            onChanged: (value) => setState(() => _searchQuery = value),
            decoration: InputDecoration(
              hintText: 'Search users...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(BorderRadiusTokens.medium),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: Spacing.md,
                vertical: Spacing.sm,
              ),
            ),
          ),
          SizedBox(height: Spacing.md),
          
          // Role filter chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip(
                  context,
                  label: 'All',
                  isSelected: _roleFilter == null,
                  onTap: () => setState(() => _roleFilter = null),
                ),
                SizedBox(width: Spacing.sm),
                _buildFilterChip(
                  context,
                  label: 'Tenants',
                  isSelected: _roleFilter == DemoUserRole.tenant,
                  onTap: () => setState(() => _roleFilter = DemoUserRole.tenant),
                ),
                SizedBox(width: Spacing.sm),
                _buildFilterChip(
                  context,
                  label: 'Owners',
                  isSelected: _roleFilter == DemoUserRole.owner,
                  onTap: () => setState(() => _roleFilter = DemoUserRole.owner),
                ),
                SizedBox(width: Spacing.sm),
                _buildFilterChip(
                  context,
                  label: 'Admins',
                  isSelected: _roleFilter == DemoUserRole.admin,
                  onTap: () => setState(() => _roleFilter = DemoUserRole.admin),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(
    BuildContext context, {
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Spacing.md, vertical: Spacing.sm),
        decoration: BoxDecoration(
          color: isSelected 
              ? theme.colorScheme.primary 
              : theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(BorderRadiusTokens.pill),
          border: Border.all(
            color: isSelected 
                ? theme.colorScheme.primary 
                : theme.colorScheme.outline.withValues(alpha: 0.2),
          ),
        ),
        child: Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: isSelected 
                ? theme.colorScheme.onPrimary 
                : theme.colorScheme.onSurface,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildUsersList(BuildContext context, ThemeData theme) {
    final filteredUsers = _getFilteredUsers();

    if (filteredUsers.isEmpty) {
      return _buildEmptyState(context, theme);
    }

    return ListView.builder(
      padding: EdgeInsets.all(Spacing.md),
      itemCount: filteredUsers.length,
      itemBuilder: (context, index) {
        return _buildUserCard(context, user: filteredUsers[index], theme: theme);
      },
    );
  }

  List<DemoUser> _getFilteredUsers() {
    var users = DemoData.users;

    // Apply role filter
    if (_roleFilter != null) {
      users = users.where((user) => user.role == _roleFilter).toList();
    }

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      users = users.where((user) {
        return user.name.toLowerCase().contains(query) ||
               user.email.toLowerCase().contains(query);
      }).toList();
    }

    return users;
  }

  Widget _buildUserCard(
    BuildContext context, {
    required DemoUser user,
    required ThemeData theme,
  }) {
    return Card(
      margin: EdgeInsets.only(bottom: Spacing.md),
      child: Padding(
        padding: EdgeInsets.all(Spacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row
            Row(
              children: [
                // Avatar
                CircleAvatar(
                  radius: 24,
                  backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
                  child: Text(
                    user.name[0].toUpperCase(),
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: Spacing.md),
                
                // User info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: Spacing.xs),
                      Text(
                        user.email,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Status and role chips
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildRoleChip(user.role, theme),
                    SizedBox(height: Spacing.xs),
                    _buildStatusChip(user.status, theme),
                  ],
                ),
              ],
            ),
            SizedBox(height: Spacing.md),
            
            // Details row
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                SizedBox(width: Spacing.xs),
                Text(
                  'Joined ${_formatDate(user.createdAt)}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                Spacer(),
                if (user.lastLoginAt != null) ...[
                  Icon(
                    Icons.access_time,
                    size: 16,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  SizedBox(width: Spacing.xs),
                  Text(
                    'Last login: ${_formatTimeAgo(user.lastLoginAt!)}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
            SizedBox(height: Spacing.md),
            
            // Action buttons
            Row(
              children: [
                Expanded(
                  child: _buildActionButton(
                    context,
                    icon: Icons.lock,
                    label: user.status == DemoUserStatus.active ? 'Lock' : 'Unlock',
                    color: user.status == DemoUserStatus.active 
                        ? AppColors.warning500 
                        : AppColors.success500,
                    onTap: () => _toggleUserStatus(context, user),
                  ),
                ),
                SizedBox(width: Spacing.sm),
                Expanded(
                  child: _buildActionButton(
                    context,
                    icon: Icons.person_add,
                    label: 'Promote',
                    color: theme.colorScheme.primary,
                    onTap: () => _promoteUser(context, user),
                    enabled: user.role != DemoUserRole.admin,
                  ),
                ),
                SizedBox(width: Spacing.sm),
                Expanded(
                  child: _buildActionButton(
                    context,
                    icon: Icons.person_remove,
                    label: 'Demote',
                    color: AppColors.error500,
                    onTap: () => _demoteUser(context, user),
                    enabled: user.role != DemoUserRole.tenant,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleChip(DemoUserRole role, ThemeData theme) {
    Color color;
    String label;

    switch (role) {
      case DemoUserRole.tenant:
        color = AppColors.primary500;
        label = 'Tenant';
        break;
      case DemoUserRole.owner:
        color = AppColors.success500;
        label = 'Owner';
        break;
      case DemoUserRole.admin:
        color = AppColors.error500;
        label = 'Admin';
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: Spacing.sm, vertical: Spacing.xs),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(BorderRadiusTokens.pill),
      ),
      child: Text(
        label,
        style: theme.textTheme.bodySmall?.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildStatusChip(DemoUserStatus status, ThemeData theme) {
    Color color;
    String label;
    IconData icon;

    switch (status) {
      case DemoUserStatus.active:
        color = AppColors.success500;
        label = 'Active';
        icon = Icons.check_circle;
        break;
      case DemoUserStatus.locked:
        color = AppColors.warning500;
        label = 'Locked';
        icon = Icons.lock;
        break;
      case DemoUserStatus.suspended:
        color = AppColors.error500;
        label = 'Suspended';
        icon = Icons.block;
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
          Icon(icon, size: 12, color: color),
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

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
    bool enabled = true,
  }) {
    final theme = Theme.of(context);
    
    return OutlinedButton.icon(
      onPressed: enabled ? onTap : null,
      icon: Icon(icon, size: 16),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        foregroundColor: enabled ? color : theme.colorScheme.onSurfaceVariant,
        side: BorderSide(
          color: enabled ? color : theme.colorScheme.outline.withValues(alpha: 0.2),
        ),
        padding: EdgeInsets.symmetric(vertical: Spacing.sm),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.people_outline,
            size: 64,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          SizedBox(height: Spacing.lg),
          Text(
            'No users found',
            style: theme.textTheme.titleLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: Spacing.sm),
          Text(
            'Try adjusting your search or filters',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _toggleUserStatus(BuildContext context, DemoUser user) {
    final newStatus = user.status == DemoUserStatus.active 
        ? DemoUserStatus.locked 
        : DemoUserStatus.active;
    
    final action = newStatus == DemoUserStatus.locked ? 'locked' : 'unlocked';
    
    setState(() => _isLoading = true);
    
    // Simulate API call
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() => _isLoading = false);
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('User ${user.name} has been $action'),
            backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
          ),
        );
      }
    });
  }

  void _promoteUser(BuildContext context, DemoUser user) {
    setState(() => _isLoading = true);
    
    // Simulate API call
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() => _isLoading = false);
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('User ${user.name} has been promoted'),
            backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
          ),
        );
      }
    });
  }

  void _demoteUser(BuildContext context, DemoUser user) {
    setState(() => _isLoading = true);
    
    // Simulate API call
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() => _isLoading = false);
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('User ${user.name} has been demoted'),
            backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
          ),
        );
      }
    });
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
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
