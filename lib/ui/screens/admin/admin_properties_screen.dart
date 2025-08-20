import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class AdminPropertiesScreen extends StatelessWidget {
  const AdminPropertiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Properties')),
      body: const Center(child: Text('Admin Properties Management')),
    );
  }
}
