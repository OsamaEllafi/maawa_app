import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/theme/app_theme.dart';
import '../../../app/navigation/app_router.dart';

/// My bookings screen showing user's booking history
class MyBookingsScreen extends StatefulWidget {
  const MyBookingsScreen({super.key});

  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.bookings),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Upcoming'),
            Tab(text: 'Past'),
            Tab(text: 'Cancelled'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildBookingsList('upcoming'),
          _buildBookingsList('past'),
          _buildBookingsList('cancelled'),
        ],
      ),
    );
  }

  Widget _buildBookingsList(String type) {
    final bookings = _getBookingsForType(type);
    
    if (bookings.isEmpty) {
      return _buildEmptyState(type);
    }

    return ListView.builder(
      padding: EdgeInsets.all(Spacing.md),
      itemCount: bookings.length,
      itemBuilder: (context, index) => _buildBookingCard(bookings[index]),
    );
  }

  Widget _buildEmptyState(String type) {
    final theme = Theme.of(context);
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            type == 'upcoming' ? Icons.calendar_today : 
            type == 'past' ? Icons.history : Icons.cancel,
            size: 80,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          SizedBox(height: Spacing.lg),
          Text(
            'No ${type} bookings',
            style: theme.textTheme.headlineSmall,
          ),
          SizedBox(height: Spacing.sm),
          Text(
            type == 'upcoming' 
              ? 'Your upcoming stays will appear here'
              : type == 'past'
                ? 'Your past stays will appear here'
                : 'Your cancelled bookings will appear here',
            style: theme.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          if (type == 'upcoming') ...[
            SizedBox(height: Spacing.lg),
            ElevatedButton(
              onPressed: () => context.go(AppRouter.tenantHome),
              child: const Text('Explore Properties'),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBookingCard(Map<String, dynamic> booking) {
    final theme = Theme.of(context);
    
    return Card(
      margin: EdgeInsets.only(bottom: Spacing.md),
      child: InkWell(
        onTap: () => AppRouter.goToBookingDetails(context, booking['id']),
        borderRadius: BorderRadius.circular(BorderRadiusTokens.medium),
        child: Padding(
          padding: EdgeInsets.all(Spacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(BorderRadiusTokens.small),
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
                        Text(
                          '${booking['checkIn']} - ${booking['checkOut']}',
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  _buildStatusChip(booking['status']),
                ],
              ),
              SizedBox(height: Spacing.md),
              
              Row(
                children: [
                  Icon(Icons.people_outline, size: 16),
                  SizedBox(width: Spacing.xs),
                  Text('${booking['guests']} guests'),
                  SizedBox(width: Spacing.md),
                  Icon(Icons.nights_stay_outlined, size: 16),
                  SizedBox(width: Spacing.xs),
                  Text('${booking['nights']} nights'),
                  const Spacer(),
                  Text(
                    '\$${booking['total']}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
              
              if (booking['status'] == 'upcoming') ...[
                SizedBox(height: Spacing.md),
                Row(
                  children: [
                    const Spacer(),
                    OutlinedButton(
                      onPressed: () {
                        // TODO: Cancel booking
                      },
                      child: const Text('Cancel'),
                    ),
                    SizedBox(width: Spacing.sm),
                    ElevatedButton(
                      onPressed: () => AppRouter.goToBookingDetails(context, booking['id']),
                      child: const Text('View Details'),
                    ),
                  ],
                ),
              ] else if (booking['status'] == 'completed') ...[
                SizedBox(height: Spacing.md),
                Row(
                  children: [
                    const Spacer(),
                    OutlinedButton(
                      onPressed: () {
                        // TODO: Leave review
                      },
                      child: const Text('Leave Review'),
                    ),
                    SizedBox(width: Spacing.sm),
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Book again
                      },
                      child: const Text('Book Again'),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color backgroundColor;
    Color foregroundColor;
    
    switch (status) {
      case 'upcoming':
        backgroundColor = AppColors.primary100;
        foregroundColor = AppColors.primary700;
        break;
      case 'completed':
        backgroundColor = AppColors.success100;
        foregroundColor = AppColors.success700;
        break;
      case 'cancelled':
        backgroundColor = AppColors.error100;
        foregroundColor = AppColors.error700;
        break;
      default:
        backgroundColor = AppColors.surface200;
        foregroundColor = AppColors.textSecondary;
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Spacing.sm,
        vertical: Spacing.xs,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(BorderRadiusTokens.full),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          color: foregroundColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getBookingsForType(String type) {
    // Mock data - replace with actual data source
    final allBookings = [
      {
        'id': 'booking_1',
        'propertyName': 'Cozy Downtown Apartment',
        'location': 'Downtown, City Center',
        'checkIn': 'Dec 25',
        'checkOut': 'Dec 30',
        'guests': 2,
        'nights': 5,
        'total': 750,
        'status': 'upcoming',
      },
      {
        'id': 'booking_2',
        'propertyName': 'Beachfront Villa',
        'location': 'Coastal Area',
        'checkIn': 'Nov 15',
        'checkOut': 'Nov 20',
        'guests': 4,
        'nights': 5,
        'total': 1200,
        'status': 'completed',
      },
      {
        'id': 'booking_3',
        'propertyName': 'Mountain Cabin',
        'location': 'Mountain View',
        'checkIn': 'Oct 10',
        'checkOut': 'Oct 12',
        'guests': 2,
        'nights': 2,
        'total': 300,
        'status': 'cancelled',
      },
    ];

    return allBookings.where((booking) => booking['status'] == type).toList();
  }
}
