import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/user_role.dart';

import '../../ui/screens/not_found_screen.dart';
import '../../ui/layouts/main_scaffold.dart';
import '../../ui/screens/auth/splash_screen.dart';
import '../../ui/screens/auth/onboarding_screen.dart';
import '../../ui/screens/auth/login_screen.dart';
import '../../ui/screens/auth/register_screen.dart';
import '../../ui/screens/auth/forgot_password_screen.dart';
import '../../ui/screens/auth/reset_password_screen.dart';
import '../../ui/screens/home/home_screen.dart';
import '../../ui/screens/properties/property_detail_screen.dart';
import '../../ui/screens/tenant/my_bookings_screen.dart';
import '../../ui/screens/booking/booking_request_screen.dart';
import '../../ui/screens/booking/booking_details_screen.dart';
import '../../ui/screens/wallet/wallet_screen.dart';
import '../../ui/screens/wallet/wallet_topup_screen.dart';
import '../../ui/screens/wallet/wallet_withdraw_screen.dart';
import '../../ui/screens/wallet/wallet_history_screen.dart';
import '../../ui/screens/owner/owner_properties_screen.dart';
import '../../ui/screens/properties/owner/property_editor_screen.dart';
import '../../ui/screens/properties/owner/property_media_manager_screen.dart';
import '../../ui/screens/owner/owner_bookings_screen.dart';
import '../../ui/screens/admin/admin_dashboard_screen.dart';
import '../../ui/screens/admin/admin_properties_screen.dart';
import '../../ui/screens/admin/admin_users_screen.dart';
import '../../ui/screens/admin/admin_bookings_screen.dart';
import '../../ui/screens/admin/admin_wallet_adjust_screen.dart';
import '../../ui/screens/admin/admin_mock_emails_screen.dart';
import '../../ui/screens/profile/profile_screen.dart';
import '../../ui/screens/profile/kyc_screen.dart';
import '../../ui/screens/settings/settings_screen.dart';
import '../../ui/screens/settings/dev_tools_screen.dart';
import '../../ui/screens/about/about_screen.dart';
import '../../ui/screens/style_guide_screen.dart';
import '../../demo/demo_data.dart';

/// Route constants and documentation
/// 
/// Path patterns and parameters:
/// - /: Root route (redirects to /tenant/home)
/// - /style-guide: Style guide screen for component preview
/// - /auth/splash: Authentication splash screen
/// - /auth/login: Login screen
/// - /auth/register: Registration screen
/// - /tenant/home: Tenant home screen
/// - /tenant/properties: Tenant properties list
/// - /tenant/property/:id: Tenant property details (id: property ID)
/// - /booking/:id: Booking details (id: booking ID)
/// - /wallet: Wallet screen
/// - /profile: User profile screen
/// - /settings: Settings screen
/// - /settings/dev-tools: Developer tools screen
/// - /settings/about: About screen
/// - /owner/properties: Owner properties list
/// - /owner/property/:id: Owner property details (id: property ID)
/// - /owner/property/:id/edit: Owner property edit (id: property ID)
/// - /owner/booking/:id: Owner booking details (id: booking ID)
/// - /admin/dashboard: Admin dashboard
/// - /admin/users: Admin users management
/// - /admin/user/:id: Admin user details (id: user ID)
/// - /admin/properties: Admin properties management
/// - /admin/property/:id: Admin property details (id: property ID)
/// - /admin/bookings: Admin bookings management
/// - /admin/booking/:id: Admin booking details (id: booking ID)
/// 
/// Dynamic route parameters:
/// - :id: Used for property, booking, and user IDs
///   - Should be valid UUID or numeric ID
///   - Invalid IDs show empty state, not 404
/// 
/// Shell routes:
/// - Tenant shell: /tenant/* with bottom navigation
/// - Owner shell: /owner/* with side navigation
/// - Admin shell: /admin/* with side navigation
/// 
/// Error handling:
/// - Unknown routes: Redirect to NotFoundScreen
/// - Invalid parameters: Show empty state with retry option

