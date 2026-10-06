import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/auth_provider.dart';
import '../widgets/status_screen.dart';

// I01 "Account Created!" (hi-fi frame 14)
class AccountCreatedScreen extends StatelessWidget {
  const AccountCreatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StatusScreen(
      icon: Icons.check,
      title: 'Account Created!',
      message: "Welcome to HASTHAKALA. Let's get started on your journey.",
      primaryLabel: 'Continue',
      onPrimary: context.read<AuthProvider>().continueAfterAccountCreated,
    );
  }
}
