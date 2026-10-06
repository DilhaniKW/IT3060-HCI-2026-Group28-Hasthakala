import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/localization/tr.dart';

/// I01 hi-fi "Checking your available access..." (visibility of system status).
/// Shown while the session and contexts are being loaded.
class CheckingAccessScreen extends StatelessWidget {
  const CheckingAccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Text(context.tr('checking_access'),
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary)),
              const SizedBox(height: 24),
              const LinearProgressIndicator(
                color: AppColors.primary,
                backgroundColor: AppColors.border,
              ),
              const SizedBox(height: 12),
              Text(context.tr('checking_access_sub'),
                  style: const TextStyle(color: AppColors.textSecondary)),
            ],
          ),
        ),
      ),
    );
  }
}
