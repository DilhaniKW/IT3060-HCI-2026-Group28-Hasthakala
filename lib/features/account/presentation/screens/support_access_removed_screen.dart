import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_colors.dart';
import '../state/auth_provider.dart';

// shown when the artisan removes support access while it's being used
class SupportAccessRemovedScreen extends StatelessWidget {
  const SupportAccessRemovedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final artisan = auth.lostArtisanName ?? 'the artisan';

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.error_outline, size: 64, color: AppColors.secondaryDark),
              const SizedBox(height: 16),
              const Text('Support access is no longer available',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              Text("Your access to $artisan's business has changed or been removed.",
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: AppColors.textSecondary)),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: auth.acknowledgeSupportLoss,
                child: const Text('Continue'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