/// App router configuration using go_router
class AppRouter {
  // Route constants for easy reference
  static const String root = '/';
  static const String styleGuide = '/style-guide';
  static const String authSplash = '/auth/splash';
  static const String onboarding = '/onboarding';
  static const String authLogin = '/auth/login';
  static const String authRegister = '/auth/register';
  static const String authForgotPassword = '/auth/forgot-password';
  static const String authResetPassword = '/auth/reset-password';
  static const String tenantHome = '/tenant/home';
  static const String tenantProperties = '/tenant/properties';
  static const String tenantProperty = '/tenant/property';
  static const String booking = '/booking';
  static const String myBookings = '/bookings/my';
  static const String bookingRequest = '/bookings/request';
  static const String wallet = '/wallet';
  static const String walletTopup = '/wallet/topup';
  static const String walletWithdraw = '/wallet/withdraw';
  static const String walletHistory = '/wallet/history';
  static const String profile = '/profile';
  static const String kyc = '/profile/kyc';
  static const String settings = '/settings';
  static const String devTools = '/settings/dev-tools';
  static const String about = '/settings/about';
  static const String ownerProperties = '/owner/properties';
  static const String ownerProperty = '/owner/property';
  static const String ownerPropertyEditorNew = '/owner/properties/new';
  static const String ownerPropertyEditorEdit = '/owner/properties/:id/edit';
  static const String ownerBooking = '/owner/booking';
  static const String ownerBookings = '/owner/bookings';
  static const String adminDashboard = '/admin/dashboard';
  static const String adminUsers = '/admin/users';
  static const String adminUser = '/admin/user';
  static const String adminProperties = '/admin/properties';
  static const String adminProperty = '/admin/property';
  static const String adminBookings = '/admin/bookings';
  static const String adminBooking = '/admin/booking';
  static const String adminWalletAdjust = '/admin/wallet-adjust';
  static const String adminMockEmails = '/admin/mock-emails';

  /// Current user role for navigation logic
  static ValueNotifier<UserRole> currentRole = ValueNotifier(UserRole.tenant);

