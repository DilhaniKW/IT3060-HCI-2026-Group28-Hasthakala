import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

// I13 Access revoked
class AccessRevokedScreen extends StatelessWidget {
  final String supporterName;
  const AccessRevokedScreen({super.key, required this.supporterName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.check_circle_outline, size: 64, color: AppColors.accent),
              const SizedBox(height: 16),
              const Text('Access revoked',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              Text("$supporterName's support access has been removed.",
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: AppColors.textSecondary)),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Back to Family Assistance'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
