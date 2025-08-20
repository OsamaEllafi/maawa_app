/// User roles in the application
enum UserRole {
  tenant,
  owner,
  admin;

  /// Display name for the role
  String get displayName {
    switch (this) {
      case UserRole.tenant:
        return 'Tenant';
      case UserRole.owner:
        return 'Owner';
      case UserRole.admin:
        return 'Admin';
    }
  }

  /// Role description
  String get description {
    switch (this) {
      case UserRole.tenant:
        return 'Search and book properties';
      case UserRole.owner:
        return 'Manage properties and bookings';
      case UserRole.admin:
        return 'System administration';
    }
  }

  /// Check if role has admin permissions
  bool get isAdmin => this == UserRole.admin;

  /// Check if role has owner permissions
  bool get isOwner => this == UserRole.owner || this == UserRole.admin;

  /// Check if role has tenant permissions
  bool get isTenant => true; // All roles can use tenant features

  /// Get available roles for role switching in dev tools
  static List<UserRole> get allRoles => UserRole.values;
}
