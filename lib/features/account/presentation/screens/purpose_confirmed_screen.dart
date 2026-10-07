import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/shared_models/user_model.dart';
import '../state/auth_provider.dart';
import '../widgets/status_screen.dart';

// frames 16 ("You're all set!") and 17 ("Your artisan setup has started!")
class PurposeConfirmedScreen extends StatelessWidget {
  const PurposeConfirmedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final selling = auth.purposeJustChosen == AccountPurpose.sell;

    return StatusScreen(
      icon: Icons.check,
      title: selling ? 'Your artisan setup has started!' : "You're all set!",
      message: selling
          ? "Next, let's complete your profile to showcase your crafts."
          : 'Start exploring handmade crafts from across Sri Lanka.',
      primaryLabel: selling ? 'Continue to Profile' : 'Continue to Home',
      onPrimary: auth.finishPurposeConfirmation,
    );
  }
}
