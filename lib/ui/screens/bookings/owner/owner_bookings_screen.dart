import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../app/navigation/app_router.dart';
import '../../../widgets/common/app_top_bar.dart';
import '../../../widgets/bookings/booking_status_chip.dart';

class OwnerBookingsScreen extends StatefulWidget {
  const OwnerBookingsScreen({super.key});

  @override
  State<OwnerBookingsScreen> createState() => _OwnerBookingsScreenState();
}

class _OwnerBookingsScreenState extends State<OwnerBookingsScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> _getIncomingRequests() {
    // Mock data - in real app this would come from API
    return [
      {
        'id': '1',
        'tenantName': 'Ahmed Hassan',
        'tenantImage': null,
        'propertyName': 'Downtown Apartment',
        'propertyImage': 'property_001_1.png',
        'checkIn': DateTime.now().add(const Duration(days: 5)),
        'checkOut': DateTime.now().add(const Duration(days: 8)),
        'guests': 2,
        'totalPrice': 450.0,
        'message': 'Please provide early check-in if possible. Thank you!',
        'createdAt': DateTime.now().subtract(const Duration(hours: 2)),
        'status': BookingStatus.requested,
      },
      {
        'id': '2',
        'tenantName': 'Sarah Johnson',
        'tenantImage': null,
        'propertyName': 'Beach House',
        'propertyImage': 'property_002_1.png',
        'checkIn': DateTime.now().add(const Duration(days: 12)),
        'checkOut': DateTime.now().add(const Duration(days: 18)),
        'guests': 4,
        'totalPrice': 1200.0,
        'message':
            'We are celebrating our anniversary. Looking forward to a great stay!',
        'createdAt': DateTime.now().subtract(const Duration(hours: 1)),
        'status': BookingStatus.requested,
      },
    ];
  }

  List<Map<String, dynamic>> _getActiveBookings() {
    // Mock data - in real app this would come from API
    return [
      {
        'id': '3',
        'tenantName': 'Mohammed Ali',
        'tenantImage': null,
        'propertyName': 'Mountain Cabin',
        'propertyImage': 'property_003_1.png',
        'checkIn': DateTime.now().add(const Duration(days: 20)),
        'checkOut': DateTime.now().add(const Duration(days: 25)),
        'guests': 3,
        'totalPrice': 800.0,
        'status': BookingStatus.confirmed,
        'createdAt': DateTime.now().subtract(const Duration(days: 1)),
      },
      {
        'id': '4',
        'tenantName': 'Emily Davis',
        'tenantImage': null,
        'propertyName': 'City Loft',
        'propertyImage': 'property_004_1.png',
        'checkIn': DateTime.now().subtract(const Duration(days: 2)),
        'checkOut': DateTime.now().add(const Duration(days: 3)),
        'guests': 2,
        'totalPrice': 600.0,
        'status': BookingStatus.confirmed,
        'createdAt': DateTime.now().subtract(const Duration(days: 5)),
      },
    ];
  }

  Widget _buildIncomingRequestCard(Map<String, dynamic> booking) {
    final theme = Theme.of(context);
    final checkIn = booking['checkIn'] as DateTime;
    final checkOut = booking['checkOut'] as DateTime;
    final nights = checkOut.difference(checkIn).inDays;

    return Card(
      margin: EdgeInsets.only(bottom: Spacing.md),
      child: Padding(
        padding: EdgeInsets.all(Spacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tenant info
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: theme.colorScheme.surfaceContainerHighest,
                  child: booking['tenantImage'] != null
                      ? ClipOval(
                          child: Image.asset(
                            booking['tenantImage'],
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Icon(
                          Icons.person,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                ),
                SizedBox(width: Spacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking['tenantName'],
                        style: theme.textTheme.titleMedium,
                      ),
                      Text(
                        'Requested ${_formatTimeAgo(booking['createdAt'])}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                BookingStatusChip(status: booking['status'], compact: true),
              ],
            ),
            SizedBox(height: Spacing.md),

            // Property info
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
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
                      'assets/images/${booking['propertyImage']}',
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking['propertyName'],
                        style: theme.textTheme.titleSmall,
                      ),
                      Text(
                        '${checkIn.day}/${checkIn.month}/${checkIn.year} - ${checkOut.day}/${checkOut.month}/${checkOut.year}',
                        style: theme.textTheme.bodySmall,
                      ),
                      Text(
                        '${booking['guests']} guest${booking['guests'] > 1 ? 's' : ''} • $nights night${nights > 1 ? 's' : ''}',
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '\$${booking['totalPrice'].toStringAsFixed(0)}',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: Spacing.md),

            // Message
            if (booking['message'] != null &&
                booking['message'].isNotEmpty) ...[
              Container(
                padding: EdgeInsets.all(Spacing.sm),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest.withValues(
                    alpha: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(
                    BorderRadiusTokens.medium,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Message from guest:',
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    SizedBox(height: Spacing.xs),
                    Text(booking['message'], style: theme.textTheme.bodySmall),
                  ],
                ),
              ),
              SizedBox(height: Spacing.md),
            ],

            // Action buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _acceptBooking(booking['id']),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.success500,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: Spacing.sm),
                    ),
                    child: Text('Accept'),
                  ),
                ),
                SizedBox(width: Spacing.md),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _rejectBooking(booking['id']),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.error500,
                      side: BorderSide(color: AppColors.error500),
                      padding: EdgeInsets.symmetric(vertical: Spacing.sm),
                    ),
                    child: Text('Reject'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveBookingCard(Map<String, dynamic> booking) {
    final theme = Theme.of(context);
    final checkIn = booking['checkIn'] as DateTime;
    final checkOut = booking['checkOut'] as DateTime;
    final nights = checkOut.difference(checkIn).inDays;

    return Card(
      margin: EdgeInsets.only(bottom: Spacing.md),
      child: InkWell(
        onTap: () => context.pushNamed(
          AppRouter.bookingDetail,
          pathParameters: {'id': booking['id']},
        ),
        borderRadius: BorderRadius.circular(BorderRadiusTokens.medium),
        child: Padding(
          padding: EdgeInsets.all(Spacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: theme.colorScheme.surfaceContainerHighest,
                    child: booking['tenantImage'] != null
                        ? ClipOval(
                            child: Image.asset(
                              booking['tenantImage'],
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Icon(
                            Icons.person,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                  ),
                  SizedBox(width: Spacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          booking['tenantName'],
                          style: theme.textTheme.titleMedium,
                        ),
                        Text(
                          'Confirmed ${_formatTimeAgo(booking['createdAt'])}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  BookingStatusChip(status: booking['status'], compact: true),
                ],
              ),
              SizedBox(height: Spacing.md),

              Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
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
                        'assets/images/${booking['propertyImage']}',
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          booking['propertyName'],
                          style: theme.textTheme.titleSmall,
                        ),
                        Text(
                          '${checkIn.day}/${checkIn.month}/${checkIn.year} - ${checkOut.day}/${checkOut.month}/${checkOut.year}',
                          style: theme.textTheme.bodySmall,
                        ),
                        Text(
                          '${booking['guests']} guest${booking['guests'] > 1 ? 's' : ''} • $nights night${nights > 1 ? 's' : ''}',
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '\$${booking['totalPrice'].toStringAsFixed(0)}',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(String title, String message) {
    final theme = Theme.of(context);

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
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: Spacing.sm),
          Text(
            message,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  String _formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
    }
  }

  void _acceptBooking(String bookingId) {
    // TODO: Accept booking via API
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Booking accepted'),
        backgroundColor: AppColors.success500,
      ),
    );
    setState(() {
      // Refresh the list
    });
  }

  void _rejectBooking(String bookingId) {
    // TODO: Reject booking via API
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Booking rejected'),
        backgroundColor: AppColors.error500,
      ),
    );
    setState(() {
      // Refresh the list
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppTopBar(title: 'My Bookings'),
      body: Column(
        children: [
          // Tab bar
          Container(
            color: theme.colorScheme.surface,
            child: TabBar(
              controller: _tabController,
              tabs: [
                Tab(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Incoming Requests'),
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
                          '${_getIncomingRequests().length}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onPrimary,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Active Bookings'),
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
                          '${_getActiveBookings().length}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onPrimary,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Tab content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Incoming Requests
                RefreshIndicator(
                  onRefresh: () async {
                    // TODO: Refresh incoming requests from API
                    await Future.delayed(const Duration(seconds: 1));
                    setState(() {});
                  },
                  child: _getIncomingRequests().isEmpty
                      ? _buildEmptyState(
                          'No incoming requests',
                          'New booking requests will appear here',
                        )
                      : ListView.builder(
                          padding: EdgeInsets.all(Spacing.md),
                          itemCount: _getIncomingRequests().length,
                          itemBuilder: (context, index) {
                            return _buildIncomingRequestCard(
                              _getIncomingRequests()[index],
                            );
                          },
                        ),
                ),

                // Active Bookings
                RefreshIndicator(
                  onRefresh: () async {
                    // TODO: Refresh active bookings from API
                    await Future.delayed(const Duration(seconds: 1));
                    setState(() {});
                  },
                  child: _getActiveBookings().isEmpty
                      ? _buildEmptyState(
                          'No active bookings',
                          'Your confirmed bookings will appear here',
                        )
                      : ListView.builder(
                          padding: EdgeInsets.all(Spacing.md),
                          itemCount: _getActiveBookings().length,
                          itemBuilder: (context, index) {
                            return _buildActiveBookingCard(
                              _getActiveBookings()[index],
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
