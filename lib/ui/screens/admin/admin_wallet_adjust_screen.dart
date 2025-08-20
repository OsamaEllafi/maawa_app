import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../widgets/common/app_top_bar.dart';

class AdminWalletAdjustScreen extends StatelessWidget {
  const AdminWalletAdjustScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: 'Wallet Adjustments'),
      body: const Center(child: Text('Wallet Adjustment Tools')),
    );
  }
}
