import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/shared_models/user_model.dart';
import '../../../../core/utils/input_validators.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../artisan/presentation/screens/artisan_dashboard_screen.dart';
import '../../../discovery/presentation/screens/home_screen.dart';
import '../state/auth_provider.dart';
import '../widgets/role_selector_card.dart';

/// Assigned to: WANIGATHUNGA Y. J.
/// Branch: feature/account-support
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  UserRole _selectedRole = UserRole.buyer;
  bool _isFamilyAssisted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Create Account'),
      body: Consumer<AuthProvider>(
        builder: (context, auth, _) {
          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                const Text(
                  'Select Account Type',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                RoleSelectorCard(
                  role: UserRole.buyer,
                  title: 'Craft Enthusiast / Buyer',
                  description: 'Discover authentic handmade items, order, and support local artisans.',
                  icon: Icons.shopping_bag_outlined,
                  isSelected: _selectedRole == UserRole.buyer,
                  onSelect: () => setState(() => _selectedRole = UserRole.buyer),
                ),
                const SizedBox(height: 10),
                RoleSelectorCard(
                  role: UserRole.artisan,
                  title: 'Sri Lankan Artisan / Maker',
                  description: 'Showcase your heritage craft, sell directly, and connect with buyers.',
                  icon: Icons.brush_outlined,
                  isSelected: _selectedRole == UserRole.artisan,
                  onSelect: () => setState(() => _selectedRole = UserRole.artisan),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  label: 'Full Name / Workshop Name',
                  hint: 'Sunil Gamage Pottery Works',
                  controller: _nameController,
                  validator: (v) => InputValidators.validateRequired(v, 'Name'),
                ),
                const SizedBox(height: 14),
                CustomTextField(
                  label: 'Email Address',
                  hint: 'artisan@hasthakala.lk',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: InputValidators.validateEmail,
                ),
                const SizedBox(height: 14),
                CustomTextField(
                  label: 'Password',
                  hint: '••••••••',
                  obscureText: true,
                  controller: _passwordController,
                  validator: InputValidators.validatePassword,
                ),
                const SizedBox(height: 14),
                CustomTextField(
                  label: 'District / Region',
                  hint: 'e.g. Kandy / Galle / Kegalle',
                  controller: _districtController,
                ),
                if (_selectedRole == UserRole.artisan) ...[
                  const SizedBox(height: 14),
                  CheckboxListTile(
                    title: const Text('Family Assisted Account'),
                    subtitle: const Text('Allow a designated family member or youth to help manage orders & chats'),
                    value: _isFamilyAssisted,
                    activeColor: AppColors.primary,
                    contentPadding: EdgeInsets.zero,
                    onChanged: (val) => setState(() => _isFamilyAssisted = val ?? false),
                  ),
                ],
                const SizedBox(height: 24),
                CustomButton(
                  text: 'Register Account',
                  isLoading: auth.isLoading,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final success = await auth.register(
                        email: _emailController.text,
                        password: _passwordController.text,
                        displayName: _nameController.text,
                        role: _selectedRole,
                        district: _districtController.text,
                        isFamilyAssisted: _isFamilyAssisted,
                      );
                      if (success && mounted) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (_) => _selectedRole == UserRole.artisan
                                ? const ArtisanDashboardScreen()
                                : const HomeScreen(),
                          ),
                          (route) => false,
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