  /// Create router configuration
  static GoRouter createRouter({
    required Function(ThemeMode) onThemeChanged,
    required Function(Locale) onLocaleChanged,
    required ThemeMode currentThemeMode,
    required Locale currentLocale,
  }) {
    return GoRouter(
      initialLocation: authSplash,
      redirect: (context, state) {
        // Global canonicalization: strip trailing slashes while preserving query/fragment
        final location = state.uri.toString();
        if (location.endsWith('/') && location != '/') {
          final uri = state.uri;
          // Strip all trailing slashes
          String canonicalPath = uri.path;
          while (canonicalPath.endsWith('/') && canonicalPath != '/') {
            canonicalPath = canonicalPath.substring(0, canonicalPath.length - 1);
          }
          final canonicalUri = uri.replace(path: canonicalPath);
          final canonicalLocation = canonicalUri.toString();
          
          // Short-circuit if canonical path equals current path to avoid loops
          if (canonicalLocation == location) {
            return null;
          }
          
          return canonicalLocation;
        }
        return null; // No redirect needed
      },
      routes: [
        // Auth routes (no scaffold)
        GoRoute(
          path: authSplash,
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: onboarding,
          builder: (context, state) => const OnboardingScreen(),
        ),
        GoRoute(
          path: authRegister,
          builder: (context, state) => const RegisterScreen(),
        ),
        GoRoute(
          path: authLogin,
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: authForgotPassword,
          builder: (context, state) => const ForgotPasswordScreen(),
        ),
        GoRoute(
          path: authResetPassword,
          builder: (context, state) => const ResetPasswordScreen(),
        ),

        // Main app routes (with scaffold)
        ShellRoute(
          builder: (context, state, child) => MainScaffold(child: child),
          routes: [
            // Root route (redirects to tenant home)
            GoRoute(
              path: root,
              redirect: (context, state) => tenantHome,
            ),

            // Style guide route
            GoRoute(
              path: styleGuide,
              builder: (context, state) => StyleGuideScreen(
                onThemeChanged: onThemeChanged,
                onLocaleChanged: onLocaleChanged,
                currentThemeMode: currentThemeMode,
                currentLocale: currentLocale,
              ),
            ),

            // Tenant routes
            GoRoute(
              path: tenantHome,
              name: 'tenantHome',
              builder: (context, state) => const HomeScreen(),
            ),
            GoRoute(
              path: tenantProperties,
              builder: (context, state) => const OwnerPropertiesScreen(), // Assuming tenant home is also owner properties for now
            ),
            GoRoute(
              path: '$tenantProperty/:id',
              name: 'propertyDetails',
              builder: (context, state) => PropertyDetailScreen(
                propertyId: state.pathParameters['id']!,
              ),
            ),

            // Booking routes
            GoRoute(
              path: myBookings,
              name: 'myBookings',
              builder: (context, state) => const MyBookingsScreen(),
            ),
            GoRoute(
              path: bookingRequest,
              name: 'bookingRequest',
              builder: (context, state) => BookingRequestScreen(
                propertyId: state.uri.queryParameters['propertyId'],
              ),
            ),
            GoRoute(
              path: '$booking/:id',
              builder: (context, state) => BookingDetailsScreen(
                bookingId: state.pathParameters['id']!,
              ),
            ),

            // Wallet routes
            GoRoute(
              path: wallet,
              builder: (context, state) => const WalletScreen(),
            ),
            GoRoute(
              path: walletTopup,
              builder: (context, state) => const WalletTopupScreen(),
            ),
            GoRoute(
              path: walletWithdraw,
              builder: (context, state) => const WalletWithdrawScreen(),
            ),
            GoRoute(
              path: walletHistory,
              builder: (context, state) => const WalletHistoryScreen(),
            ),

            // Owner routes
            GoRoute(
              path: ownerProperties,
              builder: (context, state) => const OwnerPropertiesScreen(),
            ),
            // Backward compatibility redirects
            GoRoute(
              path: '/owner/property/editor',
              redirect: (context, state) => ownerPropertyEditorNew,
            ),
            GoRoute(
              path: '/owner/property/:id/editor',
              redirect: (context, state) => '/owner/properties/${state.pathParameters['id']}/edit',
            ),
            GoRoute(
              path: ownerPropertyEditorNew,
              name: 'ownerPropertyEditorNew',
              builder: (context, state) => const PropertyEditorScreen(),
            ),
            GoRoute(
              path: ownerPropertyEditorEdit,
              name: 'ownerPropertyEditorEdit',
              builder: (context, state) {
                final rawPropertyId = state.pathParameters['id'];
                
                // Robust ID handling: decode and validate
                if (rawPropertyId == null || rawPropertyId.trim().isEmpty) {
                  return const NotFoundScreen();
                }
                
                // Decode percent-encoded ID
                final propertyId = Uri.decodeComponent(rawPropertyId.trim());
                
                // UI-only guard: check if property exists in demo data
                final propertyExists = DemoData.properties.any((p) => p.id == propertyId);
                if (!propertyExists) {
                  return const NotFoundScreen();
                }
                return PropertyEditorScreen(propertyId: propertyId);
              },
            ),
            GoRoute(
              path: '/owner/property/:id/media',
              name: 'propertyMediaManager',
              builder: (context, state) => PropertyMediaManagerScreen(
                propertyId: state.pathParameters['id']!,
              ),
            ),
            GoRoute(
              path: '$ownerProperty/:id',
              builder: (context, state) => PropertyDetailScreen(
                propertyId: state.pathParameters['id']!,
              ),
            ),

            GoRoute(
              path: '$ownerProperty/:id/media',
              builder: (context, state) => PropertyMediaManagerScreen(
                propertyId: state.pathParameters['id']!,
              ),
            ),
            GoRoute(
              path: ownerBookings,
              builder: (context, state) => const OwnerBookingsScreen(),
            ),
            GoRoute(
              path: '$ownerBooking/:id',
              builder: (context, state) => BookingDetailsScreen(
                bookingId: state.pathParameters['id']!,
              ),
            ),

            // Admin routes
            GoRoute(
              path: adminDashboard,
              builder: (context, state) => const AdminDashboardScreen(),
            ),
            GoRoute(
              path: adminUsers,
              builder: (context, state) => const AdminUsersScreen(),
            ),
            GoRoute(
              path: '$adminUser/:id',
              builder: (context, state) => const ProfileScreen(), // Placeholder for admin user details
            ),
            GoRoute(
              path: adminProperties,
              builder: (context, state) => const AdminPropertiesScreen(),
            ),
            GoRoute(
              path: '$adminProperty/:id',
              builder: (context, state) => const PropertyDetailScreen( // Placeholder for admin property details
                propertyId: 'placeholder',
              ),
            ),
            GoRoute(
              path: adminBookings,
              builder: (context, state) => const AdminBookingsScreen(),
            ),
            GoRoute(
              path: '$adminBooking/:id',
              builder: (context, state) => BookingDetailsScreen( // Placeholder for admin booking details
                bookingId: 'placeholder',
              ),
            ),
            GoRoute(
              path: adminWalletAdjust,
              builder: (context, state) => const AdminWalletAdjustScreen(),
            ),
            GoRoute(
              path: adminMockEmails,
              builder: (context, state) => const AdminMockEmailsScreen(),
            ),

            // Profile & Settings routes
            GoRoute(
              path: profile,
              builder: (context, state) => const ProfileScreen(),
            ),
            GoRoute(
              path: kyc,
              builder: (context, state) => const KYCScreen(),
            ),
            GoRoute(
              path: settings,
              builder: (context, state) => const SettingsScreen(),
            ),
            GoRoute(
              path: devTools,
              builder: (context, state) => DevToolsScreen(
                onThemeChanged: onThemeChanged,
                onLocaleChanged: onLocaleChanged,
                currentThemeMode: currentThemeMode,
                currentLocale: currentLocale,
              ),
            ),
            GoRoute(
              path: about,
              builder: (context, state) => const AboutScreen(),
            ),

                      // Not found route (must be last)
          GoRoute(
            path: '*',
            builder: (context, state) => const NotFoundScreen(),
          ),
          ],
        ),
      ],
    );
  }

