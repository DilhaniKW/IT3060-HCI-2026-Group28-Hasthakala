import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_button.dart';
import '../state/auth_provider.dart';
import '../widgets/profile_avatar_widget.dart';
import 'family_support_settings_screen.dart';
import 'login_screen.dart';

/// Assigned to: WANIGATHUNGA Y. J.
/// Branch: feature/account-support
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final user = auth.currentUser;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Account & Settings'),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          ProfileAvatarWidget(
            name: user?.displayName ?? 'Hasthakala Artisan',
            imageUrl: user?.profileImageUrl,
            onCameraTap: () {},
          ),
          const SizedBox(height: 16),
          Text(
            user?.displayName ?? 'Traditional Craftsman',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            user?.email ?? 'artisan@hasthakala.lk',
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
          ),
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 12),
          ListTile(
            leading: const Icon(Icons.location_city, color: AppColors.primary),
            title: const Text('Origin District'),
            trailing: Text(user?.district ?? 'Kandy',
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          ListTile(
            leading: const Icon(Icons.badge_outlined, color: AppColors.secondary),
            title: const Text('Account Role'),
            trailing: Text((user?.role.name ?? 'buyer').toUpperCase(),
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          ListTile(
            leading: const Icon(Icons.people_outline, color: AppColors.accent),
            title: const Text('Family Support & Permissions'),
            subtitle: const Text('Delegated management for elders'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 14),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FamilySupportSettingsScreen(
                    elderArtisanUid: user?.uid ?? 'artisan123',
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 32),
          CustomButton(
            text: 'Sign Out',
            isOutlined: true,
            textColor: AppColors.error,
            backgroundColor: AppColors.error,
            onPressed: () async {
              await auth.logout();
              if (context.mounted) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
