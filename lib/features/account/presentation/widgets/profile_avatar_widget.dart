import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

// round photo, or the first letter of the name when there is no photo
class ProfileAvatarWidget extends StatelessWidget {
  final String? imageUrl;
  final String name;
  final double radius;
  final VoidCallback? onCameraTap;

  const ProfileAvatarWidget({
    super.key,
    this.imageUrl,
    required this.name,
    this.radius = 48,
    this.onCameraTap,
  });

  @override
  Widget build(BuildContext context) {
    final avatar = Container(
      // light ring so the avatar stands out on the cover photo
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.surface,
        border: Border.all(color: AppColors.border),
      ),
      child: CircleAvatar(
        radius: radius,
        backgroundColor: AppColors.secondaryLight,
        backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
        child: imageUrl == null
            ? Text(
                name.isNotEmpty ? name[0].toUpperCase() : 'H',
                style: TextStyle(
                  fontSize: radius * 0.8,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryDark,
                ),
              )
            : null,
      ),
    );

    if (onCameraTap == null) return avatar;
    return Center(
      child: GestureDetector(
        onTap: onCameraTap,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            avatar,
            Positioned(
              right: -2,
              bottom: -2,
              child: const CircleAvatar(
                radius: 16,
                backgroundColor: AppColors.primary,
                child: Icon(Icons.camera_alt,
                    size: 16, color: AppColors.onPrimary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
