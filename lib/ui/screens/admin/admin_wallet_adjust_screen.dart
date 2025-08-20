import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class AdminWalletAdjustScreen extends StatelessWidget {
  const AdminWalletAdjustScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wallet Adjustments')),
      body: const Center(child: Text('Wallet Adjustment Tools')),
    );
  }
}
