import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class AdminUsersScreen extends StatelessWidget {
  const AdminUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Users')),
      body: const Center(child: Text('User Management')),
    );
  }
}
