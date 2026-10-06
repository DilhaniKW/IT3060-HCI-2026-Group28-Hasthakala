import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/shared_models/user_model.dart';
import '../state/auth_provider.dart';

// I01 "How will you start using HASTHAKALA?" (hi-fi frame 15). Asked once.
class PurposeSelectionScreen extends StatelessWidget {
  const PurposeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 12),
              const Text('How will you start using HASTHAKALA?',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700)),
              const SizedBox(height: 6),
              const Text('Choose how you want to begin. You can still shop if you sell.',
                  style: TextStyle(color: AppColors.textSecondary)),
              const SizedBox(height: 24),
              _PurposeCard(
                icon: Icons.shopping_bag_outlined,
                title: 'Shop for Crafts',
                subtitle: 'Discover and support local artisans',
                onTap: auth.isLoading ? null : () => auth.choosePurpose(AccountPurpose.shop),
              ),
              const SizedBox(height: 12),
              _PurposeCard(
                icon: Icons.storefront_outlined,
                title: 'Sell My Crafts',
                subtitle: 'Create and manage your artisan presence',
                onTap: auth.isLoading ? null : () => auth.choosePurpose(AccountPurpose.sell),
              ),
              if (auth.isLoading) ...[
                const SizedBox(height: 20),
                const Center(child: CircularProgressIndicator()),
              ],
              if (auth.errorMessage != null) ...[
                const SizedBox(height: 12),
                Text(auth.errorMessage!, style: const TextStyle(color: AppColors.error)),
              ],
              const Spacer(),
              TextButton(onPressed: auth.logout, child: const Text('Sign out')),
            ],
          ),
        ),
      ),
    );
  }
}

class _PurposeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const _PurposeCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        onTap: onTap,
        leading: Icon(icon, color: AppColors.primary, size: 28),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
