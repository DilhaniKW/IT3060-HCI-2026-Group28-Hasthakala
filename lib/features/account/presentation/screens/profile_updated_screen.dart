import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../discovery/presentation/screens/public_artisan_profile_screen.dart';

// I05_HF_05 Profile updated
class ProfileUpdatedScreen extends StatelessWidget {
  final String artisanId;
  const ProfileUpdatedScreen({super.key, required this.artisanId});

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
              const Text('Profile updated',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              const Text('Your artisan profile changes have been saved.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.textSecondary)),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('View My Profile'),
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (_) => PublicArtisanProfileScreen(artisanId: artisanId)),
                ),
                child: const Text('Preview Public Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
