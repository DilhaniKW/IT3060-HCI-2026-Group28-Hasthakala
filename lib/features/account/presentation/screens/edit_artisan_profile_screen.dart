import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/craft_categories.dart';
import '../../../../core/shared_models/artisan_profile_model.dart';
import '../state/artisan_profile_provider.dart';
import '../state/auth_provider.dart';
import 'profile_updated_screen.dart';

// I05 Edit Artisan Profile (+ saving, save failed, offline, discard states)
class EditArtisanProfileScreen extends StatefulWidget {
  final ArtisanProfileModel profile;
  const EditArtisanProfileScreen({super.key, required this.profile});

  @override
  State<EditArtisanProfileScreen> createState() => _EditArtisanProfileScreenState();
}

class _EditArtisanProfileScreenState extends State<EditArtisanProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _about;
  late final TextEditingController _location;
  String? _craftType;

  @override
  void initState() {
    super.initState();
    final p = widget.profile;
    _name = TextEditingController(text: p.displayName)..addListener(_refresh);
    _about = TextEditingController(text: p.about)..addListener(_refresh);
    _location = TextEditingController(text: p.location)..addListener(_refresh);
    _craftType = p.craftType.isEmpty ? null : p.craftType;
  }

  void _refresh() => setState(() {});

  @override
  void dispose() {
    _name.dispose();
    _about.dispose();
    _location.dispose();
    super.dispose();
  }

  bool get _hasChanges {
    final p = widget.profile;
    return _name.text.trim() != p.displayName ||
        _about.text.trim() != p.about ||
        _location.text.trim() != p.location ||
        (_craftType ?? '') != p.craftType;
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final updated = widget.profile.copyWith(
      displayName: _name.text.trim(),
      craftType: _craftType,
      about: _about.text.trim(),
      location: _location.text.trim(),
    );
    final auth = context.read<AuthProvider>();
    final result = await context.read<ArtisanProfileProvider>().save(updated);
    if (!mounted) return;
    if (result == ProfileSaveResult.saved) await auth.reloadCurrentUser();
    if (!mounted) return;

    switch (result) {
      case ProfileSaveResult.saved:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => ProfileUpdatedScreen(artisanId: updated.artisanUid)),
        );
      case ProfileSaveResult.failed:
        _showRetryDialog(
          icon: Icons.error_outline,
          title: "We couldn't save your changes",
          message: 'Your information has not been lost. Please try again.',
        );
      case ProfileSaveResult.offline:
        _showRetryDialog(
          icon: Icons.wifi_off,
          title: "You're offline",
          message: "Changes can't be saved right now. Your edits are still here.",
        );
    }
  }

  Future<void> _showRetryDialog({
    required IconData icon,
    required String title,
    required String message,
  }) async {
    final retry = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        icon: Icon(icon, color: AppColors.error),
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Keep Editing')),
          ElevatedButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Try Again')),
        ],
      ),
    );
    if (retry == true && mounted) _save();
  }

  Future<bool> _confirmDiscard() async {
    final discard = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        icon: const Icon(Icons.warning_amber_rounded, color: AppColors.secondary),
        title: const Text('Discard changes?'),
        content: const Text('You have unsaved profile changes. Are you sure you want to leave?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Discard'),
          ),
          ElevatedButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Keep Editing')),
        ],
      ),
    );
    return discard ?? false;
  }

  Widget _section(String text) => Padding(
        padding: const EdgeInsets.only(top: 18, bottom: 8),
        child: Text(text.toUpperCase(),
            style: const TextStyle(
                color: AppColors.primary, fontWeight: FontWeight.w700, fontSize: 12)),
      );

  @override
  Widget build(BuildContext context) {
    final saving = context.watch<ArtisanProfileProvider>().isSaving;

    return PopScope(
      canPop: !_hasChanges || saving,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final navigator = Navigator.of(context);
        if (await _confirmDiscard()) navigator.pop();
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Edit Artisan Profile')),
        body: Stack(
          children: [
            Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  _section('Profile photo'),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: AppColors.secondaryLight,
                        child: Text(
                          _name.text.isNotEmpty ? _name.text[0].toUpperCase() : '?',
                          style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary),
                        ),
                      ),
                      const SizedBox(width: 14),
                      // photo upload needs Cloud Storage (DEVIATIONS DV6)
                      const Expanded(
                        child: Text('Photo upload will be available soon.',
                            style: TextStyle(color: AppColors.textSecondary)),
                      ),
                    ],
                  ),
                  _section('Basic information'),
                  TextFormField(
                    controller: _name,
                    decoration: const InputDecoration(labelText: 'Artisan Name'),
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? 'Artisan name is required.' : null,
                  ),
                  const SizedBox(height: 14),
                  DropdownButtonFormField<String>(
                    initialValue: _craftType,
                    decoration: const InputDecoration(labelText: 'Craft Type'),
                    hint: const Text('Select craft type'),
                    items: CraftCategories.all
                        .map((c) => DropdownMenuItem(value: c.key, child: Text(c.label)))
                        .toList(),
                    onChanged: (v) => setState(() => _craftType = v),
                    validator: (v) => v == null ? 'Please select a craft type.' : null,
                  ),
                  _section('About my craft'),
                  TextFormField(
                    controller: _about,
                    maxLines: 4,
                    decoration: const InputDecoration(labelText: 'About My Craft'),
                    validator: (v) => (v == null || v.trim().length < 10)
                        ? 'Please write a short description (10+ characters).'
                        : null,
                  ),
                  _section('Location'),
                  TextFormField(
                    controller: _location,
                    decoration: const InputDecoration(labelText: 'General Location'),
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? 'Please enter your location.' : null,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: (_hasChanges && !saving) ? _save : null,
                    child: const Text('Save Changes'),
                  ),
                ],
              ),
            ),
            if (saving)
              Container(
                color: AppColors.background,
                alignment: Alignment.center,
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(color: AppColors.primary),
                    SizedBox(height: 16),
                    Text('Saving your profile...',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                    SizedBox(height: 6),
                    Text('Please wait while we update your information.',
                        style: TextStyle(color: AppColors.textSecondary)),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
