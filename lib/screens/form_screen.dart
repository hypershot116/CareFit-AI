import 'package:flutter/material.dart';
import 'package:carefit_ai/theme/app_theme.dart';

class FormScreen extends StatelessWidget {
  const FormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Fitness Profile')),
      body: const Center(
        child: Text(
          'Form coming in Phase 4!',
          style: TextStyle(color: AppTheme.textSecondary, fontSize: 18),
        ),
      ),
    );
  }
}
