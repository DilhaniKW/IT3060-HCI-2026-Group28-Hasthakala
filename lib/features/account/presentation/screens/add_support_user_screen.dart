import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/shared_models/support_models.dart';
import '../../../../core/utils/phone_utils.dart';
import '../state/auth_provider.dart';
import '../state/family_support_provider.dart';
import '../widgets/support_scope_toggles.dart';
import 'invitation_sent_screen.dart';

/// I13_WF_03 Add Support User (owner). CREATE: supportInvites/{code}.
class AddSupportUserScreen extends StatefulWidget {
  const AddSupportUserScreen({super.key});

  @override
  State<AddSupportUserScreen> createState() => _AddSupportUserScreenState();
}

class _AddSupportUserScreenState extends State<AddSupportUserScreen> {
  static const _relationships = [
    'Family Member',
    'Son / Daughter',
    'Spouse',
    'Sibling',
    'Relative',
  ];

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  String _relationship = _relationships.first;
  SupportScopes _scopes =
      const SupportScopes(products: true, orders: true, communication: true);
  String? _scopeError;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final formOk = _formKey.currentState!.validate();
    setState(() => _scopeError =
        _scopes.hasAny ? null : 'Turn on at least one activity this person may help with');
    if (!formOk || !_scopes.hasAny) return;

    final auth = context.read<AuthProvider>();
    final support = context.read<FamilySupportProvider>();
    final user = auth.currentUser!;
    final invite = await support.sendInvitation(
      artisanId: user.uid,
      artisanName: user.displayName,
      inviteeName: _nameController.text.trim(),
      relationship: _relationship,
      phone: PhoneUtils.normalize(_phoneController.text),
      scopes: _scopes,
    );
    if (!mounted || invite == null) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => InvitationSentScreen(invite: invite)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final support = context.watch<FamilySupportProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Add Support User')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Full Name'),
              textCapitalization: TextCapitalization.words,
              validator: (v) =>
                  (v == null || v.trim().length < 2) ? 'Please enter their full name' : null,
            ),
            const SizedBox(height: 14),
            DropdownButtonFormField<String>(
              initialValue: _relationship,
              decoration: const InputDecoration(labelText: 'Relationship'),
              items: _relationships
                  .map((r) => DropdownMenuItem(value: r, child: Text(r)))
                  .toList(),
              onChanged: (v) => setState(() => _relationship = v ?? _relationship),
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Contact / Phone Number',
                hintText: 'e.g. 077 123 4567',
              ),
              validator: PhoneUtils.validate,
            ),
            const SizedBox(height: 22),
            const Text('Support Access',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
            const SizedBox(height: 10),
            SupportScopeToggles(
              scopes: _scopes,
              onChanged: (s) => setState(() {
                _scopes = s;
                if (s.hasAny) _scopeError = null;
              }),
            ),
            if (_scopeError != null) ...[
              const SizedBox(height: 8),
              Text(_scopeError!, style: const TextStyle(color: AppColors.error)),
            ],
            const SizedBox(height: 10),
            const Text('Sensitive owner account settings remain restricted.',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
            if (support.errorMessage != null) ...[
              const SizedBox(height: 12),
              Text(support.errorMessage!, style: const TextStyle(color: AppColors.error)),
            ],
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: support.isSaving ? null : _send,
              child: support.isSaving
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.onPrimary),
                    )
                  : const Text('Send Invitation'),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: support.isSaving ? null : () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }
}
