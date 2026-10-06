import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/localization/language_provider.dart';
import '../../../../core/localization/tr.dart';

// I01 Choose Language (hi-fi frame 1). Used on first launch and from Profile.
class LanguageSelectionScreen extends StatelessWidget {
  final bool fromProfile;
  const LanguageSelectionScreen({super.key, this.fromProfile = false});

  static const _options = [
    ('si', 'සිං', 'සිංහල', 'Sinhala'),
    ('en', 'En', 'English', 'English'),
    ('ta', 'த', 'தமிழ்', 'Tamil'),
  ];

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<LanguageProvider>();

    Future<void> onContinue() async {
      await lang.confirm();
      if (!context.mounted || !fromProfile) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(context.tr('language_saved'))));
      Navigator.pop(context);
    }

    return Scaffold(
      appBar: fromProfile ? AppBar() : null,
      body: Stack(
        children: [
          // soft background shapes in the brand colours
          Positioned(
            top: -90,
            right: -70,
            child: _Blob(size: 240, color: AppColors.secondary.withValues(alpha: 0.12)),
          ),
          Positioned(
            bottom: -110,
            left: -80,
            child: _Blob(size: 280, color: AppColors.primary.withValues(alpha: 0.10)),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (!fromProfile) const SizedBox(height: 12),
                  Center(child: Image.asset('assets/images/hasthakala_logo.png', width: 96)),
                  const SizedBox(height: 20),
                  Text(context.tr('choose_language'),
                      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 6),
                  Text(context.tr('choose_language_sub'),
                      style: const TextStyle(color: AppColors.textSecondary)),
                  const SizedBox(height: 24),
                  for (final o in _options) ...[
                    _LanguageCard(
                      badge: o.$2,
                      nativeName: o.$3,
                      englishName: o.$4,
                      selected: lang.code == o.$1,
                      onTap: () => lang.preview(o.$1),
                    ),
                    const SizedBox(height: 12),
                  ],
                  const Spacer(),
                  Text(context.tr('language_change_later'),
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                  const SizedBox(height: 12),
                  ElevatedButton(onPressed: onContinue, child: Text(context.tr('continue'))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Blob extends StatelessWidget {
  final double size;
  final Color color;
  const _Blob({required this.size, required this.color});

  @override
  Widget build(BuildContext context) =>
      Container(width: size, height: size, decoration: BoxDecoration(color: color, shape: BoxShape.circle));
}

class _LanguageCard extends StatelessWidget {
  final String badge;
  final String nativeName;
  final String englishName;
  final bool selected;
  final VoidCallback onTap;

  const _LanguageCard({
    required this.badge,
    required this.nativeName,
    required this.englishName,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      selected: selected,
      button: true,
      label: '$nativeName, $englishName',
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: selected ? AppColors.primary.withValues(alpha: 0.08) : AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected ? AppColors.primary : AppColors.border,
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: selected ? AppColors.primary : AppColors.divider,
                child: Text(badge,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: selected ? AppColors.onPrimary : AppColors.textPrimary)),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(nativeName,
                        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
                    if (nativeName != englishName)
                      Text(englishName, style: const TextStyle(color: AppColors.textSecondary)),
                  ],
                ),
              ),
              Icon(
                selected ? Icons.check_circle : Icons.radio_button_unchecked,
                color: selected ? AppColors.primary : AppColors.textMuted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
