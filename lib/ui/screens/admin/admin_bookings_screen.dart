import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../demo/demo_data.dart';
import '../../widgets/common/app_top_bar.dart';
import '../../widgets/common/skeleton_list.dart';

/// Admin bookings management screen
class AdminBookingsScreen extends StatefulWidget {
  const AdminBookingsScreen({super.key});

  @override
  State<AdminBookingsScreen> createState() => _AdminBookingsScreenState();
}

class _AdminBookingsScreenState extends State<AdminBookingsScreen> {
  bool _isLoading = false;
  String _searchQuery = '';
  DemoBookingStatus? _statusFilter;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppTopBar(title: 'Booking Management'),
      body: _isLoading
          ? const SkeletonList()
          : Column(
              children: [
                // Search and filter bar
                _buildSearchAndFilterBar(context, theme),
                
                // Bookings list
                Expanded(
                  child: _buildBookingsList(context, theme),
                ),
              ],
            ),
    );
  }

  Widget _buildSearchAndFilterBar(BuildContext context, ThemeData theme) {
    return Container(
      padding: EdgeInsets.all(Spacing.md),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: theme.colorScheme.outline.withValues(alpha: 0.2),
          ),
        ),
      ),
      child: Column(
        children: [
          // Search field
          TextField(
            onChanged: (value) => setState(() => _searchQuery = value),
            decoration: InputDecoration(
              hintText: 'Search bookings...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(BorderRadiusTokens.medium),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: Spacing.md,
                vertical: Spacing.sm,
              ),
            ),
          ),
          SizedBox(height: Spacing.md),
          
          // Status filter chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip(
                  context,
                  label: 'All',
                  isSelected: _statusFilter == null,
                  onTap: () => setState(() => _statusFilter = null),
                ),
                SizedBox(width: Spacing.sm),
                _buildFilterChip(
                  context,
                  label: 'Confirmed',
                  isSelected: _statusFilter == DemoBookingStatus.confirmed,
                  onTap: () => setState(() => _statusFilter = DemoBookingStatus.confirmed),
                ),
                SizedBox(width: Spacing.sm),
                _buildFilterChip(
                  context,
                  label: 'Pending Payment',
                  isSelected: _statusFilter == DemoBookingStatus.pendingPayment,
                  onTap: () => setState(() => _statusFilter = DemoBookingStatus.pendingPayment),
                ),
                SizedBox(width: Spacing.sm),
                _buildFilterChip(
                  context,
                  label: 'Requested',
                  isSelected: _statusFilter == DemoBookingStatus.requested,
                  onTap: () => setState(() => _statusFilter = DemoBookingStatus.requested),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(
    BuildContext context, {
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Spacing.md, vertical: Spacing.sm),
        decoration: BoxDecoration(
          color: isSelected 
              ? theme.colorScheme.primary 
              : theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(BorderRadiusTokens.pill),
          border: Border.all(
            color: isSelected 
                ? theme.colorScheme.primary 
                : theme.colorScheme.outline.withValues(alpha: 0.2),
          ),
        ),
        child: Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: isSelected 
                ? theme.colorScheme.onPrimary 
                : theme.colorScheme.onSurface,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildBookingsList(BuildContext context, ThemeData theme) {
    final filteredBookings = _getFilteredBookings();

    if (filteredBookings.isEmpty) {
      return _buildEmptyState(context, theme);
    }

    return ListView.builder(
      padding: EdgeInsets.all(Spacing.md),
      itemCount: filteredBookings.length,
      itemBuilder: (context, index) {
        return _buildBookingCard(context, booking: filteredBookings[index], theme: theme);
      },
    );
  }

  List<DemoBooking> _getFilteredBookings() {
    var bookings = DemoData.bookings;

    // Apply status filter
    if (_statusFilter != null) {
      bookings = bookings.where((booking) => booking.status == _statusFilter).toList();
    }

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      bookings = bookings.where((booking) {
        return booking.titleEn.toLowerCase().contains(query) ||
               booking.titleAr.contains(query);
      }).toList();
    }

    return bookings;
  }

  Widget _buildBookingCard(
    BuildContext context, {
    required DemoBooking booking,
    required ThemeData theme,
  }) {
    return Card(
      margin: EdgeInsets.only(bottom: Spacing.md),
      child: Padding(
        padding: EdgeInsets.all(Spacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row
            Row(
              children: [
                // Property icon
                Container(
                  padding: EdgeInsets.all(Spacing.sm),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(BorderRadiusTokens.small),
                  ),
                  child: Icon(
                    Icons.home,
                    color: theme.colorScheme.primary,
                    size: 20,
                  ),
                ),
                SizedBox(width: Spacing.md),
                
                // Booking info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking.titleEn,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: Spacing.xs),
                      Text(
                        'Booking ID: ${booking.id}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Status chip
                _buildStatusChip(booking.status, theme),
              ],
            ),
            SizedBox(height: Spacing.md),
            
            // Details grid
            Row(
              children: [
                Expanded(
                  child: _buildDetailItem(
                    context,
                    icon: Icons.calendar_today,
                    label: 'Check-in',
                    value: _formatDate(booking.checkIn),
                    theme: theme,
                  ),
                ),
                Expanded(
                  child: _buildDetailItem(
                    context,
                    icon: Icons.calendar_today,
                    label: 'Check-out',
                    value: _formatDate(booking.checkOut),
                    theme: theme,
                  ),
                ),
                Expanded(
                  child: _buildDetailItem(
                    context,
                    icon: Icons.people,
                    label: 'Guests',
                    value: '${booking.guests}',
                    theme: theme,
                  ),
                ),
              ],
            ),
            SizedBox(height: Spacing.md),
            
            // Action buttons
            if (_canCancelBooking(booking)) ...[
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _showCancelDialog(context, booking),
                      icon: const Icon(Icons.cancel, size: 18),
                      label: const Text('Cancel Booking'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.error500,
                        side: BorderSide(color: AppColors.error500),
                      ),
                    ),
                  ),
                ],
              ),
            ] else ...[
              Container(
                padding: EdgeInsets.all(Spacing.sm),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(BorderRadiusTokens.small),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 16,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    SizedBox(width: Spacing.xs),
                    Expanded(
                      child: Text(
                        _getCancellationMessage(booking.status),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required ThemeData theme,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          size: 16,
          color: theme.colorScheme.onSurfaceVariant,
        ),
        SizedBox(height: Spacing.xs),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        SizedBox(height: Spacing.xs),
        Text(
          value,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusChip(DemoBookingStatus status, ThemeData theme) {
    Color color;
    String label;
    IconData icon;

    switch (status) {
      case DemoBookingStatus.requested:
        color = AppColors.warning500;
        label = 'Requested';
        icon = Icons.schedule;
        break;
      case DemoBookingStatus.accepted:
        color = AppColors.primary500;
        label = 'Accepted';
        icon = Icons.check_circle;
        break;
      case DemoBookingStatus.pendingPayment:
        color = AppColors.warning500;
        label = 'Pending Payment';
        icon = Icons.payment;
        break;
      case DemoBookingStatus.confirmed:
        color = AppColors.success500;
        label = 'Confirmed';
        icon = Icons.check_circle;
        break;
      case DemoBookingStatus.completed:
        color = AppColors.success500;
        label = 'Completed';
        icon = Icons.done_all;
        break;
      case DemoBookingStatus.cancelled:
        color = AppColors.error500;
        label = 'Cancelled';
        icon = Icons.cancel;
        break;
      case DemoBookingStatus.expired:
        color = AppColors.error500;
        label = 'Expired';
        icon = Icons.timer_off;
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: Spacing.sm, vertical: Spacing.xs),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(BorderRadiusTokens.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          SizedBox(width: Spacing.xs),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.calendar_month_outlined,
            size: 64,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          SizedBox(height: Spacing.lg),
          Text(
            'No bookings found',
            style: theme.textTheme.titleLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: Spacing.sm),
          Text(
            'Try adjusting your search or filters',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  bool _canCancelBooking(DemoBooking booking) {
    return booking.status == DemoBookingStatus.confirmed ||
           booking.status == DemoBookingStatus.pendingPayment ||
           booking.status == DemoBookingStatus.accepted;
  }

  String _getCancellationMessage(DemoBookingStatus status) {
    switch (status) {
      case DemoBookingStatus.requested:
        return 'Booking is still pending approval';
      case DemoBookingStatus.completed:
        return 'Booking has already been completed';
      case DemoBookingStatus.cancelled:
        return 'Booking has already been cancelled';
      case DemoBookingStatus.expired:
        return 'Booking has expired';
      default:
        return 'Booking cannot be cancelled';
    }
  }

  void _showCancelDialog(BuildContext context, DemoBooking booking) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Booking'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Are you sure you want to cancel this booking?',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: Spacing.md),
            Text(
              'This action cannot be undone and may affect the user\'s experience.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Keep Booking'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop();
              _cancelBooking(context, booking);
            },
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.error500,
              foregroundColor: Colors.white,
            ),
            child: const Text('Cancel Booking'),
          ),
        ],
      ),
    );
  }

  void _cancelBooking(BuildContext context, DemoBooking booking) {
    setState(() => _isLoading = true);
    
    // Simulate API call
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() => _isLoading = false);
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.cancel, color: AppColors.error500),
                SizedBox(width: Spacing.sm),
                Expanded(
                  child: Text('Booking "${booking.titleEn}" has been cancelled'),
                ),
              ],
            ),
            backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
          ),
        );
      }
    });
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