  /// Navigation helpers
  static void goToHome(BuildContext context) {
    context.go(tenantHome);
  }

  static void goToProperty(BuildContext context, String propertyId) {
    context.go('$tenantProperty/$propertyId');
  }

  static void goToBookingRequest(BuildContext context, String propertyId) {
    context.go('$bookingRequest?propertyId=$propertyId');
  }

  static void goToBookingDetails(BuildContext context, String bookingId) {
    context.go('$booking/$bookingId');
  }

  static void goToProfile(BuildContext context) {
    context.go(profile);
  }

  static void goToSettings(BuildContext context) {
    context.go(settings);
  }

  static void goToDevTools(BuildContext context) {
    context.go(devTools);
  }

  static void goToStyleGuide(BuildContext context) {
    context.go(styleGuide);
  }

  /// Get current bottom nav index based on location
  static int getBottomNavIndex(String location) {
    if (location.startsWith('/tenant/home') || location.startsWith('/tenant/properties')) {
      return 0; // Home
    } else if (location.startsWith('/bookings')) {
      return 1; // Bookings
    } else if (location.startsWith('/wallet')) {
      return 2; // Wallet
    } else if (location.startsWith('/profile') || location.startsWith('/settings')) {
      return 3; // Profile
    }
    return 0; // Default to Home
  }

  /// Check if route requires authentication
  static bool requiresAuth(String location) {
    const publicRoutes = [authSplash, authRegister, authLogin, authForgotPassword, authResetPassword];
    return !publicRoutes.contains(location);
  }

  /// Check if route is accessible by current role
  static bool isAccessibleByRole(String location, UserRole role) {
    if (location.startsWith('/owner/') && role != UserRole.owner && role != UserRole.admin) {
      return false;
    }
    if (location.startsWith('/admin/') && role != UserRole.admin) {
      return false;
    }
    return true;
  }
}
