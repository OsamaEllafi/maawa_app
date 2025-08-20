import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class AdminBookingsScreen extends StatelessWidget {
  const AdminBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Bookings')),
      body: const Center(child: Text('Booking Management')),
    );
  }
}
