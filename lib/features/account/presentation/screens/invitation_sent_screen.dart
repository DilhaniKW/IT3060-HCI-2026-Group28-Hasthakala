import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/shared_models/support_models.dart';
import '../widgets/invite_code_card.dart';
import 'add_support_user_screen.dart';

///  Invitation sent. Shows the 6-digit code (decision D4: no SMS backend, so the owner shares the code in person or by phone).
class InvitationSentScreen extends StatelessWidget {
  final SupportInviteModel invite;
  const InvitationSentScreen({super.key, required this.invite});

  @override
  Widget build(BuildContext context) {
    final firstName = invite.inviteeName.split(' ').first;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.check_circle, size: 64, color: AppColors.accent),
              const SizedBox(height: 16),
              const Text('Invitation sent',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              Text(
                'Send this code to $firstName so they can join as your support user.',
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 20),
              InviteCodeCard(invite: invite),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Back to Family Assistance'),
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                onPressed: () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const AddSupportUserScreen())),
                child: const Text('Add Another User'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
