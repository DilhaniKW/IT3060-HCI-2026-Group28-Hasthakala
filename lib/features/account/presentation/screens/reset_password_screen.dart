import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/input_validators.dart';
import '../state/auth_provider.dart';
import '../widgets/status_screen.dart';

// I01 Reset Password (18) + "Check your email" state
class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _sent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    if (!_formKey.currentState!.validate()) return;
    final ok = await context.read<AuthProvider>().sendPasswordReset(_emailController.text.trim());
    if (ok && mounted) setState(() => _sent = true);
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    if (_sent) {
      return StatusScreen(
        icon: Icons.mark_email_read_outlined,
        title: 'Check your email',
        message: 'If an account exists for ${_emailController.text.trim()}, '
            'we sent password recovery instructions to it.',
        primaryLabel: 'Back to Sign In',
        onPrimary: () => Navigator.pop(context),
        secondaryLabel: 'Resend',
        onSecondary: _send,
      );
    }

    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
          children: [
            const Text('Reset Your Password',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            const Text("We'll send you a link to reset your password.",
                style: TextStyle(color: AppColors.textSecondary)),
            const SizedBox(height: 24),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: 'Email Address'),
              validator: InputValidators.validateEmail,
            ),
            if (auth.errorMessage != null) ...[
              const SizedBox(height: 10),
              Text(auth.errorMessage!, style: const TextStyle(color: AppColors.error)),
            ],
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: auth.isLoading ? null : _send,
              child: const Text('Send Reset Link'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Back to Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}
