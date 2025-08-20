import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/accessibility_helper.dart';
import '../../../demo/demo_data.dart';
import '../../widgets/common/app_top_bar.dart';
import '../../widgets/bookings/booking_status_chip.dart';
import '../../widgets/bookings/countdown_badge.dart';
import '../../../app/navigation/app_router.dart';

class MyBookingsScreen extends StatefulWidget {
  const MyBookingsScreen({super.key});

  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  final List<BookingStatus> _statusTabs = [
    BookingStatus.requested,
    BookingStatus.pendingPayment,
    BookingStatus.confirmed,
    BookingStatus.completed,
    BookingStatus.cancelled,
    BookingStatus.expired,
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _statusTabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<DemoBooking> _getBookingsForStatus(BookingStatus status) {
    // Convert BookingStatus to DemoBookingStatus for filtering
    DemoBookingStatus demoStatus;
    switch (status) {
      case BookingStatus.requested:
        demoStatus = DemoBookingStatus.requested;
        break;
      case BookingStatus.pendingPayment:
        demoStatus = DemoBookingStatus.pendingPayment;
        break;
      case BookingStatus.confirmed:
        demoStatus = DemoBookingStatus.confirmed;
        break;
      case BookingStatus.completed:
        demoStatus = DemoBookingStatus.completed;
        break;
      case BookingStatus.cancelled:
        demoStatus = DemoBookingStatus.cancelled;
        break;
      case BookingStatus.expired:
        demoStatus = DemoBookingStatus.expired;
        break;
    }
    
    return DemoData.bookings.where((booking) => booking.status == demoStatus).toList();
  }

  String _getStatusTabTitle(BookingStatus status) {
    switch (status) {
      case BookingStatus.requested:
        return 'Requested';
      case BookingStatus.pendingPayment:
        return 'Payment';
      case BookingStatus.confirmed:
        return 'Confirmed';
      case BookingStatus.completed:
        return 'Completed';
      case BookingStatus.cancelled:
        return 'Cancelled';
      case BookingStatus.expired:
        return 'Expired';
    }
  }

  Widget _buildBookingCard(DemoBooking booking) {
    final theme = Theme.of(context);
    final status = _convertDemoStatusToBookingStatus(booking.status);
    final checkIn = booking.checkIn;
    final checkOut = booking.checkOut;
    final nights = checkOut.difference(checkIn).inDays;

    return Semantics(
      label: 'Booking for ${booking.titleEn}',
      hint: 'Tap to view booking details',
      button: true,
      child: Card(
        margin: EdgeInsets.only(bottom: Spacing.md),
        child: InkWell(
          onTap: () {
            // Debug logging
            debugPrint('PUSH bookingDetail id=${booking.id}');
            context.pushNamed(
              AppRouter.bookingDetail,
              pathParameters: {'id': booking.id},
            );
          },
          borderRadius: BorderRadius.circular(BorderRadiusTokens.medium),
          child: Padding(
            padding: EdgeInsets.all(Spacing.md),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Fixed height image container
                Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(
                      BorderRadiusTokens.medium,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      BorderRadiusTokens.medium,
                    ),
                    child: Image.asset(
                      'assets/images/placeholder.png',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.image,
                          color: theme.colorScheme.onSurfaceVariant,
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(width: Spacing.md),
                // Content with constrained width
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Property name with maxLines
                      Text(
                        booking.titleEn,
                        style: AccessibilityHelper.ensureTextScaling(
                          (theme.textTheme.titleMedium ?? theme.textTheme.bodyLarge!).copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: Spacing.xs),
                      // Date range with maxLines
                      Text(
                        '${checkIn.day}/${checkIn.month}/${checkIn.year} - ${checkOut.day}/${checkOut.month}/${checkOut.year}',
                        style: AccessibilityHelper.ensureTextScaling(
                          (theme.textTheme.bodySmall ?? theme.textTheme.bodyMedium!).copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      // Guest and nights info
                      Text(
                        '${booking.guests} guest${booking.guests > 1 ? 's' : ''} • $nights night${nights > 1 ? 's' : ''}',
                        style: AccessibilityHelper.ensureTextScaling(
                          (theme.textTheme.bodySmall ?? theme.textTheme.bodyMedium!).copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: Spacing.sm),
                      // Wrap for chips to avoid overflow
                      Wrap(
                        spacing: Spacing.sm,
                        runSpacing: Spacing.xs,
                        children: [
                          BookingStatusChip(status: status, compact: true),
                          if (booking.status == DemoBookingStatus.pendingPayment &&
                              booking.pendingUntil != null)
                            CountdownBadge(
                              endTime: booking.pendingUntil!,
                              reducedMotion: MediaQuery.of(context).accessibleNavigation,
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: Spacing.sm),
                // Price and chevron
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '\$250', // Placeholder price
                      style: AccessibilityHelper.ensureTextScaling(
                        (theme.textTheme.titleMedium ?? theme.textTheme.bodyLarge!).copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  BookingStatus _convertDemoStatusToBookingStatus(DemoBookingStatus demoStatus) {
    switch (demoStatus) {
      case DemoBookingStatus.requested:
        return BookingStatus.requested;
      case DemoBookingStatus.accepted:
        return BookingStatus.requested; // Map to requested since we don't have accepted
      case DemoBookingStatus.pendingPayment:
        return BookingStatus.pendingPayment;
      case DemoBookingStatus.confirmed:
        return BookingStatus.confirmed;
      case DemoBookingStatus.completed:
        return BookingStatus.completed;
      case DemoBookingStatus.cancelled:
        return BookingStatus.cancelled;
      case DemoBookingStatus.expired:
        return BookingStatus.expired;
    }
  }

  Widget _buildEmptyState(BookingStatus status) {
    final theme = Theme.of(context);
    final statusText = _getStatusTabTitle(status).toLowerCase();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 64,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          SizedBox(height: Spacing.md),
          Text(
            'No $statusText bookings',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Spacing.sm),
          Text(
            'Your $statusText bookings will appear here',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
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
      appBar: AppTopBar(title: l10n.bookings),
      body: Column(
        children: [
          // Tab bar
          Container(
            color: theme.colorScheme.surface,
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              tabs: _statusTabs.map((status) {
                final bookings = _getBookingsForStatus(status);
                return Tab(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(_getStatusTabTitle(status)),
                      if (bookings.isNotEmpty) ...[
                        SizedBox(width: Spacing.xs),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: Spacing.xs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '${bookings.length}',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onPrimary,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              }).toList(),
            ),
          ),

          // Tab content using CustomScrollView
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: _statusTabs.map((status) {
                final bookings = _getBookingsForStatus(status);

                if (bookings.isEmpty) {
                  return _buildEmptyState(status);
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    // TODO: Refresh bookings from API
                    await Future.delayed(const Duration(seconds: 1));
                    setState(() {});
                  },
                  child: CustomScrollView(
                    slivers: [
                      SliverPadding(
                        padding: EdgeInsets.all(Spacing.md),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) =>
                                _buildBookingCard(bookings[index]),
                            childCount: bookings.length,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
