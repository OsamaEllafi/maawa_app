import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/theme/app_theme.dart';
import '../../widgets/common/app_top_bar.dart';
import '../../../app/navigation/app_router.dart';

/// Booking request screen for creating new bookings
class BookingRequestScreen extends StatefulWidget {
  const BookingRequestScreen({
    super.key,
    this.propertyId,
  });

  final String? propertyId;

  @override
  State<BookingRequestScreen> createState() => _BookingRequestScreenState();
}

class _BookingRequestScreenState extends State<BookingRequestScreen> {
  DateTime? _checkInDate;
  DateTime? _checkOutDate;
  int _guests = 1;
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppTopBar(
        title: 'Book Property',
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Spacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Property info
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
                        borderRadius: BorderRadius.circular(BorderRadiusTokens.medium),
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
                            'Beautiful Property ${widget.propertyId ?? "Demo"}',
                            style: theme.textTheme.titleMedium,
                          ),
                          Text(
                            'Downtown Area',
                            style: theme.textTheme.bodyMedium,
                          ),
                          SizedBox(height: Spacing.xs),
                          Row(
                            children: [
                              Icon(Icons.star, size: 16, color: AppColors.warning500),
                              SizedBox(width: Spacing.xs),
                              Text('4.8', style: theme.textTheme.bodySmall),
                              SizedBox(width: Spacing.sm),
                              Text('\$150/night', style: theme.textTheme.titleSmall),
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

            // Dates
            Text('Select Dates', style: theme.textTheme.titleLarge),
            SizedBox(height: Spacing.md),
            Row(
              children: [
                Expanded(
                  child: _buildDateSelector(
                    context,
                    label: 'Check-in',
                    date: _checkInDate,
                    onTap: () => _selectCheckInDate(context),
                  ),
                ),
                SizedBox(width: Spacing.md),
                Expanded(
                  child: _buildDateSelector(
                    context,
                    label: 'Check-out',
                    date: _checkOutDate,
                    onTap: () => _selectCheckOutDate(context),
                  ),
                ),
              ],
            ),
            SizedBox(height: Spacing.lg),

            // Guests
            Text('Guests', style: theme.textTheme.titleLarge),
            SizedBox(height: Spacing.md),
            Card(
              child: Padding(
                padding: EdgeInsets.all(Spacing.md),
                child: Row(
                  children: [
                    Icon(Icons.people_outline),
                    SizedBox(width: Spacing.md),
                    Expanded(
                      child: Text('Number of guests', style: theme.textTheme.titleMedium),
                    ),
                    IconButton(
                      onPressed: _guests > 1 ? () => setState(() => _guests--) : null,
                      icon: const Icon(Icons.remove),
                    ),
                    Container(
                      width: 40,
                      child: Text(
                        '$_guests',
                        style: theme.textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    IconButton(
                      onPressed: _guests < 10 ? () => setState(() => _guests++) : null,
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: Spacing.lg),

            // Message to host
            Text('Message to Host (Optional)', style: theme.textTheme.titleLarge),
            SizedBox(height: Spacing.md),
            TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                hintText: 'Tell the host about your trip, arrival time, etc.',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
            SizedBox(height: Spacing.lg),

            // Price breakdown
            if (_checkInDate != null && _checkOutDate != null)
              _buildPriceBreakdown(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(Spacing.md),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          border: Border(
            top: BorderSide(color: theme.colorScheme.outline),
          ),
        ),
        child: SafeArea(
          child: ElevatedButton(
            onPressed: _canSubmitBooking() ? _submitBooking : null,
            child: const Text('Submit Booking Request'),
          ),
        ),
      ),
    );
  }

  Widget _buildDateSelector(
    BuildContext context, {
    required String label,
    required DateTime? date,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(BorderRadiusTokens.medium),
        child: Padding(
          padding: EdgeInsets.all(Spacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: theme.textTheme.bodyMedium),
              SizedBox(height: Spacing.xs),
              Text(
                date != null 
                  ? '${date.day}/${date.month}/${date.year}'
                  : 'Select date',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: date != null 
                    ? theme.colorScheme.onSurface 
                    : theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriceBreakdown() {
    final theme = Theme.of(context);
    final nights = _checkOutDate!.difference(_checkInDate!).inDays;
    final basePrice = 150 * nights;
    final fees = 25;
    final total = basePrice + fees;

    return Card(
      child: Padding(
        padding: EdgeInsets.all(Spacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Price Breakdown', style: theme.textTheme.titleMedium),
            SizedBox(height: Spacing.md),
            _buildPriceRow('\$150 x $nights nights', '\$$basePrice'),
            SizedBox(height: Spacing.sm),
            _buildPriceRow('Service fees', '\$$fees'),
            Divider(),
            _buildPriceRow('Total', '\$$total', isTotal: true),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRow(String label, String amount, {bool isTotal = false}) {
    final theme = Theme.of(context);
    final style = isTotal 
      ? theme.textTheme.titleMedium 
      : theme.textTheme.bodyMedium;
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style),
        Text(amount, style: style),
      ],
    );
  }

  Future<void> _selectCheckInDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    
    if (date != null) {
      setState(() {
        _checkInDate = date;
        // Reset check-out if it's before new check-in
        if (_checkOutDate != null && _checkOutDate!.isBefore(date)) {
          _checkOutDate = null;
        }
      });
    }
  }

  Future<void> _selectCheckOutDate(BuildContext context) async {
    final firstDate = _checkInDate?.add(const Duration(days: 1)) ?? 
                     DateTime.now().add(const Duration(days: 2));
    
    final date = await showDatePicker(
      context: context,
      initialDate: firstDate,
      firstDate: firstDate,
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    
    if (date != null) {
      setState(() => _checkOutDate = date);
    }
  }

  bool _canSubmitBooking() {
    return _checkInDate != null && _checkOutDate != null;
  }

  void _submitBooking() {
    // TODO: Implement booking submission
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Booking Submitted'),
        content: const Text('Your booking request has been sent to the host. You will receive a confirmation shortly.'),
        actions: [
          TextButton(
            onPressed: () {
              context.pop(); // Close dialog
              context.go(AppRouter.myBookings); // Go to bookings
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
