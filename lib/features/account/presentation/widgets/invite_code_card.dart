import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/shared_models/support_models.dart';
import '../../../../core/utils/phone_utils.dart';

// invite code + how the family member uses it + copy button
// (no SMS service, so the artisan sends it themselves - DEVIATIONS DV3)
class InviteCodeCard extends StatelessWidget {
  final SupportInviteModel invite;
  const InviteCodeCard({super.key, required this.invite});

  String get _firstName => invite.inviteeName.split(' ').first;
  String get _validUntil => DateFormat('d MMM').format(invite.expiresAt);

  String get _message =>
      'Hi $_firstName, ${invite.artisanName} invited you to help with their shop on '
      'HASTHAKALA. Sign in with your own account, go to Profile > Accept support '
      'invitation, and enter code ${invite.code} with your phone number '
      '${PhoneUtils.display(invite.phone)}. The code works until $_validUntil.';

  Future<void> _copy(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: _message));
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Invitation copied. Paste it into WhatsApp or SMS.')));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.primary, width: 1.5),
          ),
          child: Column(
            children: [
              const Text('Invitation code', style: TextStyle(color: AppColors.textSecondary)),
              const SizedBox(height: 4),
              Text(invite.code.split('').join(' '),
                  style: const TextStyle(
                      fontSize: 32, fontWeight: FontWeight.w700, letterSpacing: 2)),
              Text('Valid until $_validUntil',
                  style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Text('How $_firstName joins:', style: const TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 6),
        const Text('1. Sign in to HASTHAKALA with their own account.'),
        const Text('2. Open Profile > Accept support invitation.'),
        Text('3. Enter this code and the phone number ${PhoneUtils.display(invite.phone)}.'),
        const SizedBox(height: 14),
        OutlinedButton.icon(
          icon: const Icon(Icons.copy_rounded),
          label: const Text('Copy invitation message'),
          onPressed: () => _copy(context),
        ),
      ],
    );
  }
}
