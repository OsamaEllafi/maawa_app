import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/theme/app_theme.dart';
import '../../widgets/common/app_top_bar.dart';

/// Booking details screen showing full booking information
class BookingDetailsScreen extends StatelessWidget {
  const BookingDetailsScreen({super.key, required this.bookingId});

  final String bookingId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final booking = _getBookingDetails(bookingId);

    return Scaffold(
      appBar: AppTopBar(
        title: 'Booking Details',
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // TODO: Share booking details
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Spacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status card
            Card(
              color: _getStatusColor(booking['status']),
              child: Padding(
                padding: EdgeInsets.all(Spacing.md),
                child: Row(
                  children: [
                    Icon(
                      _getStatusIcon(booking['status']),
                      color: Colors.white,
                    ),
                    SizedBox(width: Spacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _getStatusTitle(booking['status']),
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            _getStatusMessage(booking['status']),
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: Spacing.lg),

            // Property info
            Text('Property', style: theme.textTheme.titleLarge),
            SizedBox(height: Spacing.md),
            Card(
              child: Padding(
                padding: EdgeInsets.all(Spacing.md),
                child: Row(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceVariant,
                        borderRadius: BorderRadius.circular(
                          BorderRadiusTokens.medium,
                        ),
                      ),
                      child: Icon(
                        Icons.image,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    SizedBox(width: Spacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            booking['propertyName'],
                            style: theme.textTheme.titleMedium,
                          ),
                          Text(
                            booking['location'],
                            style: theme.textTheme.bodyMedium,
                          ),
                          SizedBox(height: Spacing.xs),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: 16,
                                color: AppColors.warning500,
                              ),
                              SizedBox(width: Spacing.xs),
                              Text('4.8', style: theme.textTheme.bodySmall),
                              SizedBox(width: Spacing.sm),
                              Text(
                                '(124 reviews)',
                                style: theme.textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: Spacing.lg),

            // Booking details
            Text('Booking Information', style: theme.textTheme.titleLarge),
            SizedBox(height: Spacing.md),
            Card(
              child: Padding(
                padding: EdgeInsets.all(Spacing.md),
                child: Column(
                  children: [
                    _buildDetailRow('Booking ID', booking['id']),
                    _buildDetailRow('Check-in', booking['checkIn']),
                    _buildDetailRow('Check-out', booking['checkOut']),
                    _buildDetailRow('Guests', '${booking['guests']} guests'),
                    _buildDetailRow('Nights', '${booking['nights']} nights'),
                    if (booking['message'] != null)
                      _buildDetailRow('Message', booking['message']),
                  ],
                ),
              ),
            ),
            SizedBox(height: Spacing.lg),

            // Host info
            Text('Host Information', style: theme.textTheme.titleLarge),
            SizedBox(height: Spacing.md),
            Card(
              child: Padding(
                padding: EdgeInsets.all(Spacing.md),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: theme.colorScheme.primary,
                      child: Text(
                        'JD',
                        style: TextStyle(color: theme.colorScheme.onPrimary),
                      ),
                    ),
                    SizedBox(width: Spacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('John Doe', style: theme.textTheme.titleMedium),
                          Text(
                            'Superhost • 5 years hosting',
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        // TODO: Contact host
                      },
                      child: const Text('Contact'),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: Spacing.lg),

            // Payment breakdown
            Text('Payment Details', style: theme.textTheme.titleLarge),
            SizedBox(height: Spacing.md),
            Card(
              child: Padding(
                padding: EdgeInsets.all(Spacing.md),
                child: Column(
                  children: [
                    _buildPaymentRow('Base price', '\$${booking['basePrice']}'),
                    _buildPaymentRow('Service fees', '\$${booking['fees']}'),
                    if (booking['discount'] != null)
                      _buildPaymentRow('Discount', '-\$${booking['discount']}'),
                    Divider(),
                    _buildPaymentRow(
                      'Total',
                      '\$${booking['total']}',
                      isTotal: true,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: Spacing.xl),

            // Action buttons
            if (booking['status'] == 'upcoming') ...[
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _showCancelDialog(context),
                      child: const Text('Cancel Booking'),
                    ),
                  ),
                  SizedBox(width: Spacing.md),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Modify booking
                      },
                      child: const Text('Modify Dates'),
                    ),
                  ),
                ],
              ),
            ] else if (booking['status'] == 'completed') ...[
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Leave review
                  },
                  child: const Text('Leave Review'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Spacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _buildPaymentRow(String label, String amount, {bool isTotal = false}) {
    final style = isTotal
        ? const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
        : null;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: Spacing.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text(amount, style: style),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return AppColors.warning500;
      case 'confirmed':
      case 'upcoming':
        return AppColors.primary500;
      case 'completed':
        return AppColors.success500;
      case 'cancelled':
        return AppColors.error500;
      default:
        return AppColors.surface500;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'pending':
        return Icons.hourglass_empty;
      case 'confirmed':
      case 'upcoming':
        return Icons.check_circle;
      case 'completed':
        return Icons.task_alt;
      case 'cancelled':
        return Icons.cancel;
      default:
        return Icons.info;
    }
  }

  String _getStatusTitle(String status) {
    switch (status) {
      case 'pending':
        return 'Pending Confirmation';
      case 'confirmed':
        return 'Confirmed';
      case 'upcoming':
        return 'Upcoming Stay';
      case 'completed':
        return 'Completed';
      case 'cancelled':
        return 'Cancelled';
      default:
        return 'Unknown Status';
    }
  }

  String _getStatusMessage(String status) {
    switch (status) {
      case 'pending':
        return 'Waiting for host confirmation';
      case 'confirmed':
        return 'Your booking is confirmed';
      case 'upcoming':
        return 'Enjoy your stay!';
      case 'completed':
        return 'Thank you for staying with us';
      case 'cancelled':
        return 'This booking was cancelled';
      default:
        return '';
    }
  }

  void _showCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Booking'),
        content: const Text(
          'Are you sure you want to cancel this booking? This action cannot be undone and cancellation fees may apply.',
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Keep Booking'),
          ),
          TextButton(
            onPressed: () {
              context.pop();
              // TODO: Cancel booking
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Booking cancelled')),
              );
            },
            child: const Text('Cancel Booking'),
          ),
        ],
      ),
    );
  }

  Map<String, dynamic> _getBookingDetails(String bookingId) {
    // Mock data - replace with actual data source
    return {
      'id': bookingId,
      'propertyName': 'Cozy Downtown Apartment',
      'location': 'Downtown, City Center',
      'checkIn': 'December 25, 2024',
      'checkOut': 'December 30, 2024',
      'guests': 2,
      'nights': 5,
      'basePrice': 750,
      'fees': 75,
      'total': 825,
      'status': 'upcoming',
      'message': 'Looking forward to our stay! We will arrive around 3 PM.',
    };
  }
}
