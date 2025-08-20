import 'package:flutter/material.dart';
import '../../widgets/common/app_top_bar.dart';

class AdminPropertiesScreen extends StatelessWidget {
  const AdminPropertiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: 'Admin Properties'),
      body: const Center(child: Text('Admin Properties Management')),
    );
  }
}
