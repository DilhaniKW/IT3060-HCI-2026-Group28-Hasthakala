import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_colors.dart';
import '../state/auth_provider.dart';

// I05 Artisan profile created (first-time artisan)
class ArtisanProfileCreatedScreen extends StatelessWidget {
  const ArtisanProfileCreatedScreen({super.key});

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
              const Icon(Icons.check_circle, size: 64, color: AppColors.accent),
              const SizedBox(height: 16),
              const Text('Artisan profile created!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              const Text(
                'Your profile is ready. You can now start showcasing your craft to buyers.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: context.read<AuthProvider>().finishArtisanSetup,
                child: const Text('Continue'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
