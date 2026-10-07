import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/localization/tr.dart';
import '../state/onboarding_provider.dart';

// I01 intro, only on first launch. Three short pages you can swipe through.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageController = PageController();
  int _page = 0;

  static const _pages = [
    ('intro_title', 'intro_line1', 'intro_line2'),
    ('intro2_title', 'intro2_line', null),
    ('intro3_title', 'intro3_line', null),
  ];

  bool get _isLast => _page == _pages.length - 1;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _next() {
    if (_isLast) {
      context.read<OnboardingProvider>().markSeen();
    } else {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 350), curve: Curves.easeOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    final onboarding = context.read<OnboardingProvider>();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Skip stays in the same place on every page
            SizedBox(
              height: 52,
              child: Align(
                alignment: Alignment.centerRight,
                child: AnimatedOpacity(
                  opacity: _isLast ? 0 : 1,
                  duration: const Duration(milliseconds: 200),
                  child: TextButton(
                    onPressed: _isLast ? null : onboarding.markSeen,
                    child: Text(context.tr('skip')),
                  ),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (i) => setState(() => _page = i),
                itemBuilder: (context, i) {
                  final p = _pages[i];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        Expanded(child: _IntroArt(page: i)),
                        const SizedBox(height: 32),
                        Text(
                          context.tr(p.$1),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w700, height: 1.3),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          p.$3 == null
                              ? context.tr(p.$2)
                              : '${context.tr(p.$2)}\n${context.tr(p.$3!)}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: AppColors.textSecondary, fontSize: 15, height: 1.5),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            _PageDots(count: _pages.length, current: _page),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _next,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(context.tr(_isLast ? 'get_started' : 'next')),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_forward_rounded, size: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PageDots extends StatelessWidget {
  final int count;
  final int current;
  const _PageDots({required this.count, required this.current});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < count; i++)
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: i == current ? 24 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: i == current ? AppColors.primary : AppColors.border,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
      ],
    );
  }
}

// picture area for each page, drawn with the brand colours
class _IntroArt extends StatelessWidget {
  final int page;
  const _IntroArt({required this.page});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.secondaryLight.withValues(alpha: 0.35),
            AppColors.background,
          ],
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // leaves in the corners, like the hi-fi decorations
          Positioned(
            top: 18,
            left: 18,
            child: Transform.rotate(
              angle: -0.5,
              child: Icon(Icons.eco, size: 56, color: AppColors.secondary.withValues(alpha: 0.25)),
            ),
          ),
          Positioned(
            bottom: 18,
            right: 18,
            child: Transform.rotate(
              angle: 2.4,
              child: Icon(Icons.eco, size: 64, color: AppColors.primary.withValues(alpha: 0.18)),
            ),
          ),
          switch (page) {
            0 => const _LogoArt(),
            1 => const _TrustArt(),
            _ => const _OrdersArt(),
          },
        ],
      ),
    );
  }
}

class _LogoArt extends StatelessWidget {
  const _LogoArt();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.18),
            blurRadius: 40,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: Image.asset('assets/images/hasthakala_logo.png', width: 210),
    );
  }
}

class _TrustArt extends StatelessWidget {
  const _TrustArt();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            color: AppColors.surface,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.accent, width: 3),
          ),
          child: const Icon(Icons.verified_rounded, size: 84, color: AppColors.accent),
        ),
        const SizedBox(height: 18),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            5,
            (_) => const Icon(Icons.star_rounded, color: AppColors.secondary, size: 30),
          ),
        ),
      ],
    );
  }
}

class _OrdersArt extends StatelessWidget {
  const _OrdersArt();

  Widget _bubble(IconData icon, Color color) {
    return Container(
      width: 86,
      height: 86,
      decoration: BoxDecoration(
        color: AppColors.surface,
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 2.5),
      ),
      child: Icon(icon, size: 40, color: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _bubble(Icons.receipt_long_rounded, AppColors.primary),
        const SizedBox(height: 14),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _bubble(Icons.chat_bubble_outline_rounded, AppColors.secondaryDark),
            const SizedBox(width: 22),
            _bubble(Icons.local_shipping_outlined, AppColors.accent),
          ],
        ),
      ],
    );
  }
}
