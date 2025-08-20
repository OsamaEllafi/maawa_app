import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'app_router.dart';

/// Typed navigation helpers for common UI flows
/// 
/// These helpers wrap pushNamed to preserve back stack and provide
/// type-safe navigation calls. They should be used for inner flows
/// rather than tab/role switching.
/// 
/// POLICY: Prefer NavHelpers over raw pushNamed in UI code for better
/// refactor safety and type checking. These helpers eliminate stringly-typed
/// navigation calls and provide a centralized place for navigation logic.
class NavHelpers {
  // Owner Property Editor flows
  static void goToOwnerEditorNew(BuildContext context) {
    context.pushNamed(AppRouter.ownerPropertyEditorNew);
  }

  static void goToOwnerEditorEdit(BuildContext context, String id) {
    context.pushNamed(
      AppRouter.ownerPropertyEditorEdit,
      pathParameters: {'id': id},
    );
  }

  // Property flows
  static void goToPropertyDetail(BuildContext context, String propertyId) {
    context.pushNamed(
      'propertyDetails',
      pathParameters: {'id': propertyId},
    );
  }

  // Booking flows
  static void goToBookingRequest(BuildContext context, String propertyId) {
    context.pushNamed(
      AppRouter.bookingRequest,
      queryParameters: {'propertyId': propertyId},
    );
  }

  static void goToBookingDetails(BuildContext context, String bookingId) {
    context.pushNamed(
      AppRouter.booking,
      pathParameters: {'id': bookingId},
    );
  }

  // Wallet flows
  static void goToWalletTopup(BuildContext context) {
    context.pushNamed(AppRouter.walletTopup);
  }

  static void goToWalletWithdraw(BuildContext context) {
    context.pushNamed(AppRouter.walletWithdraw);
  }

  static void goToWalletHistory(BuildContext context) {
    context.pushNamed(AppRouter.walletHistory);
  }

  // Profile & Settings flows
  static void goToProfile(BuildContext context) {
    context.pushNamed(AppRouter.profile);
  }

  static void goToKYC(BuildContext context) {
    context.pushNamed(AppRouter.kyc);
  }

  static void goToSettings(BuildContext context) {
    context.pushNamed(AppRouter.settings);
  }

  static void goToDevTools(BuildContext context) {
    context.pushNamed(AppRouter.devTools);
  }

  static void goToAbout(BuildContext context) {
    context.pushNamed(AppRouter.about);
  }

  // Media Manager flow
  static void goToPropertyMediaManager(BuildContext context, String propertyId) {
    context.pushNamed(
      'propertyMediaManager',
      pathParameters: {'id': propertyId},
    );
  }
}
