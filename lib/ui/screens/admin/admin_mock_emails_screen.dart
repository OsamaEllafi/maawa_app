import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class AdminMockEmailsScreen extends StatelessWidget {
  const AdminMockEmailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mock Emails')),
      body: const Center(child: Text('Email Testing Tools')),
    );
  }
}
