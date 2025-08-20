import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/theme/app_theme.dart';
import '../../../app/navigation/app_router.dart';

/// Profile screen with edit functionality and enhanced accessibility
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _userName = 'John Doe';
  String _userEmail = 'john.doe@example.com';
  String _userPhone = '+1 (555) 123-4567';
  String _userAvatar = 'JD';
  bool _isEditing = false;
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  Locale _currentLocale = const Locale('en');

  @override
  void initState() {
    super.initState();
    _nameController.text = _userName;
    _phoneController.text = _userPhone;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
      if (!_isEditing) {
        // Save changes
        _userName = _nameController.text;
        _userPhone = _phoneController.text;
      }
    });
  }

  void _changeAvatar() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Change Avatar'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Choose an avatar option:'),
            SizedBox(height: Spacing.md),
            Wrap(
              spacing: Spacing.sm,
              children: [
                'JD', 'JS', 'MJ', 'AK', 'SM', 'AB'
              ].map((initials) => Semantics(
                label: 'Select avatar with initials $initials',
                button: true,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _userAvatar = initials;
                    });
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: _userAvatar == initials 
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(30),
                      border: _userAvatar == initials
                          ? Border.all(color: Theme.of(context).colorScheme.primary, width: 2)
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        initials,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: _userAvatar == initials
                              ? Theme.of(context).colorScheme.onPrimary
                              : Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              )).toList(),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _changeLocale(Locale locale) {
    setState(() {
      _currentLocale = locale;
    });
    // TODO: Implement locale change in app shell
  }

  void _showPhoneEditDialog() {
    final phoneController = TextEditingController(text: _userPhone);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Phone Number'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Enter your phone number:'),
            SizedBox(height: Spacing.md),
            TextFormField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                hintText: '+1 (555) 123-4567',
                prefixIcon: Icon(Icons.phone_outlined),
              ),
              keyboardType: TextInputType.phone,
              textDirection: TextDirection.ltr, // Force LTR for phone numbers
              autofillHints: const [AutofillHints.telephoneNumber],
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
              setState(() {
                _userPhone = phoneController.text;
                _phoneController.text = phoneController.text;
              });
              Navigator.of(context).pop();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.profile),
        actions: [
          if (_isEditing)
            TextButton(
              onPressed: _toggleEdit,
              child: const Text('Save'),
            )
          else
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: _toggleEdit,
              tooltip: 'Edit Profile',
            ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.go(AppRouter.settings),
            tooltip: 'Settings',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(Spacing.lg),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
              ),
              child: Column(
                children: [
                  // Avatar with edit functionality
                  GestureDetector(
                    onTap: _isEditing ? _changeAvatar : null,
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: theme.colorScheme.primary,
                          child: Text(
                            _userAvatar,
                            style: theme.textTheme.headlineMedium?.copyWith(
                              color: theme.colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        if (_isEditing)
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.all(Spacing.xs),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                size: 20,
                                color: theme.colorScheme.onPrimary,
                              ),
                            ),
                          ),
                      ],
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 600.ms)
                      .scale(begin: const Offset(0.8, 0.8), duration: 600.ms),
                  
                  SizedBox(height: Spacing.md),
                  
                  // Name field (editable when editing)
                  if (_isEditing)
                    TextFormField(
                      controller: _nameController,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: theme.colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: false,
                      ),
                    )
                  else
                    Text(
                      _userName,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: theme.colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                        .animate()
                        .fadeIn(delay: 200.ms, duration: 600.ms),
                  
                  // Email (read-only)
                  Text(
                    _userEmail,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer.withOpacity(0.8),
                    ),
                  )
                      .animate()
                      .fadeIn(delay: 400.ms, duration: 600.ms),
                  
                  SizedBox(height: Spacing.md),
                  
                  // Stats row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildStatItem(context, 'Bookings', '12'),
                      SizedBox(width: Spacing.xl),
                      _buildStatItem(context, 'Reviews', '8'),
                      SizedBox(width: Spacing.xl),
                      _buildStatItem(context, 'Rating', '4.8'),
                    ],
                  )
                      .animate()
                      .fadeIn(delay: 600.ms, duration: 600.ms)
                      .slideY(begin: 0.3, duration: 600.ms),
                ],
              ),
            ),

            // Profile sections
            Padding(
              padding: EdgeInsets.all(Spacing.md),
              child: Column(
                children: [
                  _buildSection(
                    context,
                    title: 'Personal Information',
                    items: [
                      _buildListItem(
                        context,
                        icon: Icons.person_outline,
                        title: 'Full Name',
                        subtitle: _isEditing ? 'Tap to edit' : _userName,
                        trailing: _isEditing ? const Icon(Icons.edit) : null,
                        onTap: _isEditing ? () {
                          // Focus on name field
                        } : () {},
                      ),
                      _buildListItem(
                        context,
                        icon: Icons.phone_outlined,
                        title: 'Phone Number',
                        subtitle: _isEditing ? 'Tap to edit' : _userPhone,
                        trailing: _isEditing ? const Icon(Icons.edit) : null,
                        onTap: _isEditing ? () {
                          _showPhoneEditDialog();
                        } : null,
                      ),
                      _buildListItem(
                        context,
                        icon: Icons.language_outlined,
                        title: 'Language',
                        subtitle: _currentLocale.languageCode == 'en' ? 'English' : 'العربية',
                        trailing: DropdownButton<Locale>(
                          value: _currentLocale,
                          underline: const SizedBox(),
                          items: const [
                            DropdownMenuItem(
                              value: Locale('en'),
                              child: Text('English'),
                            ),
                            DropdownMenuItem(
                              value: Locale('ar'),
                              child: Text('العربية'),
                            ),
                          ],
                          onChanged: (locale) => _changeLocale(locale!),
                        ),
                        onTap: () {
                          // Language selection is handled by dropdown
                        },
                      ),
                      _buildListItem(
                        context,
                        icon: Icons.verified_user_outlined,
                        title: 'Identity Verification',
                        subtitle: 'Complete KYC verification',
                        trailing: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: Spacing.sm,
                            vertical: Spacing.xs,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.warning100,
                            borderRadius: BorderRadius.circular(BorderRadiusTokens.small),
                          ),
                          child: Text(
                            'Pending',
                            style: TextStyle(
                              color: AppColors.warning700,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        onTap: () => context.go(AppRouter.kyc),
                      ),
                    ],
                  )
                      .animate()
                      .fadeIn(delay: 800.ms, duration: 600.ms)
                      .slideY(begin: 0.3, duration: 600.ms),
                  
                  SizedBox(height: Spacing.lg),

                  _buildSection(
                    context,
                    title: 'Booking History',
                    items: [
                      _buildListItem(
                        context,
                        icon: Icons.history,
                        title: 'Past Bookings',
                        subtitle: 'View your booking history',
                        onTap: () => context.go(AppRouter.myBookings),
                      ),
                      _buildListItem(
                        context,
                        icon: Icons.favorite_outline,
                        title: 'Favorites',
                        subtitle: 'Your saved properties',
                        onTap: () {
                          // TODO: Navigate to favorites
                        },
                      ),
                      _buildListItem(
                        context,
                        icon: Icons.rate_review_outlined,
                        title: 'Reviews',
                        subtitle: 'Reviews you\'ve written',
                        onTap: () {
                          // TODO: Navigate to reviews
                        },
                      ),
                    ],
                  )
                      .animate()
                      .fadeIn(delay: 1000.ms, duration: 600.ms)
                      .slideY(begin: 0.3, duration: 600.ms),
                  
                  SizedBox(height: Spacing.lg),

                  _buildSection(
                    context,
                    title: 'Support',
                    items: [
                      _buildListItem(
                        context,
                        icon: Icons.help_outline,
                        title: 'Help Center',
                        subtitle: 'Get help and support',
                        onTap: () {
                          // TODO: Navigate to help center
                        },
                      ),
                      _buildListItem(
                        context,
                        icon: Icons.chat_outlined,
                        title: 'Contact Support',
                        subtitle: 'Chat with our support team',
                        onTap: () {
                          // TODO: Open support chat
                        },
                      ),
                      _buildListItem(
                        context,
                        icon: Icons.info_outline,
                        title: 'About',
                        subtitle: 'App version and legal info',
                        onTap: () => context.go(AppRouter.about),
                      ),
                    ],
                  )
                      .animate()
                      .fadeIn(delay: 1200.ms, duration: 600.ms)
                      .slideY(begin: 0.3, duration: 600.ms),
                  
                  SizedBox(height: Spacing.lg),

                  // Logout button
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () => _showLogoutDialog(context),
                      icon: const Icon(Icons.logout),
                      label: Text(l10n.logout),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.error500,
                        side: BorderSide(color: AppColors.error500),
                        padding: EdgeInsets.symmetric(vertical: Spacing.md),
                      ),
                    ),
                  )
                      .animate()
                      .fadeIn(delay: 1400.ms, duration: 600.ms)
                      .slideY(begin: 0.3, duration: 600.ms),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String label, String value) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          value,
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.colorScheme.onPrimaryContainer,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onPrimaryContainer.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required List<Widget> items,
  }) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Spacing.sm),
          child: Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: Spacing.sm),
        Card(
          child: Column(children: items),
        ),
      ],
    );
  }

  Widget _buildListItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
    required VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: trailing ?? const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  void _showLogoutDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.logout),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () {
              context.pop(); // Close dialog
              // TODO: Implement logout
              context.go(AppRouter.authLogin);
            },
            child: Text(l10n.logout),
          ),
        ],
      ),
    );
  }
}
