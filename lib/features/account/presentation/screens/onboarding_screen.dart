import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/localization/tr.dart';
import '../state/onboarding_provider.dart';

//  first-launch intro : Shown once, then the sign in screen.
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final onboarding = context.read<OnboardingProvider>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: TextButton(onPressed: onboarding.markSeen, child: Text(context.tr('skip'))),
              ),
              Text(context.tr('intro_title'),
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700, height: 1.25)),
              const Spacer(),
              // TODO(I01 UI): replace with the artisan photo from the hi-fi
              Center(child: Image.asset('assets/images/hasthakala_logo.png', width: 220)),
              const Spacer(),
              Text(context.tr('intro_line1'),
                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
              const SizedBox(height: 4),
              Text(context.tr('intro_line2'),
                  style: const TextStyle(color: AppColors.textSecondary)),
              const SizedBox(height: 24),
              ElevatedButton(onPressed: onboarding.markSeen, child: Text(context.tr('get_started'))),
            ],
          ),
        ),
      ),
    );
  }
}
