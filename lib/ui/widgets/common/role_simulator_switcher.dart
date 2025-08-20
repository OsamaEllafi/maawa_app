import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../app/navigation/app_router.dart';
import '../../../app/models/user_role.dart';

/// Role simulator switcher widget for development and testing
class RoleSimulatorSwitcher extends StatelessWidget {
  const RoleSimulatorSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentRole = AppRouter.currentRole.value;

    return Card(
      child: Padding(
        padding: EdgeInsets.all(Spacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.swap_horiz,
                  color: theme.colorScheme.primary,
                ),
                SizedBox(width: Spacing.sm),
                Text(
                  'Role Simulator',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: Spacing.sm),
            Text(
              'Switch between different user roles to test UI variations',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: Spacing.md),
            
            // Role options
            ...UserRole.allRoles.map((role) => _buildRoleOption(
              context,
              role: role,
              isSelected: role == currentRole,
            )),
            
            SizedBox(height: Spacing.sm),
            
            // Current role indicator
            Container(
              padding: EdgeInsets.all(Spacing.sm),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(BorderRadiusTokens.medium),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.person,
                    size: 16,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  SizedBox(width: Spacing.sm),
                  Text(
                    'Current: ${currentRole.displayName}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleOption(
    BuildContext context, {
    required UserRole role,
    required bool isSelected,
  }) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(bottom: Spacing.xs),
      child: InkWell(
        onTap: () => _switchRole(context, role),
        borderRadius: BorderRadius.circular(BorderRadiusTokens.medium),
        child: Container(
          padding: EdgeInsets.all(Spacing.sm),
          decoration: BoxDecoration(
            color: isSelected
                ? theme.colorScheme.primaryContainer
                : Colors.transparent,
            borderRadius: BorderRadius.circular(BorderRadiusTokens.medium),
            border: isSelected
                ? Border.all(color: theme.colorScheme.primary)
                : null,
          ),
          child: Row(
            children: [
              Icon(
                _getRoleIcon(role),
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurfaceVariant,
                size: 20,
              ),
              SizedBox(width: Spacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      role.displayName,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                        color: isSelected
                            ? theme.colorScheme.primary
                            : theme.colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      role.description,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                Icon(
                  Icons.check_circle,
                  color: theme.colorScheme.primary,
                  size: 20,
                ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getRoleIcon(UserRole role) {
    switch (role) {
      case UserRole.tenant:
        return Icons.person_outline;
      case UserRole.owner:
        return Icons.home_work_outlined;
      case UserRole.admin:
        return Icons.admin_panel_settings_outlined;
    }
  }

  void _switchRole(BuildContext context, UserRole newRole) {
    // Update role state
    AppRouter.currentRole.value = newRole;
    
    // Navigate to appropriate screen based on role
    switch (newRole) {
      case UserRole.tenant:
        context.go('/tenant/home');
        break;
      case UserRole.owner:
        context.go('/owner/properties');
        break;
      case UserRole.admin:
        context.go('/admin/home');
        break;
    }
    
    // Show feedback
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Switched to ${newRole.displayName} role'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
