import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/theme/app_theme.dart';
import '../../../demo/demo_data.dart';
import '../../widgets/common/app_top_bar.dart';
import '../../widgets/form/validated_text_field.dart';
import '../../../app/navigation/app_router.dart';

/// Booking request screen for creating new bookings
class BookingRequestScreen extends StatefulWidget {
  const BookingRequestScreen({super.key, this.propertyId});

  final String? propertyId;

  @override
  State<BookingRequestScreen> createState() => _BookingRequestScreenState();
}

class _BookingRequestScreenState extends State<BookingRequestScreen> {
  DateTime? _checkInDate;
  DateTime? _checkOutDate;
  int _guests = 1;
  final _messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _submitting = false;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isCheckIn) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isCheckIn
          ? DateTime.now().add(const Duration(days: 1))
          : _checkInDate?.add(const Duration(days: 1)) ??
                DateTime.now().add(const Duration(days: 2)),
      firstDate: isCheckIn
          ? DateTime.now().add(const Duration(days: 1))
          : _checkInDate?.add(const Duration(days: 1)) ??
                DateTime.now().add(const Duration(days: 2)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        if (isCheckIn) {
          _checkInDate = picked;
          // Reset checkout date if it's before new check-in date
          if (_checkOutDate != null && _checkOutDate!.isBefore(_checkInDate!)) {
            _checkOutDate = null;
          }
        } else {
          _checkOutDate = picked;
        }
      });
    }
  }

  void _submitBooking() {
    if (_formKey.currentState!.validate() &&
        _checkInDate != null &&
        _checkOutDate != null) {
      setState(() {
        _submitting = true;
      });
      try {
        // Generate a simple id
        final newId = 'bkg_${DateTime.now().millisecondsSinceEpoch}';
        // Pick a property id (e.g., from incoming args or choose first)
        final propertyId = widget.propertyId ?? DemoData.properties.first.id;
        final property = DemoData.getPropertyById(propertyId);

        if (property == null) {
          throw Exception('Property not found');
        }

        // Add a UI-only "Requested" booking
        final newBooking = DemoBooking(
          id: newId,
          propertyId: propertyId,
          titleEn: 'Requested — ${property.title}',
          titleAr: 'تم الطلب — ${property.titleAr}',
          checkIn: _checkInDate!,
          checkOut: _checkOutDate!,
          guests: _guests,
          status: DemoBookingStatus.requested,
        );

        DemoData.bookings.insert(0, newBooking);

        // Verify the booking was added
        final addedBooking = DemoData.bookingById(newId);
        if (addedBooking == null) {
          throw Exception('Failed to add booking to demo data');
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.success),
            backgroundColor: AppColors.success500,
          ),
        );

        // Defer navigation until after this frame completes
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;
          context.pushNamed(
            AppRouter.bookingDetail,
            pathParameters: {'id': newId},
          );
        });
      } catch (e) {
        debugPrint('Error creating booking: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error creating booking: $e'),
            backgroundColor: AppColors.error500,
          ),
        );
      } finally {
        if (mounted) setState(() => _submitting = false);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.error),
          backgroundColor: AppColors.error500,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppTopBar(title: l10n.bookings),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
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
                          color: theme.colorScheme.surfaceContainerHighest,
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
                                Icon(
                                  Icons.star,
                                  size: 16,
                                  color: AppColors.warning500,
                                ),
                                SizedBox(width: Spacing.xs),
                                Text('4.8', style: theme.textTheme.bodySmall),
                                SizedBox(width: Spacing.sm),
                                Text(
                                  '\$150/night',
                                  style: theme.textTheme.titleSmall,
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

              // Check-in date
              Text('Check-in Date', style: theme.textTheme.titleMedium),
              SizedBox(height: Spacing.sm),
              InkWell(
                onTap: () => _selectDate(context, true),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(Spacing.md),
                  decoration: BoxDecoration(
                    border: Border.all(color: theme.colorScheme.outline),
                    borderRadius: BorderRadius.circular(
                      BorderRadiusTokens.medium,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: theme.colorScheme.primary,
                      ),
                      SizedBox(width: Spacing.sm),
                      Text(
                        _checkInDate != null
                            ? '${_checkInDate!.day}/${_checkInDate!.month}/${_checkInDate!.year}'
                            : 'Select check-in date',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: _checkInDate != null
                              ? theme.colorScheme.onSurface
                              : theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: Spacing.md),

              // Check-out date
              Text('Check-out Date', style: theme.textTheme.titleMedium),
              SizedBox(height: Spacing.sm),
              InkWell(
                onTap: _checkInDate != null
                    ? () => _selectDate(context, false)
                    : null,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(Spacing.md),
                  decoration: BoxDecoration(
                    border: Border.all(color: theme.colorScheme.outline),
                    borderRadius: BorderRadius.circular(
                      BorderRadiusTokens.medium,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: _checkInDate != null
                            ? theme.colorScheme.primary
                            : theme.colorScheme.onSurfaceVariant,
                      ),
                      SizedBox(width: Spacing.sm),
                      Text(
                        _checkOutDate != null
                            ? '${_checkOutDate!.day}/${_checkOutDate!.month}/${_checkOutDate!.year}'
                            : 'Select check-out date',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: _checkOutDate != null
                              ? theme.colorScheme.onSurface
                              : theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: Spacing.md),

              // Number of guests
              Text('Number of Guests', style: theme.textTheme.titleMedium),
              SizedBox(height: Spacing.sm),
              Container(
                padding: EdgeInsets.all(Spacing.md),
                decoration: BoxDecoration(
                  border: Border.all(color: theme.colorScheme.outline),
                  borderRadius: BorderRadius.circular(
                    BorderRadiusTokens.medium,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.people, color: theme.colorScheme.primary),
                    SizedBox(width: Spacing.sm),
                    Expanded(
                      child: Text(
                        '$_guests guest${_guests > 1 ? 's' : ''}',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: _guests > 1
                              ? () => setState(() => _guests--)
                              : null,
                          icon: Icon(Icons.remove_circle_outline),
                          color: _guests > 1
                              ? theme.colorScheme.primary
                              : theme.colorScheme.onSurfaceVariant,
                        ),
                        SizedBox(width: Spacing.sm),
                        Text('$_guests', style: theme.textTheme.titleMedium),
                        SizedBox(width: Spacing.sm),
                        IconButton(
                          onPressed: _guests < 10
                              ? () => setState(() => _guests++)
                              : null,
                          icon: Icon(Icons.add_circle_outline),
                          color: _guests < 10
                              ? theme.colorScheme.primary
                              : theme.colorScheme.onSurfaceVariant,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: Spacing.md),

              // Message/Notes
              Text(
                'Message to Owner (Optional)',
                style: theme.textTheme.titleMedium,
              ),
              SizedBox(height: Spacing.sm),
              ValidatedTextField(
                controller: _messageController,
                labelText: 'Message',
                hintText: 'Add any special requests or questions...',
                validator: null, // Optional field
              ),
              SizedBox(height: Spacing.lg),

              // Total calculation
              if (_checkInDate != null && _checkOutDate != null) ...[
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(Spacing.md),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Price per night:',
                              style: theme.textTheme.bodyMedium,
                            ),
                            Text('\$150', style: theme.textTheme.bodyMedium),
                          ],
                        ),
                        SizedBox(height: Spacing.sm),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Number of nights:',
                              style: theme.textTheme.bodyMedium,
                            ),
                            Text(
                              '${_checkOutDate!.difference(_checkInDate!).inDays}',
                              style: theme.textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total:', style: theme.textTheme.titleMedium),
                            Text(
                              '\$${150 * _checkOutDate!.difference(_checkInDate!).inDays}',
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: Spacing.lg),
              ],

              // Submit button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _checkInDate != null && _checkOutDate != null && !_submitting
                      ? _submitBooking
                      : null,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: Spacing.md),
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                  ),
                  child: _submitting
                      ? SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            color: theme.colorScheme.onPrimary,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                    'Submit Booking Request',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
