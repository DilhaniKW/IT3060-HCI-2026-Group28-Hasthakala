import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/input_validators.dart';
import '../state/auth_provider.dart';

// I01 Create Account. Shop/Sell is chosen on the next screen.
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _hidePassword = true;
  bool _hideConfirm = true;
  bool _acceptedTerms = false;
  String? _termsError;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _create() async {
    final formOk = _formKey.currentState!.validate();
    setState(() => _termsError =
        _acceptedTerms ? null : 'Please agree to the Terms & Conditions to continue.');
    if (!formOk || !_acceptedTerms) return;

    final auth = context.read<AuthProvider>();
    final ok = await auth.createAccount(
      email: _emailController.text.trim(),
      password: _passwordController.text,
      displayName: _nameController.text.trim(),
    );
    // AuthGate shows "Account Created!" underneath this screen
    if (ok && mounted) Navigator.of(context).popUntil((route) => route.isFirst);
  }

  void _showTerms() {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Terms & Conditions'),
        content: const SingleChildScrollView(
          child: Text(
            'HASTHAKALA is a student project marketplace (IT3060, Group 28).\n\n'
            '- Use accurate information about yourself and your products.\n'
            '- Only share support access with people you trust.\n'
            '- Test accounts and data may be removed at the end of the project.\n'
            '- Your data is stored in Firebase and used only for this app.',
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Close')),
        ],
      ),
    );
  }

  InputDecoration _passwordDecoration(String label, bool hidden, VoidCallback toggle) {
    return InputDecoration(
      labelText: label,
      suffixIcon: IconButton(
        tooltip: hidden ? 'Show password' : 'Hide password',
        icon: Icon(hidden ? Icons.visibility_outlined : Icons.visibility_off_outlined),
        onPressed: toggle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
          children: [
            const Text('Create Your Account',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            const Text('Join our community of artisans and craft lovers.',
                style: TextStyle(color: AppColors.textSecondary)),
            const SizedBox(height: 24),
            if (auth.errorMessage != null) ...[
              Text(auth.errorMessage!, style: const TextStyle(color: AppColors.error)),
              const SizedBox(height: 12),
            ],
            TextFormField(
              controller: _nameController,
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'Full Name'),
              validator: (v) =>
                  (v == null || v.trim().length < 2) ? 'Please enter your full name' : null,
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'Email Address'),
              validator: InputValidators.validateEmail,
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _passwordController,
              obscureText: _hidePassword,
              textInputAction: TextInputAction.next,
              decoration: _passwordDecoration(
                  'Password', _hidePassword, () => setState(() => _hidePassword = !_hidePassword)),
              validator: InputValidators.validatePassword,
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _confirmController,
              obscureText: _hideConfirm,
              decoration: _passwordDecoration('Confirm Password', _hideConfirm,
                  () => setState(() => _hideConfirm = !_hideConfirm)),
              validator: (v) =>
                  v != _passwordController.text ? 'Passwords do not match' : null,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Checkbox(
                  value: _acceptedTerms,
                  onChanged: (v) => setState(() {
                    _acceptedTerms = v ?? false;
                    if (_acceptedTerms) _termsError = null;
                  }),
                ),
                const Text('I agree to the '),
                GestureDetector(
                  onTap: _showTerms,
                  child: const Text('Terms & Conditions',
                      style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline)),
                ),
              ],
            ),
            if (_termsError != null)
              Text(_termsError!, style: const TextStyle(color: AppColors.error, fontSize: 12)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: auth.isLoading ? null : _create,
              child: auth.isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.onPrimary))
                  : const Text('Create Account'),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account?'),
                TextButton(
                  onPressed: () {
                    auth.clearError();
                    Navigator.pop(context);
                  },
                  child: const Text('Sign In'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
