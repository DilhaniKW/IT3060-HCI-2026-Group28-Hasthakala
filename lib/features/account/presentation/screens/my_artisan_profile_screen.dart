import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/craft_categories.dart';
import '../../../../core/shared_models/artisan_profile_model.dart';
import '../../../discovery/presentation/screens/public_artisan_profile_screen.dart';
import '../state/artisan_profile_provider.dart';
import '../state/auth_provider.dart';
import 'edit_artisan_profile_screen.dart';

// I05_HF_02 My Artisan Profile
class MyArtisanProfileScreen extends StatefulWidget {
  const MyArtisanProfileScreen({super.key});

  @override
  State<MyArtisanProfileScreen> createState() => _MyArtisanProfileScreenState();
}

class _MyArtisanProfileScreenState extends State<MyArtisanProfileScreen> {
  late final Stream<ArtisanProfileModel?> _profile;
  late final String _uid;

  @override
  void initState() {
    super.initState();
    _uid = context.read<AuthProvider>().currentUser!.uid;
    _profile = context.read<ArtisanProfileProvider>().watchProfile(_uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Artisan Profile')),
      body: StreamBuilder<ArtisanProfileModel?>(
        stream: _profile,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
                child: Text('Your profile could not be loaded. Check your connection.'));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final p = snapshot.data!;
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Center(
                child: CircleAvatar(
                  radius: 48,
                  backgroundColor: AppColors.secondaryLight,
                  child: Text(
                    p.displayName.isNotEmpty ? p.displayName[0].toUpperCase() : '?',
                    style: const TextStyle(
                        fontSize: 36, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(p.displayName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              Text('${CraftCategories.labelFor(p.craftType)} Artisan',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.location_on_outlined, size: 16, color: AppColors.textSecondary),
                  const SizedBox(width: 4),
                  Text(p.location, style: const TextStyle(color: AppColors.textSecondary)),
                ],
              ),
              if (p.verified) ...[
                const SizedBox(height: 8),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.verified, size: 16, color: AppColors.accent),
                    SizedBox(width: 4),
                    Text('Verified artisan', style: TextStyle(color: AppColors.accent)),
                  ],
                ),
              ],
              const SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('About My Craft',
                          style: TextStyle(fontWeight: FontWeight.w700)),
                      const SizedBox(height: 6),
                      Text(p.about, style: const TextStyle(color: AppColors.textSecondary)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.edit_outlined),
                label: const Text('Edit Profile'),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => EditArtisanProfileScreen(profile: p)),
                ),
              ),
              const SizedBox(height: 10),
              OutlinedButton.icon(
                icon: const Icon(Icons.visibility_outlined),
                label: const Text('Preview Public Profile'),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => PublicArtisanProfileScreen(artisanId: _uid)),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
