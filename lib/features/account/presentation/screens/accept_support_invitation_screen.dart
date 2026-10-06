import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/phone_utils.dart';
import '../state/auth_provider.dart';
import '../state/family_support_provider.dart';

// I13 - supporter enters phone number + invite code (see DEVIATIONS DV4)
// creates the support grant, user stays logged in as themselves
class AcceptSupportInvitationScreen extends StatefulWidget {
  const AcceptSupportInvitationScreen({super.key});

  @override
  State<AcceptSupportInvitationScreen> createState() =>
      _AcceptSupportInvitationScreenState();
}

class _AcceptSupportInvitationScreenState extends State<AcceptSupportInvitationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _accept() async {
    if (!_formKey.currentState!.validate()) return;
    final auth = context.read<AuthProvider>();
    final support = context.read<FamilySupportProvider>();
    final user = auth.currentUser!;
    final grant = await support.acceptInvitation(
      code: _codeController.text.trim(),
      phone: PhoneUtils.normalize(_phoneController.text),
      supporterId: user.uid,
      supporterName: user.displayName,
    );
    if (!mounted || grant == null) return;

    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        icon: const Icon(Icons.check_circle, color: AppColors.accent, size: 48),
        title: Text('You are now supporting ${grant.artisanName}'),
        content: Text('You can help with: ${grant.scopeSummary}.\n'
            'Choose "Supporting ${grant.artisanName}" to start.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Continue')),
        ],
      ),
    );
    if (!mounted) return;
    Navigator.of(context).popUntil((route) => route.isFirst);
    await auth.refreshSession();
  }

  @override
  Widget build(BuildContext context) {
    final support = context.watch<FamilySupportProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Accept Support Invitation')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'An artisan can invite you to help with their business. '
              'Ask them for the 6-digit invitation code and enter the phone '
              'number they used for you.',
              style: TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Your phone number',
                hintText: 'e.g. 077 123 4567',
              ),
              validator: PhoneUtils.validate,
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _codeController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              decoration: const InputDecoration(labelText: 'Invitation code'),
              validator: (v) => RegExp(r'^[0-9]{6}$').hasMatch((v ?? '').trim())
                  ? null
                  : 'Enter the 6-digit code',
            ),
            if (support.errorMessage != null) ...[
              const SizedBox(height: 8),
              Text(support.errorMessage!, style: const TextStyle(color: AppColors.error)),
            ],
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: support.isSaving ? null : _accept,
              child: support.isSaving
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.onPrimary),
                    )
                  : const Text('Accept Invitation'),
            ),
            const SizedBox(height: 12),
            const Text(
              'You will keep your own account. You can only help in the areas '
              'the artisan allows, and they can change or remove this at any time.',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
