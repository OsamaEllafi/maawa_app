import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../l10n/app_localizations.dart';
import '../../../demo/demo_data.dart';
import '../../../app/navigation/app_router.dart';
import '../../widgets/bookings/countdown_badge.dart';
import '../../widgets/bookings/booking_status_chip.dart';
import '../../widgets/common/app_sliver_top_bar.dart';

/// Booking detail screen showing comprehensive booking information
class BookingDetailScreen extends StatefulWidget {
  const BookingDetailScreen({super.key});

  @override
  State<BookingDetailScreen> createState() => _BookingDetailScreenState();
}

class _BookingDetailScreenState extends State<BookingDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final id = GoRouterState.of(context).pathParameters['id'] ?? '';
    
    // Debug assert to catch future regressions
    assert(() {
      // No custom guestsLabel must shadow l10n.guestsLabel
      // If someone re-introduces a helper with same name,
      // this comment stands as a hint to check shadows/collisions.
      return true;
    }());
    
    // Enhanced debug logging
    debugPrint('DETAIL id=$id → available: ${DemoData.bookings.map((b) => b.id).toList()}');
    
    final booking = DemoData.bookingById(id);
    debugPrint('DETAIL found=${booking != null}');

    if (booking == null) {
      // NO navigation here. Just render an error surface.
      return Scaffold(
        appBar: AppBar(title: Text(l10n.bookings)),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Booking not found'),
              const SizedBox(height: 8),
              Text('ID: ${id.isEmpty ? '-' : id}'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.goNamed('tenantHome'),
                child: Text('Go Home'),
              ),
            ],
          ),
        ),
      );
    }

    final isRtl = Directionality.of(context) == TextDirection.rtl;

    // Build a simple, localized timeline:
    final steps = <String>[
      l10n.bookingTimelineRequested,
      l10n.bookingTimelineAccepted,
      l10n.bookingTimelinePendingPayment,
      l10n.bookingTimelineConfirmed,
    ];

    // Decide current index based on status
    final currentIndex = () {
      switch (booking.status) {
        case DemoBookingStatus.requested:
          return 0;
        case DemoBookingStatus.accepted:
          return 1;
        case DemoBookingStatus.pendingPayment:
          return 2;
        case DemoBookingStatus.confirmed:
          return 3;
        case DemoBookingStatus.completed:
          return 3;
        case DemoBookingStatus.cancelled:
          return 0;
        case DemoBookingStatus.expired:
          return 2;
      }
    }();

    final timeline = isRtl ? steps.reversed.toList() : steps;

    final showCountdown = booking.status == DemoBookingStatus.pendingPayment &&
        booking.pendingUntil != null &&
        booking.pendingUntil!.isAfter(DateTime.now());

    // Use the generated localization method
    final guestsText = l10n.guestsLabel(booking.guests);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          AppSliverTopBar(title: l10n.bookings),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList.list(
              children: [
                // Status + optional countdown
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BookingStatusChip(
                      status: _convertDemoStatusToBookingStatus(booking.status),
                    ),
                    const SizedBox(width: 12),
                    if (showCountdown)
                      CountdownBadge(endTime: booking.pendingUntil!),
                  ],
                ),

                const SizedBox(height: 16),

                // Timeline (simple pills)
                Text(l10n.bookingTimelineTitle, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
                  children: [
                    for (var i = 0; i < timeline.length; i++)
                      _StepPill(
                        label: timeline[i],
                        isActive: isRtl ? (timeline.length - 1 - i) <= currentIndex : i <= currentIndex,
                      ),
                  ],
                ),

                const SizedBox(height: 24),

                // Details
                Text(
                  isRtl ? booking.titleAr : booking.titleEn,
                  style: Theme.of(context).textTheme.titleLarge,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  '${l10n.checkIn}: ${_fmtDate(booking.checkIn)}   •   ${l10n.checkOut}: ${_fmtDate(booking.checkOut)}   •   $guestsText',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 24),

                // Status-specific CTAs
                if (booking.status == DemoBookingStatus.pendingPayment)
                  FilledButton(
                    onPressed: () async {
                      await context.pushNamed(AppRouter.walletTopup);
                      if (!context.mounted) return;

                      // UI-only: mark as confirmed so the timeline/countdown update
                      final ok = DemoData.updateBookingStatus(booking.id, DemoBookingStatus.confirmed);
                      if (ok && mounted) {
                        setState(() {/* booking state now re-read from DemoData in build */});
                        final l10n = AppLocalizations.of(context)!;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(l10n.paymentSimulated)),
                        );
                      }
                    },
                    child: Text(l10n.payNow),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static BookingStatus _convertDemoStatusToBookingStatus(DemoBookingStatus s) {
    switch (s) {
      case DemoBookingStatus.requested:
        return BookingStatus.requested;
      case DemoBookingStatus.pendingPayment:
        return BookingStatus.pendingPayment;
      case DemoBookingStatus.accepted:
        // Map 'accepted' to 'confirmed' in UI
        return BookingStatus.confirmed;
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

  static String _fmtDate(DateTime d) =>
      '${d.year}/${d.month.toString().padLeft(2, '0')}/${d.day.toString().padLeft(2, '0')}';
}

class _StepPill extends StatelessWidget {
  final String label;
  final bool isActive;
  const _StepPill({required this.label, required this.isActive});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final bg = isActive ? cs.primaryContainer : cs.surfaceContainerHighest;
    final fg = isActive ? cs.onPrimaryContainer : cs.onSurfaceVariant;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: Theme.of(context)
            .textTheme
            .labelLarge
            ?.copyWith(color: fg),
      ),
    );
  }
}
