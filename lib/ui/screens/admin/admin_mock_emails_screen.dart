import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../widgets/common/app_top_bar.dart';

class AdminMockEmailsScreen extends StatelessWidget {
  const AdminMockEmailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: 'Mock Emails'),
      body: const Center(child: Text('Email Testing Tools')),
    );
  }
}
