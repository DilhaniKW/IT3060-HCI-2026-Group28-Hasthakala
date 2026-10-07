import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/shared_models/support_models.dart';
import '../state/family_support_provider.dart';
import '../widgets/support_scope_toggles.dart';
import 'access_revoked_screen.dart';

// Support User Details (owner).
// update: permissions ("Access updated"). update: revoke (with confirmation).
class SupportUserDetailsScreen extends StatefulWidget {
  final SupportGrantModel grant;
  const SupportUserDetailsScreen({super.key, required this.grant});

  @override
  State<SupportUserDetailsScreen> createState() => _SupportUserDetailsScreenState();
}

class _SupportUserDetailsScreenState extends State<SupportUserDetailsScreen> {
  late SupportScopes _savedScopes;
  late SupportScopes _scopes;

  @override
  void initState() {
    super.initState();
    _savedScopes = widget.grant.scopes;
    _scopes = widget.grant.scopes;
  }

  bool get _hasChanges => !_scopes.sameAs(_savedScopes);

  Future<void> _update() async {
    if (!_scopes.hasAny) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Keep at least one activity on, or use Revoke Access instead.')));
      return;
    }
    final support = context.read<FamilySupportProvider>();
    final ok = await support.updateAccess(widget.grant.id, _scopes);
    if (!mounted) return;
    if (ok) setState(() => _savedScopes = _scopes);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(ok ? 'Access updated' : support.errorMessage ?? 'Please try again.')));
  }

  Future<void> _revoke() async {
    final name = widget.grant.supporterName.split(' ').first;
    final artisan = widget.grant.artisanName;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Revoke access?'),
        content: Text('$name will no longer be able to access $artisan\'s authorised business functions.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Revoke Access'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    final support = context.read<FamilySupportProvider>();
    final ok = await support.revokeAccess(widget.grant.id);
    if (!mounted) return;
    if (ok) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => AccessRevokedScreen(supporterName: name)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(support.errorMessage ?? 'Please try again.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final support = context.watch<FamilySupportProvider>();
    final g = widget.grant;

    return Scaffold(
      appBar: AppBar(title: const Text('Support User Details')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Card(
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: AppColors.divider,
                child: Icon(Icons.person_outline, color: AppColors.textSecondary),
              ),
              title: Text(g.supporterName, style: const TextStyle(fontWeight: FontWeight.w600)),
              subtitle: Text('${g.relationship}  |  ${g.isActive ? 'Active' : 'Revoked'}'),
            ),
          ),
          const SizedBox(height: 20),
          const Text('Support Access',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
          const SizedBox(height: 10),
          SupportScopeToggles(
            scopes: _scopes,
            onChanged: support.isSaving ? null : (s) => setState(() => _scopes = s),
          ),
          const SizedBox(height: 10),
          const Text('Owner controls access. Sensitive account functions remain owner-only.',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: (support.isSaving || !_hasChanges) ? null : _update,
            child: const Text('Update Access'),
          ),
          const SizedBox(height: 10),
          OutlinedButton(
            onPressed: support.isSaving ? null : _revoke,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.error,
              side: const BorderSide(color: AppColors.error),
            ),
            child: const Text('Revoke Access'),
          ),
        ],
      ),
    );
  }
}
