import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/shared_models/support_models.dart';
import '../state/auth_provider.dart';
import '../state/family_support_provider.dart';
import 'add_support_user_screen.dart';
import 'support_user_details_screen.dart';


/// READ: authorised support users + pending invitations.
/// DELETE: cancel a pending invitation.
class FamilyAssistanceScreen extends StatefulWidget {
  const FamilyAssistanceScreen({super.key});

  @override
  State<FamilyAssistanceScreen> createState() => _FamilyAssistanceScreenState();
}

class _FamilyAssistanceScreenState extends State<FamilyAssistanceScreen> {
  late final Stream<List<SupportGrantModel>> _grants;
  late final Stream<List<SupportInviteModel>> _invites;

  @override
  void initState() {
    super.initState();
    final artisanId = context.read<AuthProvider>().currentUser!.uid;
    final support = context.read<FamilySupportProvider>();
    _grants = support.grantsFor(artisanId);
    _invites = support.pendingInvitesFor(artisanId);
  }

  Future<void> _cancelInvite(SupportInviteModel invite) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Cancel invitation?'),
        content: Text('${invite.inviteeName} will no longer be able to use code ${invite.code}.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Keep')),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Cancel invitation'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    final support = context.read<FamilySupportProvider>();
    final ok = await support.cancelInvitation(invite.code);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(ok ? 'Invitation cancelled' : support.errorMessage ?? 'Please try again.'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Family Assistance')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text('Authorise trusted family members to support your business.',
              style: TextStyle(color: AppColors.textSecondary)),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            icon: const Icon(Icons.person_add_alt_1_outlined),
            label: const Text('Add Support User'),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const AddSupportUserScreen())),
          ),
          const SizedBox(height: 24),
          const Text('Authorised Support Users',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
          const SizedBox(height: 10),
          StreamBuilder<List<SupportGrantModel>>(
            stream: _grants,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const _InfoText('Support users could not be loaded. Check your connection.');
              }
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              final active = snapshot.data!.where((g) => g.isActive).toList();
              if (active.isEmpty) {
                return const _InfoText('No support users yet. Tap "Add Support User" to invite someone.');
              }
              return Column(
                children: active
                    .map((g) => _PersonTile(
                          name: g.supporterName,
                          detail: g.relationship,
                          chip: 'Active',
                          chipColor: AppColors.accent,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => SupportUserDetailsScreen(grant: g)),
                          ),
                        ))
                    .toList(),
              );
            },
          ),
          StreamBuilder<List<SupportInviteModel>>(
            stream: _invites,
            builder: (context, snapshot) {
              final invites = snapshot.data ?? const [];
              if (invites.isEmpty) return const SizedBox.shrink();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text('Pending Invitations',
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                  const SizedBox(height: 10),
                  ...invites.map((i) => _PersonTile(
                        name: i.inviteeName,
                        detail: i.isExpired ? 'Expired - cancel and invite again' : 'Code ${i.code}',
                        chip: i.isExpired ? 'Expired' : 'Pending',
                        chipColor: i.isExpired ? AppColors.error : AppColors.secondaryDark,
                        trailing: IconButton(
                          tooltip: 'Cancel invitation',
                          icon: const Icon(Icons.close, color: AppColors.error),
                          onPressed: () => _cancelInvite(i),
                        ),
                      )),
                ],
              );
            },
          ),
          const SizedBox(height: 20),
          const _InfoText('Support users can help only in areas you authorise.'),
        ],
      ),
    );
  }
}

class _InfoText extends StatelessWidget {
  final String text;
  const _InfoText(this.text);

  @override
  Widget build(BuildContext context) =>
      Text(text, style: const TextStyle(color: AppColors.textSecondary));
}

class _PersonTile extends StatelessWidget {
  final String name;
  final String detail;
  final String chip;
  final Color chipColor;
  final VoidCallback? onTap;
  final Widget? trailing;

  const _PersonTile({
    required this.name,
    required this.detail,
    required this.chip,
    required this.chipColor,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        onTap: onTap,
        leading: const CircleAvatar(
          backgroundColor: AppColors.divider,
          child: Icon(Icons.person_outline, color: AppColors.textSecondary),
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(detail),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: chipColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(chip,
                  style: TextStyle(color: chipColor, fontSize: 12, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
        trailing: trailing ?? (onTap != null ? const Icon(Icons.chevron_right) : null),
      ),
    );
  }
}
