import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

// round photo, or the first letter of the name when there is no photo
class ProfileAvatarWidget extends StatelessWidget {
  final String? imageUrl;
  final String name;
  final double radius;

  const ProfileAvatarWidget({
    super.key,
    this.imageUrl,
    required this.name,
    this.radius = 48,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
  }
}
