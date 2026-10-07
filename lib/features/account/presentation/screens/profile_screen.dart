import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_colors.dart';
import '../state/auth_provider.dart';
import '../widgets/profile_avatar_widget.dart';
import '../../../../core/localization/tr.dart';
import 'accept_support_invitation_screen.dart';
import 'family_assistance_screen.dart';
import 'language_selection_screen.dart';
import 'my_artisan_profile_screen.dart';

// Profile tab - the entry point to I05 Manage and I13.
// What it shows depends on the active context.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<void> _confirmSignOut(BuildContext context, AuthProvider auth) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(ctx.tr('sign_out_title')),
        content: Text(ctx.tr('sign_out_body')),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(ctx.tr('cancel'))),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: Text(ctx.tr('sign_out')),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;
    Navigator.of(context).popUntil((route) => route.isFirst);
    await auth.logout(); // AuthGate then shows the sign-in screen
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final user = auth.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // artisan profile hub follows I05_HF_01 (no account header)
          if (!auth.isArtisanContext) ...[
            ProfileAvatarWidget(
              name: user?.displayName ?? '',
              imageUrl: user?.photoUrl,
              onCameraTap: () {},
            ),
            const SizedBox(height: 12),
            Text(user?.displayName ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(user?.email ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
            const SizedBox(height: 24),
          ],

          if (auth.isArtisanContext)
            _MenuCard(
              icon: Icons.person_outline,
              title: 'My Artisan Profile',
              subtitle: 'View and manage your public artisan information',
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const MyArtisanProfileScreen())),
            ),
          if (auth.isArtisanContext)
            _MenuCard(
              icon: Icons.people_alt_outlined,
              title: 'Family Assistance',
              subtitle: 'Manage authorised support',
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const FamilyAssistanceScreen())),
            ),

          // buyer can accept an invite to help an artisan
          if (auth.isBuyerContext)
            _MenuCard(
              icon: Icons.handshake_outlined,
              title: 'Accept support invitation',
              subtitle: 'Help an artisan with their business using a code',
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const AcceptSupportInvitationScreen())),
            ),

          if (auth.isSupporterContext && auth.activeGrant != null)
            _MenuCard(
              icon: Icons.verified_user_outlined,
              title: 'Supporting ${auth.activeGrant!.artisanName}',
              subtitle: 'Allowed: ${auth.activeGrant!.scopeSummary}. '
                  'Account settings stay with the owner.',
            ),

          _MenuCard(
            icon: Icons.translate,
            title: context.tr('language'),
            subtitle: context.tr('language_sub'),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const LanguageSelectionScreen(fromProfile: true))),
          ),
          if (auth.availableContextCount > 1)
            _MenuCard(
              icon: Icons.swap_horiz,
              title: 'Switch context',
              subtitle: 'Continue as buyer, artisan or supporter',
              onTap: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
                auth.switchContext();
              },
            ),

          const SizedBox(height: 24),
          OutlinedButton(
            onPressed: () => _confirmSignOut(context, auth),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.error,
              side: const BorderSide(color: AppColors.error),
            ),
            child: Text(context.tr('sign_out')),
          ),
        ],
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const _MenuCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: AppColors.primary),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: onTap != null ? const Icon(Icons.chevron_right) : null,
      ),
    );
  }
}
